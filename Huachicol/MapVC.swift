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
import  Alamofire

class MapVC: UIViewController, CLLocationManagerDelegate, GMSMapViewDelegate, UIGestureRecognizerDelegate, UITextViewDelegate, UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate{

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet weak var SelectorLabel: UILabel!
    @IBOutlet weak var mapView: GMSMapView!
    
    
    var latitude: Double?
    var longitude: Double?
    
    var idUser: String = ""
    let incidentes = ["Fuga", "Robo", "Incendio", "Otro"]

        override func viewDidLoad() {
            super.viewDidLoad()
            
            titleTextField.layer.borderWidth = 1.5
            titleTextField.layer.borderColor = cleanGreen.cgColor
            titleTextField.delegate = self
            
            descriptionTextView.layer.borderWidth = 1.5
            descriptionTextView.layer.borderColor = cleanGreen.cgColor
            descriptionTextView.delegate = self
            
            let camera = GMSCameraPosition.camera(withLatitude: 19.486122, longitude:  -99.178634, zoom:12.0)
            let camera1 = GMSCameraPosition.camera(withLatitude: 19.492563, longitude:  -99.197232, zoom: 12.0)
            let camera2 = GMSCameraPosition.camera(withLatitude: 19.481431, longitude:  -99.191017, zoom: 12.0)
            let camera3 = GMSCameraPosition.camera(withLatitude: 19.479204, longitude:  -99.180576, zoom: 12.0)
            
            mapView.camera = camera
            mapView.isMyLocationEnabled = true
            mapView.delegate = self
            
            pickUp(titleTextField)
        }
    
    
    func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
        print("You tapped at \(coordinate.latitude), \(coordinate.longitude)")
        // Creates a marker in the center of the map.
        latitude = coordinate.latitude
        longitude = coordinate.longitude
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: coordinate.latitude, longitude: coordinate.longitude)
        marker.title = "Incidencia"
        //marker.snippet = "Australia"
        marker.map = mapView
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    func serviceMakeDenounce(){
        
        guard let denounce = Singleton.getInstance().userToken else {
            print("no se pudo")
            return
        }
        
        let headers1 = [
            "Content-Type": "application/json",
            "Authorization": "Bearer \(denounce)"
        ]
        
        let formatter = DateFormatter()
        // initially set the format based on your datepicker date / server String
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        let myString = formatter.string(from: Date()) // string purpose I add here
        // convert your string to date
        let yourDate = formatter.date(from: myString)
        //then again set the date format whhich type of output you need
        formatter.dateFormat = "yyyy-MM-dd"
        // again convert your date to string
        let myStringafd = formatter.string(from: yourDate!)
        
        guard let email = Singleton.getInstance().emailUser else {
            print("no se pudo")
            return
        }
        
        let parameters1: [String: Any] = [
            "titulo": "\(titleTextField.text ?? "")",
            "descripcion": "\(descriptionTextView.text ?? "")",
            "sendDate": "\(myStringafd)",
            "punto": [
                "x": latitude,
                "y": longitude,
                "coordinates": [
                    latitude,
                    longitude
                ],
                "type": "point"
            ],
            "email": "\(email)"
        ]
        
        Alamofire.request("https://damp-ocean-98658.herokuapp.com/api/v1/user/complain/", method: .post, parameters: parameters1, encoding: JSONEncoding.default, headers: headers1).responseJSON {
            response in
            print(response)
            self.alert4()
            //guard let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "IncidentsVC") as? IncidentsVC else {return}
            //self.present(viewCon, animated: true, completion: nil)
            
        }
    }
    
    @IBAction func makeDenounce(_ sender: Any) {
        serviceMakeDenounce()
    }
    
    
    func alert4(){
        let alert = UIAlertController(title: "Éxito", message: "Se ha registrado exitosamente su denuncia", preferredStyle: .alert)
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
    
    
    func pickUp(_ textField : UITextField){
        // UIPickerView
        let incidentesPickerView = UIPickerView()
        incidentesPickerView.delegate = self
        incidentesPickerView.tag = 1
        titleTextField.inputView = incidentesPickerView
        
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor(red: 92/255, green: 216/255, blue: 255/255, alpha: 1)
        toolBar.sizeToFit()
        
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Seleccionar", style: .plain, target: self, action: #selector(MapVC.doneClick))
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancelar", style: .plain, target: self, action: #selector(MapVC.cancelClick))
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        titleTextField.inputAccessoryView = toolBar
    }
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        switch pickerView.tag {
        case 1:
            return incidentes.count
        default:
            print("extra")
        }
        return 0
    }
    
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        
        switch pickerView.tag {
        case 1:
            return incidentes[row]
        default:
            print("extra")
        }
        return nil
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch pickerView.tag {
        case 1:
            titleTextField.text = incidentes[row]
        default:
            print("extra")
        }
    }
    
    
    @objc func doneClick() {
        titleTextField.resignFirstResponder()
    }
    @objc func cancelClick() {
        titleTextField.resignFirstResponder()
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

