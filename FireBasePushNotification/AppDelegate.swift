//
//  AppDelegate.swift
//  FireBasePushNotification
//
//  Created by Huynh Tri Dung on 5/27/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Register for remote notifications
        let settings: UIUserNotificationSettings =
            UIUserNotificationSettings(forTypes: [.Alert, .Badge, .Sound], categories: nil)
        application.registerUserNotificationSettings(settings)
        application.registerForRemoteNotifications()

        FIRApp.configure()
        
        // Add observer for InstanceID token refresh callback.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.tokenRefreshNotificaiton),
                                                         name: kFIRInstanceIDTokenRefreshNotification, object: nil)
        return true
    }
    
    func application(application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: NSData) {
        FIRInstanceID.instanceID().setAPNSToken(deviceToken, type: FIRInstanceIDAPNSTokenType.Sandbox)
    }
    
//    // [START receive_message]
//    func application(application: UIApplication, didReceiveRemoteNotification
//        userInfo: [NSObject : AnyObject],
//        fetchCompletionHandler completionHandler: (UIBackgroundFetchResult) -> Void) {
//        
//        // Print message ID.
////        print("Message ID: \(userInfo["gcm.message_id"])")
//        
//        // Print full message.
//        print("%@", userInfo)
//    }
    // [END receive_message]
    
    func application(application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        print(userInfo)
    }
    
    // [START refresh_token]
    func tokenRefreshNotificaiton(notification: NSNotification) {
        let refreshedToken = FIRInstanceID.instanceID().token()!
        print("InstanceID token: \(refreshedToken)")
        connectToFcm()
    }
    
    func connectToFcm() {
        FIRMessaging.messaging().connectWithCompletion { (error) in
            if (error != nil) {
                print("Unable to connect with FCM. \(error)")
            } else {
                print("Connected to FCM.")
            }
        }
    }
    
    func applicationDidBecomeActive(application: UIApplication) {
        connectToFcm()
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        FIRMessaging.messaging().disconnect()
        print("Disconnected from FCM.")
    }
    
    func application(application: UIApplication,
                     openURL url: NSURL, options: [String: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handleURL(url,
                                                    sourceApplication: options[UIApplicationOpenURLOptionsSourceApplicationKey] as? String,
                                                    annotation: options[UIApplicationOpenURLOptionsAnnotationKey])
    }
}

