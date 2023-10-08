//
//  EditInfoViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import Foundation

final class EditInfoViewModel:ObservableObject{
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var firstNameWarning:String?
    @Published var lastNameWarning:String?
    var user:UserModel?
    var userDataService = UserDataManager.shared
    
    func fetchUserData(){
        userDataService.readUserData(){ user in
            self.user = user
            if let user = self.user{
                self.firstName = user.firstName
                self.lastName = user.lastname
            }
        }
    }
    
    func userLoaded()->Bool{
        return user != nil
    }
    
    func isFormValid()->Bool{
        firstNameWarning = ""
        lastNameWarning = ""
        
        if firstName == ""{
            firstNameWarning = "Empty field"
            return false
        }
        
        if lastName == ""{
            lastNameWarning = "Empty field"
            return false
        }
        
        return true
    }
    
    func savePressed(){
        
    }
}
