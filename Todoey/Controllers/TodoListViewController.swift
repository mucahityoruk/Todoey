//
//  ViewController.swift
//  Todoey
//
//  Created by mucahit on 30.04.2019.
//  Copyright © 2019 Mucahit Yoruk. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {

    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        let newItem = Item()
        newItem.title = "Find Mike"
         itemArray.append(newItem)

        let newItem2 = Item()
        newItem2.title = "Buy Eggs"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demorgon"
        itemArray.append(newItem3)
        
     
        
        
        
        if let items = defaults.array(forKey: "ToDoListArray") as? [Item]
        {
            itemArray = items
        }
  
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    
    // TABLE FUNCTIONS
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
        
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.title
        
        cell.accessoryType = item.done ? .checkmark : .none
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //print(itemArray[indexPath.row])
        
        //tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
     
        itemArray[indexPath.row].done  = !itemArray[indexPath.row].done
        
        
        
        tableView.reloadData()
        
        if(tableView.cellForRow(at: indexPath)?.accessoryType == .checkmark)
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .none
            
        }else
        {
            tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
        }
        
        tableView.deselectRow(at: indexPath, animated: true	)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
    
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add new todo item",message: "",preferredStyle: .alert )
    
    
        let action = UIAlertAction(title: "Add Item", style: .default)
        {
            (action) in
            //print(textField.text)
    
            let newItem = Item()
            newItem.title = textField.text!
            
            
            
            self.itemArray.append(newItem) //itemArray.append(textField.text!)
            
            
            self.defaults.set(self.itemArray, forKey: "ToDoListArray")
            self.tableView.reloadData()
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
        
            textField = alertTextField
          //  print(alertTextField.text)
            
            
        }
        
        alert.addAction(action)
        //alert.addTextField(configurationHandler: <#T##((UITextField) -> Void)?##((UITextField) -> Void)?##(UITextField) -> Void#>)
        
        present(alert, animated: true, completion: nil)
        
    }
    
    
}

