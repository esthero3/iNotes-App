//
//  ViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-13.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

import UIKit

class NotesViewController: UIViewController, UITextViewDelegate {
    
    //a variable that links to the main body text view
    @IBOutlet weak var txtBody: UITextView!
    @IBOutlet weak var btnDoneEditing: UIBarButtonItem!
    
    
    var strBodyText : String = ""
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //set the body's text to intermitnet string
        self.txtBody.text = self.strBodyText
        
        //make the keyboard immediately appear
        self.txtBody.becomeFirstResponder()
        
        //allows the UITextView methods to be called
        self.txtBody.delegate = self
    }
    
    @IBAction func doneEditingBody() {
    
        //hides the keyboard
    self.txtBody.resignFirstResponder()
        
    //makes the button invisible (still allowed to be pressed, but that's okay for this app)
        self.btnDoneEditing.tintColor = UIColor.clear
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so this gives it the exact RGB values
        self.btnDoneEditing.tintColor = UIColor(red: 0, green:
          122.0/255.0, blue: 1, alpha: 1)
    }
    
    //36
    

}

