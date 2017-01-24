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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,
                                                                 target: self,
                                                                 action: #selector(ProgressViewController.done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .cancel,
                                                                target: self,
                                                                action: #selector(ProgressViewController.cancel))
        accumulatedPointsLabel.text = String(dataModel.accumulatedPoints)
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
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
