//
//  DataService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/30/23.
//

import Foundation
import FirebaseFirestore

class DataService: ObservableObject{
    let db = Firestore.firestore()
    
    func storeUserData(firstName:String, lastName:String, email:String){
        db.collection("users").addDocument(data: [
            "firstName" : firstName,
            "lastName" : lastName,
            "email" : email
        ]){ error in
            if let e = error{
                print("Error adding user details: \(e)")
            }else{
                print("User details successfully added")
            }
        }
    }
}
