//
//  EditInfoViewModel.swift
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

final class EditInfoViewModel:ObservableObject{
    @Published var firstName:String = ""
    @Published var lastName:String = ""
    @Published var firstNameWarning:String?
    @Published var lastNameWarning:String?
    @Published var showCompletionAlert = false
    var profileViewModel:MyProfileViewModel
    var dataManager = DataManager.shared
    
    init(profileViewModel: MyProfileViewModel) {
        self.profileViewModel = profileViewModel
    }
    
    func fetchUserData(){
        if let user = profileViewModel.user{
            self.firstName = user.firstName
            self.lastName = user.lastname
        }
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
        dataManager.updateUserInfo(firstName: firstName, lastName: lastName)
        DispatchQueue.main.async {
            self.showCompletionAlert = true
            self.profileViewModel.user?.firstName = self.firstName
            self.profileViewModel.user?.lastname = self.lastName
        }
    }
}
