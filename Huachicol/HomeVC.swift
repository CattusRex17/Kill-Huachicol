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
        /*TWTRAPIClient().loadTweet(withID: "20") { tweet, error in
            if let t = tweet {
                let tweetView = TWTRTweetView(tweet: t)
                self.twitterView.backgroundColor = UIColor.blue
                self.twitterView.primaryTextColor = UIColor.yellow
            } else {
                print("Failed to load Tweet: \(error)")
            }
        }
        // Do any additional setup after loading the view.
    }*/
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
