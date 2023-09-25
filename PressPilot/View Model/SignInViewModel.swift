//
//  SignInViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 9/25/23.
//

import Foundation
import Firebase

final class SignInViewModel:ObservableObject{
    @Published var email:String = ""
    @Published var password:String = ""
    @Published var isRememberOn:Bool = false
    @Published var emailWarning:String?
    @Published var passwordWarning:String?
    let authManager = AuthManager.shared
    let defaults = UserDefaults.standard
    
    func signInPressed(){
        authManager.signInUser(email: email.lowercased(), password: password){error in
            if let err = error{
                let nsError = err as NSError
                switch nsError.code{
                case AuthErrorCode.userNotFound.rawValue:
                    self.emailWarning = "user not found"
                case AuthErrorCode.invalidEmail.rawValue:
                    self.emailWarning = "email is invalid"
                case AuthErrorCode.wrongPassword.rawValue:
                    self.passwordWarning = "wrong password"
                default:
                    print("Failed to sign up with error: \(err)")
                }
            }else{
                let loginInfo = [K.loginEmailKey : self.email, K.loginPassKey : self.password]
                if self.isRememberOn{
                    self.defaults.set(loginInfo, forKey: K.loginDetailsKey)
                    print("login info saved")
                }else{
                    self.defaults.set(nil, forKey: K.loginDetailsKey)
                    print("login info not saved")
                }
            }
        }
    }
    
    func fetchSignInDetails(){
        if let safeDictionary = defaults.dictionary(forKey: K.loginDetailsKey){
            if let safeEmail = safeDictionary[K.loginEmailKey]{
                email = safeEmail as! String
            }
            if let safePassword = safeDictionary[K.loginPassKey]{
                password = safePassword as! String
            }
            isRememberOn = true
        }
    }

    func isFormValid()->Bool{
        var flag:Bool = true
        emailWarning = ""
        passwordWarning = ""
        if email == ""{
            flag = false
            emailWarning = "Email Required"
        }
        if password == ""{
            flag = false
            passwordWarning = "Password Required"
        }
        return flag
    }
}
