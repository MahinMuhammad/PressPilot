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

final class RequestManager: ObservableObject{
    static let shared = RequestManager()
    
    private init(){}
    
    //MARK: - Page Sizes of News List
    @Published var pageSize = "20"
    let oferedPageSizes = ["20", "25", "30"]
    
    //MARK: - KeyWord search
    @Published var isKewordSearchOn = false
    @Published var selectedKeyword = ""
    
    //MARK: - Language or Country
    @Published var selectedLangOrCntry = K.languageInString
    let choicesLangOrCntry = [K.languageInString, K.countryInString]
    
    //MARK: - Country Settings
    @Published var selectedCountry = "us"
    
    let countries = [
        CountryModel(id: "us", country: "USA"),
        CountryModel(id: "ru", country: "Russia"),
        CountryModel(id: "gb", country: "UK"),
        CountryModel(id: "fr", country: "France"),
        CountryModel(id: "it", country: "Italy")
    ]
    
    //MARK: - Language Settings
    @Published var selectedLanguage = "en"
    
    let languages = [
        LanguageModel(id: "en", language: "English"),
        LanguageModel(id: "ru", language: "Russian"),
        LanguageModel(id: "es", language: "Espanish"),
        LanguageModel(id: "fr", language: "French"),
        LanguageModel(id: "it", language: "Italian")
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
    @Published var newsCategoryCollection:[NewsCategoryModel] = [
        NewsCategoryModel(id: "All", isSelected: true),
        NewsCategoryModel(id: "Business"),
        NewsCategoryModel(id: "Science"),
        NewsCategoryModel(id: "Entertainment"),
        NewsCategoryModel(id: "Health"),
        NewsCategoryModel(id: "Sports"),
        NewsCategoryModel(id: "Technology")
    ]
    
    func unselectOtherCategory(id:String){
        for i in 0..<newsCategoryCollection.count{
            if newsCategoryCollection[i].id != id{
                newsCategoryCollection[i].isSelected = false
            }
        }
    }
    
    func unselectAllOtherCategory(){
        for i in 0..<newsCategoryCollection.count{
            newsCategoryCollection[i].isSelected = false
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

