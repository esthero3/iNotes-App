//
//  TableViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-13.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

//testing testing 123. will u save to github?
//checking again pls dont change...!!!!!

import UIKit
import Firebase

class TableViewController: UITableViewController, NoteViewDelegate {
    
    //array of dictionaries
    //keys = "title", "body"
    var arrNotes = [[String:String]]()
    
    //selected index when transitioning (-1 as sentinel value)
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

   
        //retrieve notes
        getNotes()
        
    }
    
    override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()

        }
    
    override func tableView(_ tableView: UITableView,
       numberOfRowsInSection section: Int) -> Int {
           // return the desired # of elements. In this case, number of rows
        return arrNotes.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      
        //grab the "default cell", using the identifier set up in the Storyboard
        let cell = tableView.dequeueReusableCell(withIdentifier: "CELL")!
      
        // set the text to the title value of the same index of the array
        cell.textLabel!.text = arrNotes[indexPath.row]["title"]
        
        //return the newly-modifed cell
        return cell
        
    }
    
    override func tableView(_ tableView: UITableView,
      didSelectRowAt indexPath: IndexPath) {
        
        self.selectedIndex = indexPath.row
        
        //push the editor view using the predefined segue
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender:
        Any?) {
      
        //grab the view controller we're gong to transition to
        let notesEditorVC = segue.destination as! NotesViewController
        
        //set the title of the navigation bar to the selectedIndex's title
               notesEditorVC.navigationItem.title =
               arrNotes[self.selectedIndex]["title"]
        
        //set the body of the view controller to the selectedIndex's body
        notesEditorVC.strBodyText = arrNotes[self.selectedIndex]["body"]!
        
        //set the delegate to self so the method get called here
        notesEditorVC.delegate = self
        
        }
    
    @IBAction func newNote() {
        
        //new dictionary with 2 keys and test values for both
        let newDict = ["title" : "", "body" : ""]
        
        //add the dictionary to the front (or top) of the array
        arrNotes.insert(newDict, at: 0)
        
        //set the selected index to the most recently added item
        self.selectedIndex = 0
        
        //reload the table ( refresh the view)
        self.tableView.reloadData()
        
        //save notes to the phone
        //saveNotesArray()
        
        //push the editor view using the predefined segue
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
        
        
        
    }
    
    func didUpdateNoteWithTitle(newTitle: String, andBody newBody:
      String) {
        
        //update the respective values
        self.arrNotes[self.selectedIndex]["title"] = newTitle
        self.arrNotes[self.selectedIndex]["body"] = newBody
        
        //refresh the view
        self.tableView.reloadData()
        
        //save notes to the phone
        saveNotesArray()
    }
    
    func saveNotesArray() {
         //save the newly updated array
//        UserDefaults.standard.set(arrNotes,forKey: "notes")
//        UserDefaults.standard.synchronize()
        
        let notesDB = Database.database().reference().child("Notes")
        
        let notesDictionary = ["User": Auth.auth().currentUser?.email, "NotesBody": self.arrNotes[self.selectedIndex]["body"], "Title": self.arrNotes[self.selectedIndex]["title"]]
        
        notesDB.childByAutoId().setValue(notesDictionary) {
            (error, reference) in
            
            if error != nil {
                print(error!)
            } else {
                print("Saved")
            }
        }
    }
    
    // retrevies the notes from firebase database
    func getNotes() {
        
        let NotesDB = Database.database().reference().child("Notes")
        
        NotesDB.observe(.childAdded, with: { (snapshot) in
            let snapshotValue = snapshot.value as? Dictionary<String,String>
            
            let body = snapshotValue!["NotesBody"]
            let title = snapshotValue!["Title"]
            
            let note = ["title" : title, "body": body]

            self.arrNotes.append(note as! [String : String])
            
            self.tableView.reloadData()
        })
    }
    
    //logs out user and sends them back to the root view controlller
    @IBAction func LogOutPressed(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            navigationController?.popToRootViewController(animated: true)
            
        } catch {
            print("error")
        }
    }
    

}
