//
//  NetworkManager.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/12/23.
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

class NetworkManager: ObservableObject{
    
    let rs = RequestManager.shared
    
//    @Published var newsCollection = [NewsModel]()
//    @Published var loadingFinished = false
//    var emptyListMessage = ""

    let apiKey = Config.newsapiKey //get an api key from newsapi.org and assign it instead of Config.newsapiKey
    
    let urlString = "https://newsapi.org/v2/top-headlines?"
    
    func getURL()->String{
        var finaUrlString = "\(urlString)&pageSize=\(rs.pageSize)&apiKey=\(apiKey)"
        if rs.selectedLangOrCntry == K.countryInString{
            if rs.isKewordSearchOn{
                finaUrlString = "\(urlString)country=\(rs.selectedCountry)&pageSize=\(rs.pageSize)&q=\(rs.selectedKeyword)&apiKey=\(apiKey)"
            }else{
                finaUrlString = "\(urlString)country=\(rs.selectedCountry)&pageSize=\(rs.pageSize)&category=\(rs.selectedCategory())&apiKey=\(apiKey)"
            }
        }else{
            if rs.isKewordSearchOn{
                finaUrlString = "\(urlString)language=\(rs.selectedLanguage)&pageSize=\(rs.pageSize)&q=\(rs.selectedKeyword)&apiKey=\(apiKey)"
            }else{
                finaUrlString = "\(urlString)language=\(rs.selectedLanguage)&pageSize=\(rs.pageSize)&category=\(rs.selectedCategory())&apiKey=\(apiKey)"
            }
        }
        return finaUrlString
    }
    
    func fetchData(completion: @escaping ([NewsModel],Error?) -> Void){
//        loadingFinished = false
//        emptyListMessage = ""
        var newsCollection = [NewsModel]() //just to make newsCollection empty and show loading view each time fetchData called
        if let url = URL(string: getURL()){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let error{
                    completion([],error)
                }else{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let results = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                newsCollection = results.articles
                                completion(newsCollection,nil)
                                print("Data fetch successful with \(newsCollection.count) articles")
                            }
                        }catch{
                            DispatchQueue.main.async {
                                completion([],error)
                            }
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
