//
//  MapViewController.swift
//  Tictactoe
//
//  Created by 王益民 on 10/11/16.
//  Copyright © 2016 W&C. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class MapViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var mapView: MKMapView!
    
    var locationManager : CLLocationManager!
    var location: CLLocation! {
        didSet{
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        checkCoreLocationPermission()
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        self.mapView.showsUserLocation = true
    }
    override func viewWillDisappear(_ animated: Bool){
    }
    //location
    func checkCoreLocationPermission(){
        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse{
            locationManager.startUpdatingLocation()
        }else if CLLocationManager.authorizationStatus() == .notDetermined{
            locationManager.requestWhenInUseAuthorization()
        }else if CLLocationManager.authorizationStatus() == .restricted{
            print("authorized to use location service")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = (locations as! [CLLocation]).last
        let center = CLLocationCoordinate2D(latitude:location!.coordinate.latitude, longitude: location!.coordinate.longitude)
        let region = MKCoordinateRegionMake(center, MKCoordinateSpanMake(1, 1))
        self.mapView.setRegion(region, animated: true)
        locationManager.stopUpdatingLocation()
    }
}
