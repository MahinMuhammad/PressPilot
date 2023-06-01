//
//  DataService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/30/23.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class DataService: ObservableObject{
    let db = Firestore.firestore()
    
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var email:String = ""
    
    func storeUserData(firstName:String, lastName:String, email:String){
        db.collection(K.FStore.userCollectionName).addDocument(data: [
            K.FStore.firstNameField : firstName,
            K.FStore.lastNameField : lastName,
            K.FStore.emailField : email
        ]){ error in
            if let e = error{
                print("Error adding user details: \(e)")
            }else{
                print("User details successfully added")
            }
        }
    }
    
    func readUserData(){
        let firestoreCollection = db.collection(K.FStore.userCollectionName)
        
        if let currentUserEmail = Auth.auth().currentUser?.email{
            let userDataCollection = firestoreCollection.whereField(K.FStore.emailField, isEqualTo: currentUserEmail)
            userDataCollection.addSnapshotListener { querySnapshot, error in
                if let e = error{
                    print("Failed to retrive user data: \(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        print(snapshotDocuments.count)
                    }
                }
            }
        }
    }
}
