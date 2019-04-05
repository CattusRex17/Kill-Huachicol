//
//  LoginVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 14/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

class LoginVC: UIViewController,UITextFieldDelegate  {
    
    
    
    //@IBOutlet weak var userNameTextField: UITextField?
    //@IBOutlet weak var passUserTextField: UITextField?
    var userTextField: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    
    /*func validation() {
        userTextField = userNameTextField!.text ?? ""
        if ((userTextField?.isEmpty)!){
            print("No puede tener campos vacios")
        }else if (userTextField == "0"){
            print("usuario normal")
        }else if (userTextField == "1"){
            print("usuario tipo sedena")
        }else if (userTextField == "2"){
            print("usuario tipo pemex")
        }
    }
    
    
    // Métodos de protocolos implementados
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == userNameTextField{
            passUserTextField?.becomeFirstResponder()
        } else {
            passUserTextField?.resignFirstResponder()
        }
        return true
    }*/
    
    // Método para ocultar el teclado
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
