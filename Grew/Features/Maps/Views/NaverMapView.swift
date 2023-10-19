//
//  NaverMapView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI
import NMapsMap
import CoreLocation
import GeoFire
import Firebase
import FirebaseFirestoreSwift

struct NaverMapView: UIViewRepresentable {
    var grewMarkers = [QueryDocumentSnapshot]()
    
    internal func makeCoordinator() -> Coordinator {
        return Coordinator(parentMapView: self)
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // NaverMapView의 외관 또는 상태를 업데이트합니다.
//        
//        uiView.removeOverlays(uiView.locationOverlay)
//        
//        // 새로운 마커를 추가합니다.
//        for marker in markers {
//            marker.mapView = uiView
//        }
    }
    
    internal class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
        private var parentMapView: NaverMapView

        private let view = NMFNaverMapView(frame: .zero)
        private var locationManager = CLLocationManager()
        private var currentLocation = CLLocationCoordinate2D(latitude: 37.541, longitude: 126.986)
        private let radiusInM: Double = 50 * 1000
        
        init(parentMapView: NaverMapView) {
            self.parentMapView = parentMapView
            super.init()
            
            view.showLocationButton = true
            view.mapView.positionMode = .normal
            
            view.mapView.addCameraDelegate(delegate: self)
            view.mapView.touchDelegate = self
            
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
            locationManager.startUpdatingLocation()
            
            let cameraUpdate = NMFCameraUpdate(scrollTo: NMGLatLng(lat: currentLocation.latitude, lng: currentLocation.longitude), zoomTo: 7)
            view.mapView.moveCamera(cameraUpdate)
            cameraUpdate.animation = .easeIn
        }
        
        func mapViewIdle(_ mapView: NMFMapView) {
        }
        
        func mapView(_ mapView: NMFMapView, regionIsChangingWithReason reason: Int) {
        }
        
        func getNaverMapView() -> NMFNaverMapView {
            view
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.last {
                currentLocation.latitude = location.coordinate.latitude
                currentLocation.longitude = location.coordinate.longitude
                print("현재 위치 - 위도: \(currentLocation.latitude), 경도: \(currentLocation.longitude)")
            }
        }
        
        func fetchNearGrew() {
            let queryBounds = GFUtils.queryBounds(forLocation: currentLocation,
                                                  withRadius: radiusInM)
            let queries = queryBounds.map { bound -> Query in
                return Firestore.firestore().collection("cities")
                    .order(by: "geohash")
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
                let lat = document.data()["lat"] as? Double ?? 0
                let lng = document.data()["lng"] as? Double ?? 0
                let coordinates = CLLocation(latitude: lat, longitude: lng)
                let centerPoint = CLLocation(latitude: currentLocation.latitude, longitude: currentLocation.longitude)
                
                // We have to filter out a few false positives due to GeoHash accuracy, but
                // most will match
                let distance = GFUtils.distance(from: centerPoint, to: coordinates)
                if distance <= radiusInM {
                    parentMapView.grewMarkers.append(document)
                }
            }
        }
        
    }
}

#Preview {
    NaverMapView()
}
