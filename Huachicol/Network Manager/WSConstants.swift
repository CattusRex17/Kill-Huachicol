//
//  WSConstants.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 13/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

/*import Foundation

let headers = ["content-type" : "", "Authorization": ""]

//URL Services
let wsHuichol = "https://192.168.0.109:8383/"

// ENDPOINTS para consumir los servicios
let loginWS = "loginService"
let markerWS = "resources"
let userRegisterWS = "userRegister"
let incidentsWS = "incidents"*/



import UIKit
import Alamofire

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let headers = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic YW5ndWxhcmp3dGNsaWVudGlkOjEyMzQ1"
        ]
        let parameters = [
            "username": "fer@gmail.com",
            "password": "12345",
            "grant_type": "password"
        ]
        Alamofire.request("https://auth-service-huachicol.herokuapp.com/oauth/token", method: .post, parameters: parameters, encoding: URLEncoding(destination: .queryString), headers: headers).responseJSON {
            response in
            
            //Solicitudes
            
            print("--------- request")
            print("Request: \(String(describing: response.request))")
            print("--------- response")
            print("Response: \(String(describing: response.response))")
            print("--------- result")
            print("Result: \(response.result)")
            
            
        }
        
}

}
