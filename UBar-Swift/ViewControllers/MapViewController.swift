//
//  MapViewController.swift
//  UBarMap
//
//  Created by Rab Gábor on 2015. 10. 05..
//  Copyright © 2015. Coding Sans. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


// MARK: - Protocol
@objc protocol MapViewControllerDelegate: NSObjectProtocol{
    @objc func mapViewController(controller:MapViewController, didSetLocation: CLLocation)
}

@objc(CSAMapViewController)
class MapViewController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var addressLabel: UILabel!
    var delegate: MapViewControllerDelegate?
    private var locationManager = CLLocationManager()
    private var geoCoder: CLGeocoder!
    private var currentLocation: CLLocation!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        geoCoder = CLGeocoder()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = false
        self.mapView.delegate = self
    }
    
    @IBAction func buttonTouched(sender: UIButton) {
        if let delegate = self.delegate {
            if delegate.respondsToSelector("mapViewController:didSetLocation:") {
                delegate.mapViewController(self, didSetLocation: currentLocation)
            }
        }
    }
    
    private func geoCode(location: CLLocation) {
        geoCoder.cancelGeocode()
        
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            
            guard let placeMarks = data else {
                return
            }
            guard let placeMark: CLPlacemark = placeMarks.first else {
                return
            }
            
            self.currentLocation = placeMark.location
            
            guard let addressList = placeMark.addressDictionary?["FormattedAddressLines"] as? [String] else {
                return
            }
            if addressList.isEmpty {
                return
            }
            
            let addrList = addressList.dropLast()
            let text: String
            if(addrList.count >= 2) {
                text = addrList.dropFirst().joinWithSeparator(", ")
            } else {
                if let firstText = addrList.first {
                    text = firstText
                } else {
                    text = "Unknown address"
                }
            }
            self.addressLabel.text = text
        })
    }
}

// MARK: - MKMapViewDelegate
extension MapViewController: MKMapViewDelegate {
    func mapView(mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let location = CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude)
        geoCode(location)
    }
}

// MARK: - CLLocationManagerDelegate
extension MapViewController: CLLocationManagerDelegate {
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: false)
        self.locationManager.stopUpdatingLocation()
        geoCode(location)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print(error)
    }
}


