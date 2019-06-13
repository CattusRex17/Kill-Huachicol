//
//  ContacVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 06/03/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit
import Alamofire

class ContacVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var nameUserTextField: UITextField!
    @IBOutlet weak var passwordTextfield: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    
    var nameUserAux: String?
    var passwordAux: String?
    var confirmPasswordAux: String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameUserTextField.layer.borderWidth = 1.5
        nameUserTextField.layer.borderColor = cleanGreen.cgColor
        nameUserTextField.delegate = self
        
        passwordTextfield.layer.borderWidth = 1.5
        passwordTextfield.layer.borderColor = cleanGreen.cgColor
        passwordTextfield.delegate = self
        
        confirmPasswordTextField.layer.borderWidth = 1.5
        confirmPasswordTextField.layer.borderColor = cleanGreen.cgColor
        confirmPasswordTextField.delegate = self
        
        }
    
    func conection(){

        let headers1 = [
            "Content-Type": "application/json"
        ]
        let parameters1 = [
            "nombre": "\(nameUserTextField.text ?? "")",
            "userName": "\(nameUserTextField.text ?? "")",
            "celular": "555555",
            "password": "\(passwordTextfield.text ?? "")",
            "profiles": [
                ["profileName": "CIUDADANO_ROLE"]
            ]
        ] as [String: Any]
        
        
        let valid = JSONSerialization.isValidJSONObject(parameters1)
        print("+++" + "\(valid)")
        
        Alamofire.request("https://auth-service-huachicol.herokuapp.com/api/v1/ciudadano", method: .post, parameters: parameters1, encoding: JSONEncoding.default, headers: headers1).responseJSON {
            response in
            print(response)
        }
    }
    
    @IBAction func registerButon(_ sender: Any) {
        nameUserAux = nameUserTextField?.text ?? ""
        passwordAux = passwordTextfield?.text ?? ""
        confirmPasswordAux = confirmPasswordTextField.text ?? ""
        
        if (nameUserAux?.isEmpty)! || (passwordAux?.isEmpty)! || (confirmPasswordAux?.isEmpty)!{
            alert()
        } else if confirmPasswordTextField.text != passwordTextfield.text{
            alert1()
        } else if confirmPasswordTextField.text == passwordTextfield.text{
            conection()
            alert2()
        }
    }
    
    
    
    func alert(){
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
    
    func alert1(){
        let alert = UIAlertController(title: "Error", message: "Las contraseñas deben coincidir", preferredStyle: .alert)
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
    
    func alert2(){
        let alert = UIAlertController(title: "Correcto", message: "Registro exitoso", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            switch action.style{
            case .default:
                print("default")
                self.dismiss(animated: true, completion: nil)
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
        
        if textField == nameUserTextField {
            guard let text = nameUserTextField?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 30
        } else if textField == passwordTextfield {
            guard let text = passwordTextfield?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 15
        }else if textField == confirmPasswordTextField {
            guard let text = confirmPasswordTextField?.text else {return true}
            let newLength = text.count + string.count - range.length
            return newLength <= 15
        }
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.nameUserTextField?.text = ""
        self.passwordTextfield?.text = ""
        self.confirmPasswordTextField?.text = ""
    }
    override func viewWillDisappear(_ animated: Bool) {}
    override func viewDidAppear(_ animated: Bool) {}
    override func viewDidDisappear(_ animated: Bool) {}
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}


