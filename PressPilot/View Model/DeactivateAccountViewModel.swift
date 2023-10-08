//
//  DeactivateAccountViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import Foundation

final class DeactivateAccountViewModel:ObservableObject{
    @Published var password:String = ""
    @Published var passwordWarning:String?
    
    func isFormValid()->Bool{
        passwordWarning = ""
        
        if password == ""{
            passwordWarning = "Password Required"
            return false
        }
        return true
    }
    
    func confirmPressed(){
        
    }
}

