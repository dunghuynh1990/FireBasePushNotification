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




class ViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
//        let token = FIRInstanceID.instanceID().token()
//        print("InstanceID token: \(token!)")

    
        
        GIDSignIn.sharedInstance().clientID = FIRApp.defaultApp()!.options.clientID
        GIDSignIn.sharedInstance().delegate = self
        
        //GG Sign In
        GIDSignIn.sharedInstance().uiDelegate = self
//        GIDSignIn.sharedInstance().signInSilently()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK: Google Sign In
    func signIn(signIn: GIDSignIn!, didSignInForUser user: GIDGoogleUser!,
                withError error: NSError!) {
        if let error = error {
            print(error.localizedDescription)
            return
        }else{
            print("Greate! Our user sign in! :\(user)")
            let authentication = user.authentication
            let credential = FIRGoogleAuthProvider.credentialWithIDToken(authentication.idToken,
                                                                         accessToken: authentication.accessToken)
            
            FIRAuth.auth()?.signInWithCredential(credential) {
                (user, error) in
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                let vc = storyboard.instantiateViewControllerWithIdentifier("AccountViewController") 
                self.presentViewController(vc, animated: true, completion: nil)
            }
        }
    }

    func signIn(signIn: GIDSignIn!, didDisconnectWithUser user:GIDGoogleUser!,
                withError error: NSError!) {
    }
    
    @IBAction func subscribeTopic(sender: AnyObject) {
        FIRMessaging.messaging().subscribeToTopic("/topics/news")
        print("Subscribed to news topic")
    }

    @IBAction func getToken(sender: AnyObject) {
        let token = FIRInstanceID.instanceID().token()
        print("InstanceID token: \(token!)")
    }
}

