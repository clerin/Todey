//
//  ViewController.swift
//  Todey
//
//  Created by clerin binil on 23/05/19.
//  Copyright © 2019 clerin binil. All rights reserved.
//

import UIKit
import CoreData

class ToDoListViewController: UITableViewController {

   // var itemArray = ["Find Mike","Buy Eggos","Destroy Demogorgon"]
    var itemArray = [Item]()
    var selectedCategory : Category? {
        didSet{
            loadItems()
        }
    }
  //  let defaults = UserDefaults.standard
    
    // persisting the data with nscoder
    // creating a file path to the document filefolder
   
    //// user domain mask is the location where we gonna save personal items associated with the app
     let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // create a filepath to the document folder
        let dataFilePath = FileManager.default.urls(for:  .documentDirectory , in: .userDomainMask)
        //print(dataFilePath)
        
        // loadItems()
        
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
       
        // itemArray[indexPath.row].setValue("Completed", forKey: "title") // to change the value of selected row
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
         context.delete(itemArray[indexPath.row])
         itemArray.remove(at: indexPath.row)
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
            let newItem = Item(context: self.context)
            newItem.title = textField.text!
            newItem.done = false
            newItem.parentCategory = self.selectedCategory
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
    
    func saveItems() {
        do {
            try context.save()
        }
        catch {
            print("Error saving context \(error)")
        }
        self.tableView.reloadData()
    }
    /* func loadItems() {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        do {
           itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from contect \(error)")
        }
     } */
    
    func loadItems(with request : NSFetchRequest<Item> = Item.fetchRequest(), predicate:NSPredicate? = nil) {
       
        let categoryPredicate = NSPredicate(format: "parentCategory.name MATCHES %@", selectedCategory!.name!)
        if let additionalPredicate = predicate{
            request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,additionalPredicate])
        }
        else {
            request.predicate = categoryPredicate
        }
        
//        let compoundPredicate = NSCompoundPredicate(andPredicateWithSubpredicates: [categoryPredicate,predicate])
//
//        request.predicate = compoundPredicate 
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from context \(error)")
        }
        tableView.reloadData()
    }

}

// MARK : - search bar method

extension ToDoListViewController : UISearchBarDelegate {
    
    // elaborated function for more understanding and readability
    
   /* func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        request.predicate = predicate
        let sortDescriptor = NSSortDescriptor(key: "title", ascending: true)
        request.sortDescriptors = [sortDescriptor]
        do {
            itemArray = try context.fetch(request)
        }
        catch {
            print("Error fetching data from contect \(error)")
        }
        tableView.reloadData()
    }*/
    
    
    // short written function - same as above function
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let request : NSFetchRequest<Item> = Item.fetchRequest()
       let predicate = NSPredicate(format: "title CONTAINS[cd] %@", searchBar.text!)
        
        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        loadItems(with: request, predicate: predicate)
//        do {
//            itemArray = try context.fetch(request)
//        }
//        catch {
//            print("Error fetching data from contect \(error)")
//        }
  //     tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text?.count == 0 {
            loadItems()
        }
        DispatchQueue.main.async {
            searchBar.resignFirstResponder()
        }
        
    }
}
