//
//  ViewController.swift
//  Todo
//
//  Created by RONAK GARG on 05/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import UIKit
import RealmSwift


class ToDoListViewController: UITableViewController {
    
    let realm = try! Realm()  //initiliase Realm
    var todoItems: Results<ToDoModel>?  //initiliase todoItems
    
    var selectedCategory : Category? {
        didSet{    //will select the category and load items
            loadItems()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  todoItems?.count ?? 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        if let item = todoItems?[indexPath.row] {
            
            cell.textLabel?.text = item.data
            
            cell.accessoryType = item.done ? .checkmark : .none    // will check and uncheck the row
        }
        else{
            cell.textLabel?.text = "No items added"
        }
        
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let k = todoItems?[indexPath.row]{
            
            do{
                try realm.write {
                   k.done = !k.done
                 //   realm.delete(k)
                }
            }
            catch{
                print(error)
            }
        }
        self.tableView.reloadData()
        
        self.tableView.deselectRow(at: indexPath, animated: true)
        
    }
    
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        
        let alert = UIAlertController(title: "ADD NEW ITEM", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "ADD ITEM", style: .default){
            (action) in
            
            
            if let s = self.selectedCategory{
                do{
                    try self.realm.write {
                        let newItem = ToDoModel()
                        newItem.data = textField.text!
                        newItem.date = Date()
                        s.list.append(newItem)   //will append the newItem in the list property of the category object
                    }
                } catch{
                    print(error)
                }
            }
            self.tableView.reloadData()
        }
        
        
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Item"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
        
    }
    
    func loadItems(){
        
        todoItems = selectedCategory?.list.sorted(byKeyPath: "data", ascending: true)   // loads items by sorting by data
        
        self.tableView.reloadData()
    }
    
}

extension ToDoListViewController : UISearchBarDelegate{

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
    
        todoItems = todoItems?.filter("data CONTAINS[cd] %@",searchBar.text!).sorted(byKeyPath: "date", ascending: false) //predicate
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        if searchBar.text?.count == 0 {
            
            loadItems()
            DispatchQueue.main.async {
                searchBar.resignFirstResponder()
            }

        }
    }
}
