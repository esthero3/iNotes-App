//
//  LoginViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-18.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func logInPressed(_ sender: AnyObject) {
        
        //loading symbol
        SVProgressHUD.show()
        
        //log in the user
        Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                print("success")
                
                //loading symbol disappers
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
        }
    
    
    }
}
