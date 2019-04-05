//
//  ViewController.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 11/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var SelectorLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var mapView: GMSMapView!
    var tap: UITapGestureRecognizer?
    var locationManager = CLLocationManager()

        override func viewDidLoad() {
            super.viewDidLoad()
            
            let camera = GMSCameraPosition.camera(withLatitude: 19.486122, longitude:  -99.178634, zoom: 7.0)
            let camera1 = GMSCameraPosition.camera(withLatitude: 19.492563, longitude:  -99.197232, zoom: 12.0)
            let camera2 = GMSCameraPosition.camera(withLatitude: 19.481431, longitude:  -99.191017, zoom: 12.0)
            let camera3 = GMSCameraPosition.camera(withLatitude: 19.479204, longitude:  -99.180576, zoom: 12.0)
            
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            
            //showMarker(position: camera.target)
            showMarkerPolice(position: camera1.target)
            showMarkerPolice(position: camera2.target)
            showMarkerPemex(position: camera3.target)
            drawRectangeOne()
            drawRectangeTwo()
            circle()
            
            tap = UITapGestureRecognizer(target: self, action: #selector(tapDetected(sender:)))
            tap?.numberOfTapsRequired = 1
            mapView?.addGestureRecognizer(tap!)
        }
        
        /*func showMarker(position: CLLocationCoordinate2D){
            let markerUser = GMSMarker()
            markerUser.position = position
            markerUser.title = "Posicion del Usuario"
            //marker.snippet = "San Francisco"
            markerUser.map = mapView
        }*/
    
        func showMarkerPolice(position: CLLocationCoordinate2D){
            let markerPolice = GMSMarker()
            markerPolice.position = position
            markerPolice.title = "Estacion de SEDENA"
            markerPolice.icon = GMSMarker.markerImage(with: UIColor.blue)
            //marker.snippet = "San Francisco"
            markerPolice.map = mapView
        }
    
    
        func showMarkerPemex(position: CLLocationCoordinate2D){
            let markerPemex = GMSMarker()
            markerPemex.position = position
            markerPemex.title = "Estacion de PEMEX"
            markerPemex.icon = GMSMarker.markerImage(with: UIColor.green)
            //marker.snippet = "San Francisco"
            markerPemex.map = mapView
        }
    
    
    @objc func tapDetected(sender: UITapGestureRecognizer) {
        print("marcador")
        //let position: CLLocationCoordinate2D
        let markerIncident = GMSMarker()
        let location = tap!.location(in: mapView)
        let point = mapView.projection.coordinate(for: location)
        markerIncident.position = point
        markerIncident.icon = GMSMarker.markerImage(with: UIColor.black)
        markerIncident.map = mapView
        
    }

    func drawRectangeOne(){
        /* create the path */
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 19.496296, longitude: -99.176417))
        path.add(CLLocationCoordinate2D(latitude: 19.704595, longitude: -98.757756))
        path.add(CLLocationCoordinate2D(latitude: 19.822456, longitude: -98.604544))
        path.add(CLLocationCoordinate2D(latitude: 20.538331, longitude: -97.462762))
        path.add(CLLocationCoordinate2D(latitude: 20.956681, longitude: -97.384892))
        /* show what you have drawn */
        let ducto = GMSPolyline(path: path)
        ducto.strokeColor = .red
        ducto.map = mapView
    }
    
    
   func drawRectangeTwo(){
        /* create the path */
        let pathTwo = GMSMutablePath()
        pathTwo.add(CLLocationCoordinate2D(latitude: 19.598318, longitude: 99.537996))
        pathTwo.add(CLLocationCoordinate2D(latitude: 20.735598, longitude: 99.878621))
        pathTwo.add(CLLocationCoordinate2D(latitude: 20.925051, longitude: 102.072670))
        pathTwo.add(CLLocationCoordinate2D(latitude: 23.312507, longitude: 103.608299))
        pathTwo.add(CLLocationCoordinate2D(latitude: 28.654078, longitude: 105.233852))
        /* show what you have drawn */
        let rectangleTwo = GMSPolyline(path: pathTwo)
        rectangleTwo.strokeColor = .red
        rectangleTwo.map = mapView
    }
    
    
    func circle(){
        let circleCenter = CLLocationCoordinate2D(latitude: 19.496296, longitude: -99.176417)
        let circ = GMSCircle(position: circleCenter, radius: 1000)
        circ.map = mapView
        circ.strokeColor = UIColor.red
    }
    
    
    //Location Manager delegates
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.mapView?.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
}
