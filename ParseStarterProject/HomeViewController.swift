
//
//  ViewController.swift
//
//  Copyright 2011-present Parse Inc. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class HomeViewController: UIViewController, PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate {
    
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
    }

    func presentLoginViewController() {
        let loginViewController = PFLogInViewController()
        loginViewController.delegate = self
        
        var logInLogoTitle = UILabel()
        logInLogoTitle.text = "Remote Translator"
        logInLogoTitle.font = UIFont(name: "HelveticaNeue-Bold", size: 27.5)
        //logInLogoTitle.textColor = UIColor(netHex: 0xF9FFFC)
        loginViewController.logInView!.logo = logInLogoTitle
        
        let signUpViewController = PFSignUpViewController()
        signUpViewController.delegate = self
        
        loginViewController.signUpController = signUpViewController
        presentViewController(loginViewController, animated: true, completion: nil)
    }
    
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        if PFUser.currentUser() == nil {
            presentLoginViewController()
            logoutButton.enabled = false
        }
        else {
            logoutButton.enabled = true
        }
    }
    
    func logInViewController(logInController: PFLogInViewController, didLogInUser user: PFUser) {
        dismissViewControllerAnimated(true, completion: nil)
        logoutButton.enabled = true
    }
    
    func logInViewController(logInController: PFLogInViewController, didFailToLogInWithError error: NSError?) {
        
        let alert = UIAlertController(title: "Login Error", message: error?.localizedDescription ?? "Unspecified error", preferredStyle: .Alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .Default, handler: nil)
        alert.addAction(okAction)
        presentViewController(alert, animated: true, completion: nil)
    }
    
    func signUpViewController(signUpController: PFSignUpViewController, shouldBeginSignUp info: [NSObject : AnyObject]) -> Bool {
        return true
    }

    
    @IBAction func logoutButtonTap(sender: AnyObject) {
        PFUser.logOut()
        presentLoginViewController()
        logoutButton.enabled = false
    }
    
}

