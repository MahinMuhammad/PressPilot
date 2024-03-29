//
//  MyProfileViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 9/25/23.
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
import SwiftUI

final class MyProfileViewModel:ObservableObject{
    @Published var logoutSuccess = false
    @Published var user:UserModel?
    @Published var loadingFinished = false
    @Published var dataManager = DataManager.shared
    @Published var authManager = AuthManager.shared
    
    func fetchUserData(){
        user = nil
        loadingFinished = false
        dataManager.readUserData(){ user in
            self.user = user
            self.loadingFinished = true
        }
    }
    
    func userLoaded()->Bool{
        return user != nil || loadingFinished
    }
    
    func failedToFetchUserData()->Bool{
        return user == nil || loadingFinished
    }
    
    func signOut()->Bool{
        return authManager.signOut()
    }
}
