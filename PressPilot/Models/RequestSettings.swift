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

class RequestSettings: ObservableObject{
    
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
    @Published var newsFilterCollection:[NewsFilter] = [
        NewsFilter(id: "All", isSelected: true),
        NewsFilter(id: "Business"),
        NewsFilter(id: "Science"),
        NewsFilter(id: "Entertainment"),
        NewsFilter(id: "Health"),
        NewsFilter(id: "Sports"),
        NewsFilter(id: "Technology")
    ]
    
    func unselectOtherFilter(id:String){
        for i in 0..<newsFilterCollection.count{
            if newsFilterCollection[i].id != id{
                newsFilterCollection[i].isSelected = false
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

