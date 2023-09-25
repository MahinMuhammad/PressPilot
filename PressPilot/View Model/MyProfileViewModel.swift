//
//  MyProfileViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 9/25/23.
//

import Foundation
import SwiftUI

final class MyProfileViewModel:ObservableObject{
    @Published var showRemoveAllNewsAlert = false
    @Published var logoutSuccess = false
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var email = ""
    @Published var userDataService = UserDataManager.shared
    
    func removeSavedNews(){
        userDataService.deleteAllSaveNews()
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    }
}
