//
//  AuthService.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/19/23.
//

import Foundation
import FirebaseCore
import FirebaseAuth

class AuthService : ObservableObject {
    @Published var signedIn:Bool
    
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
                DispatchQueue.main.async {
                    print("Failed to sign up with error: \(e)")
                }
            }else{
                DispatchQueue.main.async {
                    print("User registration successfull!")
                    self.signedIn = true
                }
            }
        }
    }
    
    func signOut(){
        self.signedIn = false
    }
    
}
