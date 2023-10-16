//
//  DataController.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/15/23.
//

import Foundation
import CoreData

class DataController:ObservableObject{
    let container = NSPersistentContainer(name: "PressPilot")
    
    init(){
        container.loadPersistentStores { description, error in
            if let error{
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
