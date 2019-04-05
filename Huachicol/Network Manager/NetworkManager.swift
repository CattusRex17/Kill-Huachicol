//
//  NetworkManager.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 13/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import Foundation

protocol URL_SessionDelegate {
    func connectionFinishSuccessfull(session: URL_Session, response: NSDictionary) //Response del mismo tipo que devuelve el JSON o utilizar any para cachar cualquiera de los 2
    func connectionFinishWithError(session: URL_Session, error: Error)
}

class URL_Session: NSObject, URLSessionDelegate, URLSessionDataDelegate {
    
    var dataTask: URLSessionDataTask? //Descarga los bytes, evalua la respuesta del servidor
    var responseData: Data = Data() //Respuesta del lado del servidor
    var httpResponse: HTTPURLResponse?
    var delegate: URL_SessionDelegate?
    
    override init() {
        super.init()
    }
    
    //Por cada webservice se requiere una función de este tipo
    // Método para consumir el servicio de LOGIN
    func loginPOST(parameters: LoginStruct) {
        
        //TIP: Esto evita que se hagan peticiones de forma simultánea
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "\(wsHuichol)\(loginWS)"
        let sessionCofiguration = URLSessionConfiguration.default
        let defaultSession = URLSession(configuration: sessionCofiguration, delegate: self, delegateQueue: OperationQueue.main) //Hilo con el que se trabaja, el MAIN
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60 //Si pasa más de 60 segundos se cancela el dataTask y se cancela
        
        responseData = Data()
        
        let enconded = try? JSONEncoder().encode(parameters)
        
        if let postData = enconded {
            request.httpMethod = "POST"
            request.httpBody = postData
            request.allHTTPHeaderFields = headers
        } else {
            print("No estás enviando un tipo de dato DATA")
        }
        
        dataTask = defaultSession.dataTask(with: request)
        dataTask?.resume()
    }
    
    // Método para consumir el servicio de Recursos(insumos y servicios)
    func markerPOST(parameters: MarkerStruct) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "\(wsHuichol)\(markerWS)"
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        responseData = Data()
        
        let encoded = try? JSONEncoder().encode(parameters)
        
        if let postData = encoded {
            request.httpMethod = "POST"
            request.httpBody = postData
            request.allHTTPHeaderFields = headers
            
            print("Aqui está mi JSON: \(postData)")
            let json = try! JSONSerialization.jsonObject(with: postData, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        } else {
            print("Error con el tipo de dato enviado")
        }
        
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    
    // Método para consumir el servicio de Recursos(insumos y servicios)
    func userRegisterPOST(parameters: UserRegisterStruct) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "\(wsHuichol)\(userRegisterWS)"
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        responseData = Data()
        
        let encoded = try? JSONEncoder().encode(parameters)
        
        if let postData = encoded {
            request.httpMethod = "POST"
            request.httpBody = postData
            request.allHTTPHeaderFields = headers
            
            print("Aqui está mi JSON: \(postData)")
            let json = try! JSONSerialization.jsonObject(with: postData, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        } else {
            print("Error con el tipo de dato enviado")
        }
        
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    
    
    // Método para consumir el servicio de Recursos(insumos y servicios)
    func incidentsPOST(parameters: IncidentsStruct) {
        
        if dataTask != nil {
            dataTask?.cancel()
        }
        
        let urlString = "\(wsHuichol)\(incidentsWS)"
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: OperationQueue.main)
        let url = URL(string: urlString)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        
        responseData = Data()
        
        let encoded = try? JSONEncoder().encode(parameters)
        
        if let postData = encoded {
            request.httpMethod = "POST"
            request.httpBody = postData
            request.allHTTPHeaderFields = headers
            
            print("Aqui está mi JSON: \(postData)")
            let json = try! JSONSerialization.jsonObject(with: postData, options: JSONSerialization.ReadingOptions.allowFragments)
            print(json)
        } else {
            print("Error con el tipo de dato enviado")
        }
        
        dataTask = session.dataTask(with: request)
        dataTask?.resume()
    }
    //------------------------------------------------------------------------------------------//
    //    URLSession Delegate
    
    //Task finalizado con...error o éxito
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        if error == nil {
            //No hubo error
            
            //let json = String(data: responseData, encoding: String.Encoding.utf8)
            //rint("Failure Response: \(json)")
            
            if let resultado = try? JSONSerialization.jsonObject(with: responseData, options: .mutableContainers) as? NSDictionary {
                
                if resultado != nil {
                    delegate?.connectionFinishSuccessfull(session: self, response: resultado!)
                } else {
                    print("Ocurrió un error con la serialización del JSON")
                }
            }
        } else {
            delegate?.connectionFinishWithError(session: self, error: error!)
        }
    }
    
    //Representación de bytes descargando...
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        responseData.append(data)
    }
    
    //Servidor respondió con... esta se ejecuta primero si todo va bien se ejecutan las funciones de arriba
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        
        httpResponse = response as? HTTPURLResponse
        
        if httpResponse?.statusCode == 200 {
            completionHandler(URLSession.ResponseDisposition.allow)
        } else {
            completionHandler(URLSession.ResponseDisposition.cancel)
        }
        
        print("Estatus code server: \(httpResponse!.statusCode)")
        //print("Estatus \(httpResponse)")
    }
    
    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        
        //accept all certs when testing, perform default handling otherwise
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}
