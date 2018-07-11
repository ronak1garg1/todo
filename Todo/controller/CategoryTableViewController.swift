//
//  CategoryTableViewController.swift
//  Todo
//
//  Created by RONAK GARG on 11/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import UIKit
import CoreData

class CategoryTableViewController: UITableViewController {
    
    
    var categoryArray = [Category]()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        loadCategory()
    }
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
         var textField = UITextField()
        let alert = UIAlertController(title: "Add New Category", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Category", style: .default){
            (action) in
            
            let newCategory = Category(context: self.context)
            newCategory.name = textField.text
        self.categoryArray.append(newCategory)
            self.saveCategory()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create New Category"
            textField = alertTextField
        }
        alert.addAction(action)
        present(alert,animated: true,completion: nil)
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryArray.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CategoryCell", for: indexPath)
        let category = categoryArray[indexPath.row]
        cell.textLabel?.text = category.name
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        performSegue(withIdentifier: "goToItems", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC = segue.destination as! ToDoListViewController
        if let indexPath = tableView.indexPathForSelectedRow{
          destinationVC.selectedCategory = categoryArray[indexPath.row]
        }
    }
    
    func saveCategory(){
        
        _ = PropertyListEncoder()
        
        do {
            try context.save()
        }
        catch
        {
            print("\(error)")
        }
        self.tableView.reloadData()
    }
    
    
    func loadCategory(with request : NSFetchRequest<Category> = Category.fetchRequest()){
        do{
        categoryArray = try context.fetch(request)
        }
        catch{
            print(error)
        }
        
        self.tableView.reloadData()
    }
    
    
    
}
