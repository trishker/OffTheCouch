//
//  LaunchViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 12/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController {
    
    @IBOutlet weak var wellDoneYouLabel: UILabel!
    @IBOutlet weak var offTheCouchLabel: UILabel!
    
    var dataModel: DataModel!
    
    @IBAction func startOver(_ sender: UIButton) {
        for action in dataModel.actions {
            action.checked = false
            action.numberOfChecks = 0
        }
        dataModel.calculateAccumulatedPoints()
        updateUI()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateUI()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func updateUI() {
        if dataModel.accumulatedPoints == 0 {
            wellDoneYouLabel.isHidden = true
            offTheCouchLabel.isHidden = false
        } else if dataModel.accumulatedPoints < 100 {
            wellDoneYouLabel.isHidden = true
            offTheCouchLabel.isHidden = true
        } else {
            wellDoneYouLabel.isHidden = false
            offTheCouchLabel.isHidden = true
        }
        
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowActionList" {
            let controller = segue.destination as! ActionListTableViewController
            controller.dataModel = dataModel
        }
    }



}

