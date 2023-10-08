//
//  EditInfoViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import Foundation

final class EditInfoViewModel:ObservableObject{
    @Published var firstName:String?
    @Published var lastName:String?
    @Published var firstNameWarning:String?
    @Published var lastNameWarning:String?
    @Published var userDataService = UserDataManager.shared
    
    init() {
        self.firstName = userDataService.userData?.firstName
        self.lastName = userDataService.userData?.lastname
        self.firstNameWarning = firstNameWarning
        self.lastNameWarning = lastNameWarning
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
