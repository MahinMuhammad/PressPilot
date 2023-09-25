//
//  SignUpViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 9/25/23.
//

import Foundation
import Firebase

final class SignUpViewModel:ObservableObject{
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var firstNameWarning:String?
    @Published var lastNameWarning:String?
    @Published var emailWarning:String?
    @Published var passwordWarning:String?
    let authManager = AuthManager.shared
    
    func signUpPressed(){
        authManager.signUpUser(firstName: firstName, lastName: lastName, email: email.lowercased(), password: password){ error in
            if let err = error{
                let nsError = err as NSError
                switch nsError.code{
                case AuthErrorCode.emailAlreadyInUse.rawValue:
                    self.emailWarning = "email is alreay in use"
                case AuthErrorCode.invalidEmail.rawValue:
                    self.emailWarning = "email is invalid"
                case AuthErrorCode.weakPassword.rawValue:
                    self.passwordWarning = "password is too weak"
                default:
                    print("Failed to sign up with error: \(err)")
                }
            }
        }
    }
    
    func isFormValid()->Bool{
        var flag = true
        firstNameWarning = ""
        lastNameWarning = ""
        emailWarning = ""
        passwordWarning = ""
        if firstName == ""{
            flag = false
            firstNameWarning = "Name required"
        }
        if lastName == ""{
            flag = false
            lastNameWarning = "Last name required"
        }
        if email == ""{
            flag = false
            emailWarning = "Email required"
        }
        if password == ""{
            flag = false
            passwordWarning = "Password required"
        }
        return flag
    }
}
