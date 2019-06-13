//
//  ViewController.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 11/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.

import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Alamofire

class AgentPemexVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate, UITextFieldDelegate, UITextViewDelegate{
    

    @IBOutlet weak var mapView: GMSMapView!
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let camera = GMSCameraPosition.camera(withLatitude: 19.486122, longitude:  -99.178634, zoom: 8.0)
        mapView.camera = camera
        mapView.isMyLocationEnabled = true
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
        //circle()
        servicePemex()
    }

    func circle(){
        let circleCenter = CLLocationCoordinate2D(latitude: 19.43672685003325, longitude: -99.13378586992621)
        var circulo = GMSCircle(position: circleCenter, radius: 2000)
        circulo.strokeColor = UIColor.red
        circulo.strokeWidth = 1.5
        circulo.map = mapView
    }
    
    //Location Manager delegates
    private func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations.last
        let camera = GMSCameraPosition.camera(withLatitude: (location?.coordinate.latitude)!, longitude: (location?.coordinate.longitude)!, zoom: 17.0)
        self.mapView?.animate(to: camera)
        //Finally stop updating location otherwise it will come again and again in this delegate
        self.locationManager.stopUpdatingLocation()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func servicePemex(){
        
        guard let bearerToken = Singleton.getInstance().userToken else {
            print("No podemos obtener el token")
            return
        }
        
        let headers1 = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer " + "\(Singleton.getInstance().userToken ?? "")"
        ]
        
        
        guard let email = Singleton.getInstance().emailUser else {
            print("no se pudo")
            return
        }
        
        print(email)
        
        
        Alamofire.request("https://damp-ocean-98658.herokuapp.com/api/v1/user/center/asignadoP/\((Singleton.getInstance().emailUser!))", method: .get, encoding: JSONEncoding.default, headers: headers1).responseJSON {
            response in
            //print(response)
            
            guard let dataRecieved = response.data else {
                print("no se pudo parsear la respuesta")
                return
            }
            
            guard let incidentsRespuesta = try? JSONDecoder().decode(pointCenter.self, from: dataRecieved) else {return}
            
            guard let coordenateX = incidentsRespuesta.first?.center?.x else { return }
            guard let coordenateY = incidentsRespuesta.first?.center?.y else { return }
            
            print(coordenateX)
            print(coordenateY)
            print("******************************")
            
            
            let circleCenter = CLLocationCoordinate2D(latitude: coordenateX, longitude: coordenateY)
            var circulo = GMSCircle(position: circleCenter, radius: 2000)
            circulo.strokeColor = UIColor.red
            circulo.strokeWidth = 1.5
            circulo.map = self.mapView
            
        }
    }
    
    
    
    
    func serviceFinalizar(){
        
        guard let bearerToken = Singleton.getInstance().userToken else {
            print("No podemos obtener el token")
            return
        }
        
        let headers1 = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Bearer " + "\(Singleton.getInstance().userToken ?? "")"
        ]
        
        
        guard let email = Singleton.getInstance().emailUser else {
            print("no se pudo")
            return
        }
        
        print(email)
        
        
        Alamofire.request("https://damp-ocean-98658.herokuapp.com/api/v1/user/center/asignacion/finalizar\((Singleton.getInstance().emailUser!))", method: .get, encoding: JSONEncoding.default, headers: headers1).responseJSON {
            response in
            //print(response)
            
            guard let dataRecieved = response.data else {
                print("no se pudo parsear la respuesta")
                return
            }
            
            
        }
        
    }
    
    
    func alert4(){
        let alert = UIAlertController(title: "Finalizado", message: "Incidencia concluida", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
            case .cancel:
                print("cancel")
            case .destructive:
                print("destructive")
            }}))
        self.present(alert, animated: true, completion: nil)
    }

    @IBAction func endIncident(_ sender: Any) {
        alert4()
        mapView.clear()
    }
    
    override func viewWillAppear(_ animated: Bool) {}
    override func viewWillDisappear(_ animated: Bool) {}
    override func viewDidAppear(_ animated: Bool) {}
    override func viewDidDisappear(_ animated: Bool) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

