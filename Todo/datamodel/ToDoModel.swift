//
//  ToDoModel.swift
//  Todo
//
//  Created by RONAK GARG on 11/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import Foundation
import RealmSwift


class ToDoModel: Object {
    @objc dynamic var data : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var date : Date?
    
    var parentCategory = LinkingObjects(fromType: Category.self, property: "list") //back relationship to category
}
