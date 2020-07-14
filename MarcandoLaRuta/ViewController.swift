//
//  ViewController.swift
//  MarcandoLaRuta
//
//  Created by rpozzuto on 20/03/2020.
//  Copyright © 2020 rpozzuto. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation


class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var map: MKMapView!
    
     private let manejador = CLLocationManager()
    
    private var localitation: CLLocation? = nil

    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        self.manejador.delegate = self
        self.manejador.desiredAccuracy = kCLLocationAccuracyBest
        self.manejador.distanceFilter = 50
        self.manejador.requestWhenInUseAuthorization()
        self.map.mapType = MKMapType.standard
        
    
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manejador.startUpdatingLocation()
            map.showsUserLocation = true
        } else {
            manejador.stopUpdatingLocation()
            map.showsUserLocation = false

        }
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {

        let punto = CLLocationCoordinate2D()
             
             let pin = MKPointAnnotation()
             pin.title = "(\(String(describing: (manager.location?.coordinate.longitude)!)), \(String(describing: (manager.location?.coordinate.latitude)!)))"
             pin.subtitle = ""
             pin.coordinate = punto
             self.map.addAnnotation(pin)
        
        
        
        if self.localitation == nil {
            self.localitation = manager.location
        }
        else {
            pin.subtitle = "\(String(describing: (manager.location?.distance(from: self.localitation!))!)) m"
            self.localitation = manager.location
        }
        pin.coordinate = (manager.location?.coordinate)!
        self.map.setCenter((manager.location?.coordinate)!, animated: true)
        self.map.addAnnotation(pin)
    }
    

    @IBAction func cambiarMapa(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.map.mapType = MKMapType.standard
            break
        case 1:
            self.map.mapType = MKMapType.satelliteFlyover
            break
        case 2:
            self.map.mapType = MKMapType.hybridFlyover
            break
        default:
            break
        }
    }
    
}

