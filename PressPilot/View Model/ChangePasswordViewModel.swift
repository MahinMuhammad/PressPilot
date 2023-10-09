//
//  ChangePasswordViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
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
import Firebase

final class ChangePasswordViewModel:ObservableObject{
    @Published var oldPassword:String = ""
    @Published var newPassword:String = ""
    @Published var confirmPassword:String = ""
    
    @Published var oldPasswordWarning:String?
    @Published var newPasswordWarning:String?
    @Published var confirmPasswordWarning:String?
    
    @Published var showCompletionAlert = false
    
    let dataManager = DataManager.shared
    let authManager = AuthManager.shared
    
    func isFormValid()->Bool{
        oldPasswordWarning = ""
        newPasswordWarning = ""
        confirmPasswordWarning = ""
        
        if oldPassword == ""{
            oldPasswordWarning = "Old Password Required"
            return false
        }
        
        if newPassword == ""{
            newPasswordWarning = "New Password Required"
            return false
        }
        
        if newPassword != confirmPassword{
            confirmPasswordWarning = "Password does not match"
            return false
        }
        return true
    }
    
    func resetPressed(){
        dataManager.updatePassword(from: oldPassword, to: newPassword) { error in
            if let error{
                let nsError = error as NSError
                switch nsError.code{
                case AuthErrorCode.wrongPassword.rawValue:
                    self.oldPasswordWarning = "Wrong password"
                case AuthErrorCode.weakPassword.rawValue:
                    self.newPasswordWarning = "Password is too weak"
                default:
                    print("Failed to sign in with error: \(error)")
                }
            }else{
                self.showCompletionAlert = true
            }
        }
    }
}
