//
//  ViewController.swift
//  Maps
//
//  Created by Ahmed on 11/03/2023.
//

import UIKit
import GoogleMaps
import CoreLocation

class ViewController: UIViewController, GMSMapViewDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var map: GMSMapView!
    
    let lat = 30.073050
    let long = 31.227392
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        map.delegate = self
        let camera = GMSCameraPosition(latitude: lat, longitude: long, zoom: 14)
        map.camera = camera
        
        //getMyLocation()
    }
    func getMyLocation(){
        locationManager.delegate = self
        locationManager.requestAlwaysAuthorization()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        map.isMyLocationEnabled = true
        map.settings.myLocationButton = true
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let myLocation = locations.first?.coordinate
        
        let camera = GMSCameraPosition(target: myLocation! , zoom: 14)
        map.animate(to:camera)
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        map.clear()
        var marker = GMSMarker(position: coordinate)
        marker.map = map
        let camera = GMSCameraPosition(target: coordinate, zoom: 14)
        map.animate(to: camera)
    }
    
    func mapView(_ mapView: GMSMapView, didLongPressAt coordinate: CLLocationCoordinate2D) {
        map.clear()
    }
    
    
    func mapView(_ mapView: GMSMapView, didTapPOIWithPlaceID placeID: String, name: String, location: CLLocationCoordinate2D) {
        map.clear()
        let marker = GMSMarker(position: location)
        marker.title = " \(name)"
        marker.map = map 
    }
    
    


}

