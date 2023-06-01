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
    
    @Published var userData:UserData?
    
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
            userDataCollection.getDocuments { querySnapshot, error in
                if let e = error{
                    print("Failed to retrive user data: \(e)")
                }else{
                    if let snapshotDocuments = querySnapshot?.documents{
                        let data = snapshotDocuments[0].data()
                        if let firstName = data[K.FStore.firstNameField] as? String, let lastName = data[K.FStore.lastNameField] as? String, let email = data[K.FStore.emailField] as? String{
                            self.userData = UserData(firstName: firstName, lastname: lastName, email: email)
                        }
                    }
                }
            }
        }
    }
}
