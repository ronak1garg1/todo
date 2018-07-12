//
//  Category.swift
//  Todo
//
//  Created by RONAK GARG on 11/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    
    @objc dynamic var name : String = ""
    
    let list = List<ToDoModel>()   //relates the todomodel to category

}
