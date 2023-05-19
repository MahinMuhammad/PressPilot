//
//  FirebaseBridge.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/18/23.
//

import Foundation
import SwiftUI
import FirebaseCore
import FirebaseAuth

//struct FirebaseBridge{
//    static func signUpUser(firstName:String, lastName:String, email:String, password:String)->Bool{
//        var flag:Bool = false
//        Auth.auth().createUser(withEmail: email, password: password) { authResult, error in
//            if let e = error{
//                print("Failed to sign up with error: \(e)")
//            }else{
//                print("User registration successfull!")
//                flag = true
//            }
//        }
//        return flag
//    }
//}
