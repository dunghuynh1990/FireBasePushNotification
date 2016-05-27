//
//  ViewController.swift
//  FireBasePushNotification
//
//  Created by Huynh Tri Dung on 5/27/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func handleLogTokenTouch(sender: UIButton) {
        // [START get_iid_token]
        let token = FIRInstanceID.instanceID().token()
        print("InstanceID token: \(token!)")
        // [END get_iid_token]
    }
    
    @IBAction func handleSubscribeTouch(sender: UIButton) {
        // [START subscribe_topic]
        FIRMessaging.messaging().subscribeToTopic("/topics/news")
        print("Subscribed to news topic")
        // [END subscribe_topic]
    }


}

