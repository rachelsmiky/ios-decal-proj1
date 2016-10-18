//
//  StatsViewController.swift
//  To-Do List
//
//  Created by Rachel Song on 10/15/16.
//  Copyright © 2016 Rachel Song. All rights reserved.
//

import Foundation
import UIKit

class StatsViewController: UIViewController {
    
    @IBOutlet weak var totalCount: UILabel!
    
    var count = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        totalCount.text = String(count)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
