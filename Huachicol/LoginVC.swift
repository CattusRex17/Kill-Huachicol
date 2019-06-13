//
//  LoginVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 14/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON


public struct Usuario: Codable {
    public let exp: Int
    public let userName: String
    public let authorities: [String]
    public let jti, clientID: String
    public let scope: [String]
    
    enum CodingKeys: String, CodingKey {
        case exp
        case userName = "user_name"
        case authorities, jti
        case clientID = "client_id"
        case scope
    }
    
    public init () {
        self.exp = Int()
        self.userName = String()
        self.authorities = [String]()
        self.jti = String()
        self.clientID = String()
        self.scope = [String]()
    }
}

class LoginVC: UIViewController, UITextFieldDelegate  {
    
    var userAux: String?
    var passwordAux: String?
    var idUser: String?
    var email: String?
    
    @IBOutlet weak var usertextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        usertextField.layer.borderWidth = 1.5
        usertextField.layer.borderColor = cleanGreen.cgColor
        usertextField.delegate = self
        
        passwordTextField.layer.borderWidth = 1.5
        passwordTextField.layer.borderColor = cleanGreen.cgColor
        passwordTextField.delegate = self
    }
    
    func serviceLogin(){
        
        let headers1 = [
            "Content-Type": "application/x-www-form-urlencoded",
            "Authorization": "Basic YW5ndWxhcmp3dGNsaWVudGlkOjEyMzQ1"
        ]
        let parameters1 = [
            "username": usertextField.text!,
            "password": passwordTextField.text!,
            "grant_type": "password"
            ] as [String : Any]
        
        Alamofire.request("https://auth-service-huachicol.herokuapp.com/oauth/token", method: .post, parameters: parameters1, encoding: URLEncoding(destination: .queryString), headers: headers1).responseJSON {
           response in
            
            if let killingJSON = response.result.value{
                let killingObject:Dictionary = killingJSON as!  Dictionary<String, Any>
                //print(killingObject)
                
                let tokenObject:String = killingObject["access_token"] as? String ?? ""
                //print(tokenObject)
                
                let token:String = String(tokenObject)
                Singleton.getInstance().userToken = token
                Singleton.getInstance().emailUser = self.usertextField.text!
                print(token)
                
                var tokenAux = token.components(separatedBy: ".")
                //print(tokenAux)
                
                guard let decodedData = Data(base64Encoded: tokenAux[1]) else {
                    print("No se pudo obtener data")
                    self.email = (self.usertextField.text!)
                    //print(self.email!)
                    
                    if self.email == "jonattan@gmail.com"{
                        guard let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AgentSedenaVC") as? AgentSedenaVC else {return}
                        self.present(viewCon, animated: true, completion: nil)
                    }else if self.email == "ivette@gmail.com"{
                        guard let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AgentPemexVC") as? AgentPemexVC else {return}
                        self.present(viewCon, animated: true, completion: nil)
                    }
                    return
                }
                
                var usuario: Usuario = Usuario()
                 do {
                    usuario = try JSONDecoder().decode(Usuario.self, from: decodedData)
                 } catch {
                    print("No se puede parsear la respuesta")
                 }
                print(usuario)
                Singleton.getInstance().userRole = usuario.authorities[0]
                print(Singleton.getInstance().userRole!)

                Singleton.getInstance().emailUser = usuario.userName
                print(Singleton.getInstance().emailUser)
               
                
                if  Singleton.getInstance().userRole == "ADMINISTRADOR_ROLE"{
                    print("es un usuario tipo persona")
                    guard let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTabBarVC") as? MenuTabBarVC else {return}
                    self.present(viewCon, animated: true, completion: nil)
                }else if Singleton.getInstance().userRole == "CIUDADANO_ROLE"{
                    guard let viewCon = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuTabBarVC") as? MenuTabBarVC  else {return}
                    self.present(viewCon, animated: true, completion: nil)
                }else {
                    print("sin role")
                }
            }
        }
    }

    @IBAction func loginButton(_ sender: Any) {
        userAux = usertextField?.text ?? ""
        passwordAux = passwordTextField?.text ?? ""
        

        if (userAux?.isEmpty)! || (passwordAux?.isEmpty)!{
            alert4()	
        }else {
             serviceLogin()
        }
    }
    
    func alert4(){
        let alert = UIAlertController(title: "Error", message: "Todos los campos son obligatorios", preferredStyle: .alert)
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if textField == usertextField {
            guard let text = usertextField?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 30
        } else if textField == passwordTextField {
            guard let text = passwordTextField?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 12
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.usertextField?.text = ""
        self.passwordTextField?.text = ""
    }
    
    
    func back (){
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {}
    override func viewDidAppear(_ animated: Bool) {}
    override func viewDidDisappear(_ animated: Bool) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


extension String {
    func isValidEmail() -> Bool {
        // here, `try!` will always succeed because the pattern is valid
        let regex = try! NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$", options: .caseInsensitive)
        return regex.firstMatch(in: self, options: [], range: NSRange(location: 0, length: count)) != nil
    }
}

    
    

