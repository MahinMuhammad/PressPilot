//
//  AuthService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/19/23.
//

/*
 Copyright 2023 Md. Mahinur Rahman
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
import FirebaseCore
import FirebaseAuth
import SwiftUI

class AuthManager : ObservableObject {
    static let shared = AuthManager()
    @Published var isSignedIn:Bool
    @Published var errorMessage:String = ""
    let defaults = UserDefaults.standard
    
    init() {
        if Auth.auth().currentUser != nil{
            self.isSignedIn = true
        }else{
            self.isSignedIn = false
        }
    }
    
    func signUpUser(firstName:String, lastName:String, email:String, password:String, completion: @escaping (Error?) -> Void){
        Auth.auth().createUser(withEmail: email, password: password) { [self] authResult, error in
            if let e = error{
                let err = e as NSError
                completion(err)
            }else{
                print("User registration successfull!")
                DispatchQueue.main.async {
                    UserDataManager().storeUserData(firstName: firstName, lastName: lastName, email: email)
                    self.isSignedIn = true
                }
            }
        }
    }
    
    func signInUser(email:String, password:String, completion: @escaping (Error?) -> Void){
        Auth.auth().signIn(withEmail: email, password: password){ response, error in
            if let e = error{
                let err = e as NSError
                completion(err)
            }else{
                print("User signIn successfull!")
                DispatchQueue.main.async{
                    self.isSignedIn = true
                }
            }
        }
    }
    
    func signOut()->Bool{
        do {
            try Auth.auth().signOut()
            self.isSignedIn = false
            return true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return false
        }
    }
    
}
