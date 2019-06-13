//
//  HomeVC.swift
//  Huachicol
//
//  Created by Mauricio Rodriguez on 20/02/19.
//  Copyright © 2019 Mauricio Rodriguez. All rights reserved.
//

import UIKit
import TwitterKit

class HomeVC: UIViewController,TWTRTweetViewDelegate{
    
    
    @IBOutlet weak var twitterView: TWTRTweetView!
    
    override func viewDidLoad(){
        super.viewDidLoad()
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
