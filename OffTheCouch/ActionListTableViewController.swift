//
//  ActionListTableViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 13/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

class ActionListTableViewController: UITableViewController, ActionDetailTableViewControllerDelegate {
    
    var actionItems = [ActionItem]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .edit,
                                     target: self,
                                     action: #selector(ActionListTableViewController.edit)))
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .add,
                                     target: self,
                                     action: #selector(ActionListTableViewController.add)))
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    func edit() {
        print("Edit button tapped")
    }
    
    func add() {
        self.performSegue(withIdentifier: "AddAction", sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print("Table view called with \(actionItems.count) rows")
        return actionItems.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItem", for: indexPath)
        let action = actionItems[indexPath.row]
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = action.text
        let labeln = cell.viewWithTag(1001) as! UILabel
        labeln.text = String(action.points)

        return cell
    }
    
    // MARK: - ActionDetailTableViewControllerDelegate
    
    func actionDetailTableViewControllerDidCancel(_ controller: ActionDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }

    func actionDetailTableViewController(_ controller: ActionDetailTableViewController, didFinishAddingAction action:ActionItem) {
        let newRowIndex = actionItems.count
        actionItems.append(action)
        let indexPath = IndexPath(row: newRowIndex, section: 0)
        let indexPaths = [indexPath]
        tableView.insertRows(at: indexPaths, with: .automatic)
        dismiss(animated: true, completion: nil)
    }


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


    // MARK: - Navigation
     
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "AddAction" {
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ActionDetailTableViewController
            controller.delegate = self
        }
    }
}
