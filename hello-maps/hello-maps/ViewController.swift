//
//  ViewController.swift
//  hello-maps
//
//  Created by Mohammad Azam on 8/5/18.
//  Copyright © 2018 Mohammad Azam. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {
    
    @IBOutlet weak var mapView :MKMapView!
    private let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.mapView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.startUpdatingLocation()
        
        self.mapView.showsUserLocation = true
    }
    
    @IBAction func showAddAddressView() {
        
        let alertVC = UIAlertController(title: "Add Address", message: nil, preferredStyle: .alert)
        
        alertVC.addTextField { textField in
            
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { action in
            
            if let textField = alertVC.textFields?.first {
                
                // reverse geocode the address
                self.reverseGeocode(address: textField.text!){ placemark in
                    let startingMapItem = MKMapItem.forCurrentLocation()
                    
                    let destinationPlacemark = MKPlacemark(coordinate: (placemark.location?.coordinate)!)
                    let destinationMapItem = MKMapItem(placemark: destinationPlacemark)
                    let directionsRequest = MKDirectionsRequest()
                    directionsRequest.transportType = .automobile
                    //MKMapItem.openMaps(with: [destinationMapItem], launchOptions: nil)
                    directionsRequest.source = startingMapItem
                    directionsRequest.destination = destinationMapItem
                    let directions = MKDirections(request: directionsRequest)
                    directions.calculate(completionHandler: { (response, error) in
                        if let error = error{
                            print(error.localizedDescription)
                            return
                        }
                        print(response?.routes.count)
                        guard let response = response, let route = response.routes.first else{
                            return
                        }
                        
                        print(response.routes.count)
                        if !route.steps.isEmpty{
                            for step in route.steps{
                                print(step.instructions)
                            }
                        }
                    })
                }
            }
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { action in
            
        }
        
        alertVC.addAction(okAction)
        alertVC.addAction(cancelAction)
        
        self.present(alertVC, animated: true, completion: nil)
    }
    func reverseGeocode(address: String, completion: @escaping (CLPlacemark)->()){
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address){(placemarks, error) in
            
            if let error = error{
                print(error.localizedDescription)
                return
            }
            guard let placemarks = placemarks, let placemark = placemarks.first else{
                return
            }
            completion(placemark)
        }
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let region = MKCoordinateRegion(center: mapView.userLocation.coordinate, span: MKCoordinateSpan(latitudeDelta: 0.008, longitudeDelta: 0.008))
        
        mapView.setRegion(region, animated: true)
    }
    

}

