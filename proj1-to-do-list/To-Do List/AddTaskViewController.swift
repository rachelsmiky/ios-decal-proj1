//
//  AddTaskViewController.swift
//  To-Do List
//
//  Created by Rachel Song on 10/15/16.
//  Copyright © 2016 Rachel Song. All rights reserved.
//

import Foundation
import UIKit

class AddTaskViewController: UIViewController{
    
    @IBOutlet weak var taskName: UITextField!
    @IBOutlet weak var taskDetails: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    var task: Task?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        taskDetails!.layer.borderWidth = 1
        taskDetails!.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barButton = sender as? UIBarButtonItem {
            if saveButton == barButton {
                let name = taskName.text ?? ""
                let details = taskDetails.text
                task = Task(name: name, details: details)
            }
        }
    }

}
