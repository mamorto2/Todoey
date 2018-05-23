//
//  ViewController.swift
//  Todoey
//
//  Created by Mark Morton on 5/17/18.
//  Copyright © 2018 Mark Morton. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
// because using TableViewContorller & have tableviewController in storyboard, there is no need to setup a Delegate, IBOutlet, or Datasource.  Is automatically taken care of by Xcode behind the scene
 
    var itemArray = [Item]()
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
   
        let newItem = Item()
        newItem.title = "Find Mike"
        itemArray.append(newItem)
    
        let newItem2 = Item()
        newItem2.title = "Buy Eggos"
        itemArray.append(newItem2)
        
        let newItem3 = Item()
        newItem3.title = "Destroy Demogorgon"
        itemArray.append(newItem3)
        
        
        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
        
        
    }

    //MARK: - Tableview Datasource Methods
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        let item = itemArray[indexPath.row]
        //      above line replaces -> itemArray[indexPath.row] in many places and saves typing
//        cell.textLabel?.text = itemArray[indexPath.row].title
        cell.textLabel?.text = item.title

        // Ternary operator
        // value = condition ? valueIfTrue : valueIfFalse
        cell.accessoryType = item.done ? .checkmark : .none
//        cell.accessoryType = item.done == true ? .checkmark : .none
        //    Line Above replaces Lines Below:
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        } else {
//            cell.accessoryType = .none
//        }
        
        
        return cell
    }
    
    //MARK: - TableView Delegate Methods
    
// Nope   message.TableView.delegate = self
// Nope   message.TableView.dataSource = self

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath.row)
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
//      Below lines of code equal Above line of code
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        } else {
//            itemArray[indexPath.row].done = false
//        }
        
        tableView.reloadData()
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    //MARK: - Add New Items
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            // what will happen once the user clicks the Add Item button on our UIAlert

            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            
            self.defaults.set(self.itemArray, forKey: "TodoListArray")
    
            self.tableView.reloadData()
            
        }
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
            print("Now")
        }
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
        
    }
}







