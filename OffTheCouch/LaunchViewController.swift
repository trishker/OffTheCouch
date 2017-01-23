//
//  LaunchViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 12/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    var dataModel: DataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActionList" {
            let controller = segue.destination as! ActionListTableViewController
            controller.dataModel = dataModel
        }
    }



}

