//
//  ViewController.swift
//  Bucket List
//
//  Created by Noel Mendoza on 1/17/18.
//  Copyright © 2018 Noel Mendoza. All rights reserved.
//

import UIKit
import CoreData

class TodoViewController: UITableViewController, AddItemDelegate {
    
    var storedData = [Item]()
    
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
   
    //MARK: Table View Function
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // grab segue desntination as specific type of controller
        // set the controller delegate to self
        
        if segue.identifier == "addSegue"{
            let addController = segue.destination as! AddViewController
            addController.delegate = self
            print("added delegate")
        } else{
            let addController = segue.destination as! AddViewController
            addController.delegate = self
            addController.itemToEdit = sender as? Item
        }
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemToEdit = storedData[indexPath.row]
        performSegue(withIdentifier: "EditSegue", sender: itemToEdit)
    }
    
    func fetchAndReload(){
        do {
            let myData = try managedObjectContext.fetch(Item.fetchRequest()) as [Item]
            storedData = myData
        } catch {
            print(error)
        }
        tableView.reloadData()
    }
    
    func saveData(){
        if managedObjectContext.hasChanges {
        do {
            try managedObjectContext.save()
            } catch {
                print(error)
            }
        }
        fetchAndReload()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell")
        cell?.textLabel?.text = storedData[indexPath.row].item
        return cell!
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storedData.count
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
      let toDel = storedData[indexPath.row]
        managedObjectContext.delete(toDel)
        saveData()
    }
    
    //MARK: Delegate Function
    
        func addItem(item: String, didEdit: Item?) {
        navigationController?.popViewController(animated: true)
        
            if let editedItem = didEdit {
                editedItem.item = item
                saveData()
            } else {
                var newItem = Item(context: managedObjectContext)
                newItem.item = item
            }
        saveData()
    }
}

