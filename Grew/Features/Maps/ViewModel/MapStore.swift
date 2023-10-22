//
//  MapStore.swift
//  Grew
//
//  Created by 마경미 on 19.10.23.
//

import Foundation

import Firebase
import FirebaseFirestoreSwift
import GeoFire
import NMapsMap

final class MapStore: ObservableObject {
    @Published var listItems: Set<Grew> = []
    @Published var filteredListItems: Set<Grew> = []
    @Published var selectedCategory: [GrewMainCategory] = []
    @Published var expandList: Bool = false
    var markers: [NMFMarker] = []

    var myLocation = CLLocation(latitude: 37.541, longitude: 126.986)
    var currentLocation = CLLocation(latitude: 37.541, longitude: 126.986)
    let radiusInM: Double = 50 * 1000
    let mainCategories: [GrewMainCategory] = GrewMainCategory.allCases
    var selectedSymbolTitle: String?
    
    func toggleCategory(category: GrewMainCategory) {
        filteredListItems = []

        if selectedCategory.contains(where: { $0 == category }) {
            selectedCategory.removeAll(where: {$0 == category})
        } else {
            selectedCategory.append(category)
        }
        
        if selectedCategory.isEmpty {
            filteredListItems = listItems
        } else {
            for listItem in listItems {
                if selectedCategory.contains(where: { $0.categoryForIndex == listItem.categoryIndex}) {
                    filteredListItems.insert(listItem)
                }
            }
        }
    }
    
    func fetchNearGrew() {
        let currentLocation = CLLocationCoordinate2D(latitude: currentLocation.coordinate.latitude, longitude: currentLocation.coordinate.longitude)
        let queryBounds = GFUtils.queryBounds(forLocation: currentLocation,
                                              withRadius: radiusInM)
        let queries = queryBounds.map { bound -> Query in
            return Firestore.firestore().collection("grews")
                .order(by: "geoHash")
                .start(at: [bound.startValue])
                .end(at: [bound.endValue])
        }
        
        for query in queries {
            query.getDocuments(completion: filterGrew)
        }
    }
    
    func filterGrew(snapshot: QuerySnapshot?, error: Error?) -> () {
        guard let documents = snapshot?.documents else {
            print("Unable to fetch snapshot data. \(String(describing: error))")
            return
        }
        
        for document in documents {
            do {
                let grew = try Firestore.Decoder().decode(Grew.self, from: document.data())
                
                if let lat = grew.latitude, let lng = grew.longitude,
                   let lat = Double(lat), let lng = Double(lng) {
                    let coordinates = CLLocation(latitude: lat, longitude: lng)
                    let distance = GFUtils.distance(from: currentLocation, to: coordinates)
                    if distance <= radiusInM {
                        DispatchQueue.main.async {
                            self.listItems.insert(grew)
                            self.filteredListItems.insert(grew)
                        }
                    }
                }
            } catch {
                
            }
        }
    }
    
    func clickedSymbol(title: String) {
        filteredListItems = []

        if self.selectedSymbolTitle != nil {
            let temp = listItems.filter({$0.title == title})
            filteredListItems = temp
        } else {
            filteredListItems = listItems
        }
        
        selectedSymbolTitle = title
        expandList = true
    }
}
