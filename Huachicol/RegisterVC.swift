//
//  RegisterVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 06/03/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit

class RegisterVC: UIViewController, UITextFieldDelegate, UITextViewDelegate {
    
    
    @IBOutlet weak var nombreTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nombreTextField.layer.borderWidth = 1.5
        nombreTextField.layer.borderColor = cleanGreen.cgColor
        nombreTextField.delegate = self
        
        emailTextField.layer.borderWidth = 1.5
        emailTextField.layer.borderColor = cleanGreen.cgColor
        emailTextField.delegate = self
        
        messageTextView.layer.borderWidth = 1.5
        messageTextView.layer.borderColor = cleanGreen.cgColor
        messageTextView.delegate = self
    }
    

    
    
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
