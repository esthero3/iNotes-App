//
//  TableViewController.swift
//  notess
//
//  Created by Esther Osammor on 2019-12-13.
//  Copyright © 2019 Esther Osammor. All rights reserved.
//

import UIKit

class TableViewController: UITableViewController {
    
    //array of dictionaries
    //keys = "title", "body"
    var arrNotes = [[String:String]]()
    
    //selected index when transitioning (-1 as sentinel value)
    var selectedIndex = -1

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
        var cell = tableView.dequeueReusableCell(withIdentifier: "CELL") as! UITableViewCell
      
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
        
        }
    
    @IBAction func newNote() {
        
        //new dictionary with 2 keys and test values for both
        var newDict = ["title" : "TestTitle", "body" : "TestBody"]
        
        //add the dictionary to the front (or top) of the array
        arrNotes.insert(newDict, at: 0)
        
        //set the selected index to the most recently added item
        self.selectedIndex = 0
        
        //reload the table ( refresh the view)
        self.tableView.reloadData()
        
        //push the editor view using the predefined segue
        performSegue(withIdentifier: "showEditorSegue", sender: nil)
        
    }

    
    
        

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
