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

/**
 
 Uber like ViewController that provides current CLLocation 
 upon user tap through delegate.
 
 Usage
 ----
 
 Add "NSLocationWhenInUseUsageDescription" String to Info.plist,
 the user location fetch will work only that way.
 
 Copy the CSAMapViewController storyboard file and this class 
 and copy the relating methods from one of the ViewController classes
 to your project. [MODULE_NAME]-Bridging-Header.h is required 
 if your project is Objective-C.
 
 
 */

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
    
    private func geoCode(location: CLLocation!){
        geoCoder.cancelGeocode()
        geoCoder.reverseGeocodeLocation(location, completionHandler: { (data, error) -> Void in
            guard let placeMarks = data as [CLPlacemark]! else {
                return
            }
            let loc: CLPlacemark = placeMarks[0]
            self.currentLocation = loc.location
            let addressDict: [NSString:NSObject] = loc.addressDictionary as! [NSString:NSObject]
            var addrList = addressDict["FormattedAddressLines"] as! [String]
            addrList.popLast()
            let text: String
            if(addrList.count > 1) {
                text = addrList.dropFirst().joinWithSeparator(", ")
            }else{
                if !addrList.isEmpty {
                    text = addrList[0]
                } else {
                    text = "Unknown address"
                }
            }
            self.writeLabel(text)
        })
    }
    
    private func writeLabel(address: String) {
        addressLabel.text = address
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
        let location = locations.last
        let center = CLLocationCoordinate2D(latitude: location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.005, longitudeDelta: 0.01))
        self.mapView.setRegion(region, animated: false)
        self.locationManager.stopUpdatingLocation()
        geoCode(location)
    }
    
    func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
//        print(error)
    }
}


