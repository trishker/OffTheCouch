//
//  ActionListTableViewController.swift
//  OffTheCouch
//
//  Created by Trish Kernan on 13/01/2017.
//  Copyright © 2017 Trish Kernan. All rights reserved.
//

import UIKit

class ActionListTableViewController: UITableViewController, ActionDetailTableViewControllerDelegate {
    
    var dataModel: DataModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addEditAddButtons()
    }
    
    func addEditAddButtons() {
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .edit,
                                     target: self,
                                     action: #selector(ActionListTableViewController.edit)))
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .add,
                                     target: self,
                                     action: #selector(ActionListTableViewController.add)))
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    func addDoneAddButtons() {
        var items = [UIBarButtonItem]()
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .done,
                                     target: self,
                                     action: #selector(ActionListTableViewController.done)))
        items.append(UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem .add,
                                     target: self,
                                     action: #selector(ActionListTableViewController.add)))
        
        self.navigationItem.rightBarButtonItems = items
    }
    
    func edit() {
        if (!tableView.isEditing) {
            tableView.setEditing(true, animated: false)
            addDoneAddButtons()
        }
    }
    
    func add() {
        self.performSegue(withIdentifier: "AddAction", sender: self)
    }
    
    func done() {
        tableView.isEditing = false
        addEditAddButtons()
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
        return dataModel.actions.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ActionItem", for: indexPath)
        let action = dataModel.actions[indexPath.row]

        configureTextForCell(cell, withActionItem: action)
        configurePointsForCell(cell, withActionItem: action)
        configureCheckmarkForCell(cell, withActionItem: action)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        dataModel.actions.remove(at: indexPath.row)
        let indexPaths = [indexPath]
        tableView.deleteRows(at: indexPaths, with: .automatic)
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let actionToMove = dataModel.actions[sourceIndexPath.row]
        dataModel.actions.remove(at: sourceIndexPath.row)
        dataModel.actions.insert(actionToMove, at: destinationIndexPath.row)
//        dataModel.saveActions()
    }

    
    // MARK: - Table view delegate
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if let cell = tableView.cellForRow(at: indexPath) {
            let action = dataModel.actions[indexPath.row]
            action.incrementChecked()
            configureCheckmarkForCell(cell, withActionItem: action)
            dataModel.calculateAccumulatedPoints()
//            dataModel.saveActions()
        }
    }
    
    // MARK: - ActionDetailTableViewControllerDelegate
    
    func actionDetailTableViewControllerDidCancel(_ controller: ActionDetailTableViewController) {
        dismiss(animated: true, completion: nil)
    }

    func actionDetailTableViewController(_ controller: ActionDetailTableViewController, didFinishAddingAction action:ActionItem) {
        let newRowIndex = dataModel.actions.count
        dataModel.actions.append(action)
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
    
    // MARK: - Helper methods
    
    func configureCheckmarkForCell(_ cell: UITableViewCell, withActionItem action: ActionItem) {
        let label = cell.viewWithTag(1002) as! UILabel
        if action.checked {
            if action.numberOfChecks == 0 {
                label.text = ""
            } else if action.numberOfChecks == 1 {
                label.text = "√"
            } else if action.numberOfChecks == 2 {
                label.text = "√√"
            } else if action.numberOfChecks == 3 {
                label.text = "√√√"
            } else {
                label.text = String(action.numberOfChecks) + "√"
            }
        } else {
            label.text = ""
        }
        label.textColor = view.tintColor
    }
    
    func configureTextForCell(_ cell: UITableViewCell, withActionItem action: ActionItem) {
        let label = cell.viewWithTag(1000) as! UILabel
        label.text = action.text
    }
    
    func configurePointsForCell(_ cell: UITableViewCell, withActionItem action: ActionItem) {
        let label = cell.viewWithTag(1001) as! UILabel
        label.text = String(action.points)
    }
    

}
