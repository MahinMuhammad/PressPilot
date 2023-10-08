//
//  ChangePasswordViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import Foundation

final class ChangePasswordViewModel:ObservableObject{
    @Published var oldPassword:String = ""
    @Published var newPassword:String = ""
    @Published var confirmPassword:String = ""
    
    @Published var oldPasswordWarning:String?
    @Published var newPasswordWarning:String?
    @Published var confirmPasswordWarning:String?
    
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
        
    }
}
