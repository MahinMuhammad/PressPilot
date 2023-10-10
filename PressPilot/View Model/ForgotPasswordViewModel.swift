//
//  ForgotPasswordViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/10/23.
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

final class ForgotPasswordViewModel:ObservableObject{
    @Published var email:String = ""
    @Published var emailWarning:String?
    @Published var showCompletionAlert = false
    
    func isFormValid()->Bool{
        emailWarning = ""
        
        if email == ""{
            emailWarning = "Email not given"
            return false
        }
        return true
    }
    
    func sendPressed(){
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error{
                let nsError = error as NSError
                switch nsError.code{
                case AuthErrorCode.userNotFound.rawValue:
                    self.emailWarning = "user not found"
                case AuthErrorCode.invalidEmail.rawValue:
                    self.emailWarning = "email is invalid"
                default:
                    print("Failed to sign in with error: \(error)")
                }
            }else{
                self.showCompletionAlert = true
            }
        }
    }
}
