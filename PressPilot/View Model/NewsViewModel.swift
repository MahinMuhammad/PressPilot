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
    let dataManager = DataManager.shared
    let networkManager = NetworkManager()
    
    @Published var showSearchBox = false
    @Published var showAppSettings = false
    @Published var showingAlertToSignIn = false
    
    @Published var newsCollection = [NewsModel]()
    @Published var savedNewsCollection = [NewsModel]()
    
    @Published var loadingFinished = false
    var emptyListMessage = ""
    
    func saveButtonPressed(save news:NewsModel){
        if authService.isSignedIn{
            if isSaved(newsURl: news.url){
                savedNewsCollection = savedNewsCollection.filter{$0.url != news.url}
                dataManager.deleteSaveNews(url: news.url)
            }else{
                savedNewsCollection.append(news)
                dataManager.saveNews(email: Auth.auth().currentUser?.email, title: news.title, url: news.url, urlToImage: news.urlToImage)
            }
            let impactMed = UIImpactFeedbackGenerator(style: .medium)
            impactMed.impactOccurred()
        }else{
            showingAlertToSignIn = true
        }
    }
    
    func loadNews(){
        newsCollection = []
        loadingFinished = false
        emptyListMessage = ""
        networkManager.fetchData { result, error in
            if let error{
                    self.loadingFinished = true
                    let nsError = error as NSError
                    switch nsError.code{
                    case URLError.notConnectedToInternet.rawValue:
                        self.emptyListMessage = "Not connected to the internet"
                    default:
                        print("Data fetch failed with error: \(error)")
                    }
            }else{
                self.newsCollection = result
                self.loadingFinished = true
                if self.newsCollection.count == 0{
                    self.emptyListMessage = "No news found"
                }
            }
        }
    }
    
    func newsLoaded()->Bool{
        return newsCollection.count != 0 || loadingFinished
    }
    
    func zeroNewsLoaded()->Bool{
        return newsCollection.count == 0 && loadingFinished
    }
    
    func fetchSavedNews(){
        savedNewsCollection = []
        dataManager.fetchSavedNews(){ newsCollection in
            self.savedNewsCollection = newsCollection
        }
    }
    
    func isSaved(newsURl:String)->Bool{
        for news in savedNewsCollection{
            if news.url == newsURl{
                return true
            }
        }
        return false
    }
}
