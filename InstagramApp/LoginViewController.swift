//
//  LoginViewController.swift
//  InstagramApp
//
//  Created by Isaac on 10/2/18.
//  Copyright © 2018 Isaac. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func OnSignIn(_ sender: Any) {
        PFUser.logInWithUsername(inBackground: usernameField.text!, password: passwordField.text!){ (user: PFUser?, error: Error?) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("User logged in successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
        }
    }
    
    @IBAction func OnSignUp(_ sender: Any) {
        let newUser = PFUser()
        newUser.username = usernameField.text
        newUser.password = passwordField.text
        
        newUser.signUpInBackground{ (success: Bool, error: Error?) in
            
            if let error = error {

                print(error.localizedDescription)
                
            } else {
                print("User Registered successfully")
                // manually segue to logged in view
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
            }
    
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
