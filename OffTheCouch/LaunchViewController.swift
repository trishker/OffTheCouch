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
    @IBOutlet weak var couchView: UIImageView!
    @IBOutlet weak var animatedJumpView: UIImageView!
    
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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        dataModel.calculateAccumulatedPoints()
        updateUI()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
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
    
    func add(image name: String, toImageView: UIImageView) {
        if name == "jump" {
            let image = UIImage(named: name)
            let imageView = UIImageView(image: image)
            toImageView.addSubview(imageView)
            
            imageView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
            imageView.alpha = 0
            
            UIView.animate(withDuration: 0.3) {
                imageView.alpha = 1
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
                imageView.alpha = 1
                imageView.transform = CGAffineTransform.identity
            }
        }
    }
    
    func removeImage() {
        if let subViews = couchView?.subviews {
            for subView in subViews {
                if subView.isMember(of: UIImageView.self) {
                    let imageView = subView as! UIImageView
                    imageView.removeFromSuperview()
                }
            }
            // remove code after animating
        } else if let subViews = animatedJumpView?.subviews {
            for subView in subViews {
                if subView.isMember(of: UIImageView.self) {
                    let imageView = subView as! UIImageView
                    imageView.removeFromSuperview()
                }
            }
        }
    }
    
    func removeAnimations() {
        if let subViews = animatedJumpView?.subviews {
            for subView in subViews {
                if subView.isMember(of: UIImageView.self) {
                    let imageView = subView as! UIImageView
                    imageView.removeFromSuperview()
//                    animationBehavior.removeAnimation(imageView)
                }
            }
        }
    }

    func updateUI() {
        removeAnimations()
        removeImage()
        if dataModel.accumulatedPoints == 0 {
            wellDoneYouLabel.isHidden = true
            add(label: offTheCouchLabel)
            add(image: "couch", toImageView: couchView)
        } else if dataModel.accumulatedPoints < 100 {
            wellDoneYouLabel.isHidden = true
            offTheCouchLabel.isHidden = true
            add(image: "jump", toImageView: animatedJumpView)
        } else {
            add(label: wellDoneYouLabel)
            offTheCouchLabel.isHidden = true
            add(image: "jump", toImageView: animatedJumpView)
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

