//
//  NaverMapView.swift
//  Grew
//
//  Created by 마경미 on 10.10.23.
//

import SwiftUI
import NMapsMap
import CoreLocation

struct NaverMapView: UIViewRepresentable {
    internal func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
    
    func makeUIView(context: Context) -> NMFNaverMapView {
        context.coordinator.getNaverMapView()
    }
    
    func updateUIView(_ uiView: NMFNaverMapView, context: Context) {
        // NaverMapView의 외관 또는 상태를 업데이트합니다.
    }
    
    internal class Coordinator: NSObject, NMFMapViewCameraDelegate, NMFMapViewTouchDelegate {
        private let view = NMFNaverMapView(frame: .zero)
        private var locationManager = CLLocationManager()
        private var currentLocation = CLLocationCoordinate2D(latitude: 37.541, longitude: 126.986)
        
        override init() {
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
    }
}
#Preview {
    NaverMapView()
}
