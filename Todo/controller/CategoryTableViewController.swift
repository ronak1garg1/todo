//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by RONAK GARG on 11/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import UIKit
import CoreData
import RealmSwift

class CategoryTableViewController: UITableViewController {
    
    let realm = try! Realm() //initiliase Realm
    
    var categoryArray: Results<Category>?  //initiliase Category
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategory()  // use to load categories
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        
        var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)  //make an alert
        let action = UIAlertAction(title: "Add Category", style: .default){   //make an action
            (action) in
            
            let newCategory = Category()  //initiliase new category objext
            if let k = textField.text {
                newCategory.name = k
                
            }
            self.saveCategory(category: newCategory)   //call save category function
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return categoryArray?.count ?? 1   // get count of rows
       
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)  //
        let category = categoryArray?[indexPath.row]    //get category object by row
        cell.textLabel?.text = category?.name ?? "No Categories Added"
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)   //go to item by clickinh category
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let destinationVC = segue.destination as! ToDoListViewController     // give destinationVC access to ToDoListViewController
        
        if let indexPath = tableView.indexPathForSelectedRow{
            destinationVC.selectedCategory = categoryArray?[indexPath.row]    // paas selectedCategory some value
        }
    }
    
    func saveCategory(category: Category){
        
        do {
            try realm.write {   // update data in Realm
                realm.add(category)
            }
        }
        catch
        {
            print("\(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategory(){
        
       categoryArray = realm.objects(Category.self)   
        self.tableView.reloadData()
    }
    
}
