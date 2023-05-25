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

class AuthService : ObservableObject {
    @Published var signedIn:Bool
    @Published var error:Error?
    
    init() {
        if Auth.auth().currentUser != nil{
            self.signedIn = true
        }else{
            self.signedIn = false
        }
    }
    
    // Make sure the API calls once they are finished modify the values on the Main Thread
    func signUpUser(firstName:String, lastName:String, email:String, password:String){
        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
            if let e = error{
                print("Failed to sign up with error: \(e)")
            }else{
                print("User registration successfull!")
                self.signedIn = true
            }
        }
    }
    
    func signInUser(email:String, password:String){
        Auth.auth().signIn(withEmail: email, password: password){ response, error in
            if let e = error{
                print("SignIn failed with error: \(e)")
            }else{
                print("User signIn successfull!")
                self.signedIn = true
            }
        }
    }
    
    func signOut()->Bool{
        do {
            try Auth.auth().signOut()
            self.signedIn = false
            return true
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            return false
        }
    }
    
}
