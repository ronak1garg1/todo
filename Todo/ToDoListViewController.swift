//
//  ViewController.swift
//  Todo
//
//  Created by RONAK GARG on 05/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import UIKit

class ToDoListViewController: UITableViewController {
    
    var itemArray = [ToDoModel]()
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Items.plist")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(dataFilePath)
        let item = ToDoModel()
        item.data = "Finding Dorry"
        itemArray.append(item)
        
        let item2 = ToDoModel()
        item2.data = "Coming Dorry"
        itemArray.append(item2)
        
        let item3 = ToDoModel()
        item3.data = "Daring Dorry"
        itemArray.append(item3)
        
        
//        if let items = defaults.array(forKey: "ToDoListArray") as? [ToDoModel] {
//        itemArray = items
//        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return  itemArray.count
    }
 
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
      
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        let item = itemArray[indexPath.row]
        cell.textLabel?.text = item.data
        
        cell.accessoryType = item.done ? .checkmark : .none
     
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
      
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
      self.saveItems()
        tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW ITEM", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD ITEM", style: .default){
            (action) in
            
            let newItem = ToDoModel()
            newItem.data = textField.text!
            self.itemArray.append(newItem)
            self.saveItems()
            
            }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
         alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    func saveItems(){
        let encoder = PropertyListEncoder()
        
        do {
            let k = try encoder.encode(itemArray)
            try k.write(to: dataFilePath!)
        }
        catch
        {
            print("\(error)")
        }
          self.tableView.reloadData()
    }
}

