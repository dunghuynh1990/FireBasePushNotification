//
//  AccountViewController.swift
//  FireBasePushNotification
//
//  Created by Huynh Tri Dung on 5/31/16.
//  Copyright © 2016 Huynh Tri Dung. All rights reserved.
//

import UIKit
import Firebase

class AccountViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func signOut(sender: AnyObject) {
        try! FIRAuth.auth()!.signOut()
        self.dismissViewControllerAnimated(true, completion: {});
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
