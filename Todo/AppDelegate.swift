//
//  AppDelegate.swift
//  Todo
//
//  Created by RONAK GARG on 05/07/18.
//  Copyright © 2018 RONAK GARG. All rights reserved.
//

import UIKit
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
       // print(Realm.Configuration.defaultConfiguration.fileURL)
     
        do{
            _ = try Realm()
            
        }catch{
            print(error)
        }
        return true
    }


}

