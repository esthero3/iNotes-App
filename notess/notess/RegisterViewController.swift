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
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func registerPressed(_ sender: Any) {
        
        //loading symbol
        SVProgressHUD.show()
        
        
        // register the user
        Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!) { (user, error) in
            
            if error != nil {
                print(error!)
            } else {
                //success
                print("Regiteration successful")
                
                //loading symbol disappears
                SVProgressHUD.dismiss()
                
                self.performSegue(withIdentifier: "goToChat", sender: self)
            }
            
        }
    }
    
    
    
}
