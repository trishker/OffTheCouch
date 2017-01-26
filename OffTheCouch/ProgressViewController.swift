//
//  ProgressViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 24/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

protocol ProgressViewControllerDelegate: class {
    
    func progressViewController(_ controller: ProgressViewController, didCancelWithActionItem action: ActionItem)
    func progressViewController(_ controller: ProgressViewController, didFinishUpdatingProgress action: ActionItem)
    
}

class ProgressViewController: UIViewController {
    
    var dataModel: DataModel!
    var actionItem: ActionItem?
    
    weak var delegate: ProgressViewControllerDelegate?

    @IBOutlet weak var accumulatedPointsLabel: UILabel!
    @IBOutlet weak var wellDoneYouLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,
                                                                 target: self,
                                                                 action: #selector(ProgressViewController.done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .cancel,
                                                                target: self,
                                                                action: #selector(ProgressViewController.cancel))
        accumulatedPointsLabel.text = String(dataModel.accumulatedPoints)
        updateUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func done() {
        if let item = actionItem {
            delegate?.progressViewController(self, didFinishUpdatingProgress: item)
        }
    }
    
    func cancel() {
        if let item = actionItem {
            item.numberOfChecks -= 1
            delegate?.progressViewController(self, didCancelWithActionItem: item)
        }
    }
    
    func updateUI() {
        if dataModel.accumulatedPoints >= 100 {
            wellDoneYouLabel.isHidden = false
            accumulatedPointsLabel.text = ""
        } else {
            wellDoneYouLabel.isHidden = true
        }
    }

}
