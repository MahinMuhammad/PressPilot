//
//  RequestSettings.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/28/23.
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

struct NewsCategory: Identifiable {
    var id: String
    var isSelected = false
}

struct Language: Identifiable{
    var id: String
    var language: String
}

class RequestSettings: ObservableObject{
    
    let pageSize = "5"
    
    //MARK: - Language or Country
    
    @Published var selectedBetweenLanguageOrCountry = "language"
    let choicesBetweenLanguageOrCountry = [K.languageInString, K.countryInString]
    
    //MARK: - Language Settings
    @Published var selectedLanguage = "en"
    
    let languages = [
        Language(id: "en", language: "English"),
        Language(id: "ru", language: "Russian"),
        Language(id: "es", language: "Espanish"),
        Language(id: "fr", language: "French"),
        Language(id: "it", language: "Italian")
    ]
    
    //MARK: - Day Settings
    @Published var selectedOption = "News of Today"
    let options = ["News of Today", "Last seven days", "Last thirty days", "Last one year"]
    
    //MARK: - Catagory Settings
    func selectedCategory()->String{
        for newsCategory in newsCategoryCollection{
            if newsCategory.isSelected && newsCategory.id != "All"{
                return newsCategory.id.lowercased()
            }
        }
        return "general"
    }
    @Published var newsCategoryCollection:[NewsCategory] = [
        NewsCategory(id: "All", isSelected: true),
        NewsCategory(id: "Business"),
        NewsCategory(id: "Science"),
        NewsCategory(id: "Entertainment"),
        NewsCategory(id: "Health"),
        NewsCategory(id: "Sports"),
        NewsCategory(id: "Technology")
    ]
    
    func unselectOtherFilter(id:String){
        for i in 0..<newsCategoryCollection.count{
            if newsCategoryCollection[i].id != id{
                newsCategoryCollection[i].isSelected = false
            }
        }
    }
    //    private func numberOfSelectedToggles() -> Int {
    //        return newsFilterCollection.filter({ NewsFilter.isSelected }).count
    //        }
    
    //MARK: - Copy paste this to the place you want this settings to show
    //                        Picker(selection: $selectedLanguage, label: EmptyView()) {
    //                            ForEach(languages) { language in
    //                                Text(language.language).tag(language.id)
    //                            }
    //                        }
    //                        .foregroundColor(Color(UIColor.label))
    //                        .pickerStyle(.navigationLink)
}

