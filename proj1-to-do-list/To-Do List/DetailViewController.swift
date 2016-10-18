//
//  DetailViewController.swift
//  To-Do List
//
//  Created by Rachel Song on 10/15/16.
//  Copyright © 2016 Rachel Song. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!

    @IBOutlet weak var markCompletedButton: UIButton!
    
    var changed = false

    
    func configureView() {
        // Update the user interface for the detail item.
        if let task = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = task.details
                if task.completed == true {
                    markCompletedButton.setImage(#imageLiteral(resourceName: "Check.png"), for: UIControlState.normal)
                }
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    var detailItem: Task? {
        didSet {
            // Update the view.
            self.configureView()
        }
    }

    // MARK: Segue
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let barButton = sender as? UIButton {
            if markCompletedButton == barButton {
                changed = true
                if detailItem?.completed == false {
                    detailItem?.completed = true
                }else{
                    detailItem?.completed = false
                }
            }
        }
    }
}

