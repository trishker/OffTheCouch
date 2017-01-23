//
//  ActionDetailTableViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 14/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

protocol ActionDetailTableViewControllerDelegate: class {
    func actionDetailTableViewControllerDidCancel(_ controller: ActionDetailTableViewController)
    func actionDetailTableViewController(_ controller: ActionDetailTableViewController, didFinishAddingAction action:ActionItem)
//    func actionDetailTableViewController(_ controller: ActionDetailTableViewController, didFinishEditingAction action: ActionItem)
}


class ActionDetailTableViewController: UITableViewController, UITextFieldDelegate {
    
    weak var delegate: ActionDetailTableViewControllerDelegate?

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var numberField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func cancel(_ sender: UIBarButtonItem) {
        delegate?.actionDetailTableViewControllerDidCancel(self)
    }
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        let action = ActionItem()
        action.text = textField.text!
        if let pointsString = numberField?.text {
            action.points = Int(pointsString)!
        }
        delegate?.actionDetailTableViewController(self, didFinishAddingAction: action)
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        return nil
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
