//
//  RegisterViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-18.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class RegisterViewController: UIViewController {
    
    @IBOutlet var emailTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func registerPressed(_ sender: AnyObject) {

            // register the user
            Auth.auth().createUser(withEmail: self.emailTextField.text!, password: self.passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                //success
                print("Regiteration successful")
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
        }
    
    }
    
    
    
}
