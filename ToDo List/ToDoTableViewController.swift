//
//  ToDoTableViewController.swift
//  ToDo List
//
//  Created by John Zulewski on 9/28/20.
//

import UIKit

class ToDoTableViewController: UITableViewController {

    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var noteView: UITextView!
    
    var toDoItem: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if toDoItem == nil {
            toDoItem = ""
        }
        
        nameField.text = toDoItem
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        toDoItem = nameField.text
    }

    @IBAction func cancelButtonPressed(_ sender: Any) {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
        } else {
            navigationController?.popViewController(animated: true)
        }
        
    }
    

}
