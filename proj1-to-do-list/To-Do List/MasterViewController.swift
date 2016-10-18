//
//  MasterViewController.swift
//  To-Do List
//
//  Created by Rachel Song on 10/15/16.
//  Copyright © 2016 Rachel Song. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var objects = [Task]()
    var total = 0
    var numCompleted = 0
    

    // Mark Properties
    
    @IBOutlet weak var statButton: UIBarButtonItem!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = (controllers[controllers.count-1] as! UINavigationController).topViewController as? DetailViewController
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.isCollapsed
        super.viewWillAppear(animated)
        self.tableView.reloadData()
        var count = total
        while !objects.isEmpty && count > 0 {
            if let t = objects.last{
                count -= 1
                if t.timestamp.timeIntervalSinceNow < -86400 {
                    if t.completed == true{
                        objects.removeLast()
                        total = total - 1
                        numCompleted -= 1
                        let indexPath = IndexPath(row: total, section: 0)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    }
                }else{
                    break
                }
            }
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(_ sender: Any, task:Task) {
        objects.insert(task, at: 0)
        let indexPath = IndexPath(row: 0, section: 0)
        self.tableView.insertRows(at: [indexPath], with: .automatic)
        total = total + 1
    }
    
    @IBAction func unwindToTaskList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? AddTaskViewController, let task:Task = sourceViewController.task {
            insertNewObject(sender, task: task)
        }
        if let sourceViewController = sender.source as? DetailViewController {
            if sourceViewController.changed == true {
                if sourceViewController.detailItem?.completed == true {
                    numCompleted += 1
                }else{
                    numCompleted -= 1
                }
            }
        }
    }


    // MARK: - Segues

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = objects[indexPath.row]
                let controller = (segue.destination as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        if segue.identifier == "showStats"{
            let controller = segue.destination as! StatsViewController
            controller.count = numCompleted
        }
    }

    // MARK: - Table View
    

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return objects.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        let object = objects[indexPath.row] 
        cell.textLabel!.text = object.name
        if object.completed == true{
            cell.accessoryType = .checkmark
        }else{
            cell.accessoryType = .none
        }
        return cell
    }

    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            objects.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            total = total - 1
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }


}

