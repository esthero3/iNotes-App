//
//  ViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-13.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

import UIKit

//the protocol pattern,so the table can update
protocol NoteViewDelegate {
    
    //name of function that will be impelemented
    func didUpdateNoteWithTitle(newTitle : String, andBody newBody : String)
}


class NotesViewController: UIViewController, UITextViewDelegate {
    
    //variable to hold the delegate
    var delegate : NoteViewDelegate?
    
    
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
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        
        //tells the main view controller that we're going to update the selected item. if the delegate is not nil
        
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
        }
    }
    
    @IBAction func doneEditingBody() {
    
        //hides the keyboard
    self.txtBody.resignFirstResponder()
        
    //makes the button invisible (still allowed to be pressed, but that's okay for this app)
        self.btnDoneEditing.tintColor = UIColor.clear
        
        //tells the main view controller that the selected item is updated. only of the delegate is not nil
        
        if self.delegate != nil {
            self.delegate!.didUpdateNoteWithTitle(newTitle: self.navigationItem.title!, andBody: self.txtBody.text)
        }
    
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        //sets the color of the Done button to the default blue
        //it's not a pre-defined value like clearColor, so this gives it the exact RGB values
        self.btnDoneEditing.tintColor = UIColor(red: 0, green:
          122.0/255.0, blue: 1, alpha: 1)
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
        //seperate the body into multiple sections
        let components = self.txtBody.text.components(separatedBy: ("\n"))
        
        //reset the title to blank in case there are no componenets with valid text
        self.navigationItem.title = ""
        
        //loop through each item in the components array
        for item in components {
            
            if components.count > 0 {
                
                //set title to the item and break out of the for loop
                self.navigationItem.title = item
                break
                
            }
        }
    }
}

