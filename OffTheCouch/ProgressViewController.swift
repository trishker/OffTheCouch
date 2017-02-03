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
    @IBOutlet weak var couchView: UIImageView!
    @IBOutlet weak var animatedJumpView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,
                                                                 target: self,
                                                                 action: #selector(ProgressViewController.done))
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .cancel,
                                                                target: self,
                                                                action: #selector(ProgressViewController.cancel))
        updateUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
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
    
    func add(image name: String, toImageView: UIImageView) {
        if name == "jump" {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            toImageView.addSubview(imageView)
            
            imageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            imageView.alpha = 0
            
            UIView.animate(withDuration: 0.3) {
                imageView.alpha = CGFloat(self.dataModel.accumulatedPoints)/100
                imageView.transform = CGAffineTransform.identity
            }
            //           animationBehavior.addAnimation(imageView)
            
        } else if name == "couch" {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            toImageView.addSubview(imageView)
            imageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            imageView.alpha = 0
            
            UIView.animate(withDuration: 0.3) {
                imageView.alpha = 1 - (CGFloat(self.dataModel.accumulatedPoints)/100)
                imageView.transform = CGAffineTransform.identity
            }
        }
    }

    func add(label: UILabel) {
        label.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        label.alpha = 0
        label.isHidden = false
        UIView.animate(withDuration: 0.3) {
            label.transform = CGAffineTransform.identity
            label.alpha = 1
        }
    }
    
    func updateUI() {
        print("Accumulated points is \(dataModel.accumulatedPoints)")
        accumulatedPointsLabel.text = String(dataModel.accumulatedPoints)
        add(image: "couch", toImageView: couchView)
        add(image: "jump", toImageView: animatedJumpView)
        if dataModel.accumulatedPoints >= 100 {
            add(label: wellDoneYouLabel)
            accumulatedPointsLabel.text = ""
        } else {
            wellDoneYouLabel.isHidden = true
        }
    }

}
