//
//  NewsViewModel.swift
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
import FirebaseAuth

final class NewsViewModel:ObservableObject{
    let authService = AuthManager.shared
    let dataService = UserDataManager.shared
    @Published var showSearchBox = false
    @Published var showAppSettings = false
    @Published var showingAlertToSignIn = false
    
    func saveButtonPressed(save news:NewsModel){
        if authService.isSignedIn{
            if dataService.isSaved(newsURl: news.url){
                dataService.deleteSaveNews(url: news.url)
                
            }else{
                dataService.saveNews(email: dataService.userData?.email, title: news.title, url: news.url, urlToImage: news.urlToImage)
            }
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }else{
            showingAlertToSignIn = true
        }
    }
}
