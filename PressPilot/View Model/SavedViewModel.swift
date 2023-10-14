//
//  SavedViewModel.swift
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

final class SavedViewModel:ObservableObject{
    let authService = AuthManager.shared
    let dataManager = DataManager.shared
    @Published var loadingFinished = false
    @Published var showRemoveAllNewsAlert = false
    @Published var showSearchBox = false
    @Published var searchedKeyWord = ""
    @Published var savedNewsCollection = [NewsModel]()
    
    func deleteButtonPressed(delete news:NewsModel){
        savedNewsCollection = savedNewsCollection.filter{$0.url != news.url}
        dataManager.deleteSaveNews(url: news.url)
        let impactMed = UIImpactFeedbackGenerator(style: .medium)
        impactMed.impactOccurred()
    }
    
    func fetchSavedNews(){
        savedNewsCollection = []
        loadingFinished = false
        dataManager.fetchSavedNews(){ newsCollection in
            self.savedNewsCollection = newsCollection
            self.loadingFinished = true
        }
    }
    
    func newsLoaded()->Bool{
        return savedNewsCollection.count != 0 || loadingFinished
    }
    
    func isNewsEmpty()->Bool{
        return savedNewsCollection.count == 0 && loadingFinished
    }
    
    func removeAllSavedNews(){
        savedNewsCollection = []
        dataManager.deleteAllSaveNews()
        let impactMed = UIImpactFeedbackGenerator(style: .heavy)
        impactMed.impactOccurred()
    }
    
    func containsDomainKeyword(part:String)->Bool{
        return part.contains("com") || part.contains("org") || part.contains("net") || part.contains("gov") || part.contains("mil") || part.contains("edu") || part.contains("int")
    }
    
    func getSecondLevelDomain(from url:String?)->String{
        guard let url else{return ""}
        let parsedUrl = url.components(separatedBy: ".")
        
        if parsedUrl.count < 2 || containsDomainKeyword(part: parsedUrl[1]){
            return parsedUrl[0].replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "http://", with: "").uppercased()
        }else{
            return parsedUrl[1].uppercased()
        }
    }
    
    func isSearchBoxEmpty()->Bool{
        return searchedKeyWord == ""
    }
}
