//
//  AddViewController.swift
//  Bucket List
//
//  Created by Noel Mendoza on 1/17/18.
//  Copyright © 2018 Noel Mendoza. All rights reserved.
//

import UIKit
import CoreData

protocol AddItemDelegate {
    func addItem(item: String, didEdit: Item?)
}

class AddViewController: UIViewController {
   
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var addEditButton: UIButton!
    
    var delegate: AddItemDelegate?
    var item: String?
    var itemToEdit: Item?
    
    @IBOutlet var itemField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        if let myItem = itemToEdit {
            itemField.text = myItem.item
            titleLabel.text = "Edit your item"
            addEditButton.setTitle("Edit", for: .normal)
        }
    
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func addButtonPressed(_ sender: UIButton) {
        delegate?.addItem(item: itemField.text!, didEdit: itemToEdit)
    
    }
}
