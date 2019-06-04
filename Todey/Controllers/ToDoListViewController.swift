//
//  ViewController.swift
//  Todey
//
//  Created by clerin binil on 23/05/19.
//  Copyright © 2019 clerin binil. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {

   // var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    var itemArray = [Item]()
  //  let defaults = UserDefaults.standard
    
    // persisting the data with nscoder
    // creating a file path to the document filefolder
    let dataFilePath = FileManager.default.urls(for:  .documentDirectory , in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    //// user domain mask is the location where we gonna save personal items associated with the app
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a filepath to the document folder
       
        //print(dataFilePath)
         loadItems()
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]  {
//            itemArray = items
//        }
        
       /* let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
        
        let newItem2 = Item()
        newItem2.title = "Find El"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Buy Eggos"
        itemArray.append(newItem3) */
        
//        let newItem4 = Item()
//        newItem4.title = "Find Mike"
//        itemArray.append(newItem4)
//
//        let newItem5 = Item()
//        newItem5.title = "Find El"
//        itemArray.append(newItem5)
//
//        let newItem6 = Item()
//        newItem6.title = "Buy Eggos"
//        itemArray.append(newItem6)
//
//        let newItem7 = Item()
//        newItem7.title = "Find Mike"
//        itemArray.append(newItem7)
//
//        let newItem8 = Item()
//        newItem8.title = "Find Mike"
//        itemArray.append(newItem8)
//
//        let newItem9 = Item()
//        newItem9.title = "Find Mike"
//        itemArray.append(newItem9)
//
//        let newItem0 = Item()
//        newItem0.title = "Find Mike"
//        itemArray.append(newItem0)
//
//        let newItem11 = Item()
//        newItem11.title = "Find Mike"
//        itemArray.append(newItem11)
//
//        let newItem12 = Item()
//        newItem12.title = "Find Mike"
//        itemArray.append(newItem12)
//
//        let newItem13 = Item()
//        newItem13.title = "Find Mike"
//        itemArray.append(newItem13)
//
//        let newItem14 = Item()
//        newItem14.title = "Find Mike"
//        itemArray.append(newItem14)
//
//        let newItem15 = Item()
//        newItem15.title = "Find Mike"
//        itemArray.append(newItem15)
//
//        let newItem16 = Item()
//        newItem16.title = "Find Mike"
//        itemArray.append(newItem16)
//
//        let newItem17 = Item()
//        newItem17.title = "Find Mike"
//        itemArray.append(newItem17)
//
//        let newItem18 = Item()
//        newItem18.title = "Find Mike"
//        itemArray.append(newItem18)
    }

    // MARK - Table View Datasource Method
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
         let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
         let item = itemArray[indexPath.row]// engane exhuthumpol long coding ozhivaakam
         cell.textLabel!.text = item.title
         // cell.textLabel!.text = itemArray[indexPath.row].title
    
//        if item.done == true {
//           cell.accessoryType = .checkmark
//        }
//        else {
//            cell.accessoryType = .none
//        }
    // using ternary operator
    
    // value = condition ? valueIfTrue : valueIfFalse
    
    cell.accessoryType = item.done == true ? .checkmark : .none  // simplified code
    // cell.accessoryType = item.done ? .checkmark : .none
    
       return cell
     }
    
    //MARK - Table View Delegate Method
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      // print(itemArray[indexPath.row])
       
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        // to shorten the length of code, above coding is best
       /* if itemArray[indexPath.row].done ==  false{
            itemArray[indexPath.row].done = true
        }
        else {
            itemArray[indexPath.row].done = false
        } */
        
//        if (tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark) {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .none
//        }
//        else {
//            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
//        }
        saveItems()
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
 
    @IBAction func barButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController.init(title: "Add todoey new item", message: "", preferredStyle: .alert)
        
            let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            let newItem = Item()
            newItem.title = textField.text!
            self.itemArray.append(newItem)
           
               
            //self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.saveItems()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            //print(alertTextField.text)
        }
        
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveItems(){
        
        let encoder = PropertyListEncoder()
        do {
            let data = try encoder.encode(itemArray)
            try data.write(to:dataFilePath!)
        }
        catch {
            print("Error encoding item array \(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadItems() {
        
        if let data = try? Data(contentsOf: dataFilePath!) {
        let decoder = PropertyListDecoder()
            do {
                // itemArray = try? decoder.decode([Item].self, from: data)
                itemArray = try! decoder.decode([Item].self, from: data)
               }
            catch {
                print("Error decoding itemarray , \(error)")
            }
            
      }
    }
}

