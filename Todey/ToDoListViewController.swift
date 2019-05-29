//
//  ViewController.swift
//  Todey
//
//  Created by clerin binil on 23/05/19.
//  Copyright © 2019 clerin binil. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

    var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    let defaults = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        if let items = defaults.array(forKey: "ToDoListArray") as? [String]  {
            itemArray = items
        }
        
    }

    // MARK - Table View Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

 override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
    cell.textLabel!.text = itemArray[indexPath.row]
    return cell
    }
    
    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // print(itemArray[indexPath.row])
       
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
        }
        else {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
 
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add todoey new item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            self.itemArray.append(textField.text! )
            self.tableView.reloadData()
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            print(alertTextField.text)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

