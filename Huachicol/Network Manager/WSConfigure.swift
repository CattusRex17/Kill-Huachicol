//
//  WSConfigure.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 08/04/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class LoginService {
    
    /*static func login(user: String, password: String, callback: @escaping (Bool, Int) -> Void){
        let headerService: HTTPHeaders = URLService.getHeaders()
        let error : String  = "Error al conectar al servidor"
        var status = false
        var cambioContrasena = 0
        let parameters: [String: Any] = ["username": user, "password": password, "grant_type": "password"]
        
        Alamofire.request(URLService.URL_LOGIN, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headerService).responseJSON {
            response in
            
            //Solicitudes
            
            print("--------- request")
            print("Request: \(String(describing: response.request))")
            print("--------- response")
            print("Response: \(String(describing: response.response))")
            print("--------- result")
            print("Result: \(response.result)")
            
            
            /*guard let respValue = response.result.value else {
                print(error)
                status = false
                cambioContrasena = -1
                callback(status, cambioContrasena)
                return
            }
            
            let json = JSON(respValue)
            print("--------- json")
            
            if json["status"] == "E"{
                status = true
                cambioContrasena = json["estatus_cambip_p"].int!
                UserDefaults.standard.set(json["nombre_usuario"].string, forKey: "user")
                UserDefaults.standard.set(json["id_usuario"].int, forKey: "id")
            } else {
                status = false
                cambioContrasena = -1
            }*/
            
            callback(status, cambioContrasena)
        }
        
    }*/
    
}
