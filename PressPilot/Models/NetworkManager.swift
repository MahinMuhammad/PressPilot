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

struct NewsFilter: Identifiable {
    var id: String
    var isSelected = false
}

struct Language: Identifiable{
    var id: String
    var language: String
}


class NetworkManager: ObservableObject{
    
    var requestSettings = RequestSettings()
    
    @Published var newsCollection = [News]()
    
    let pageSize = "100"
    
    let urlString = "https://newsapi.org/v2/top-headlines?language=en"
    
    func getURL()->String{
        let finaUrlString = "\(urlString)&pageSize=\(pageSize)&apiKey=\(Config.apiKey)"
        return finaUrlString
    }
    
    func fetchData(){
        if let url = URL(string: getURL()){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if let e = error{
                    print("Data fetch failed with error: \(e)")
                }else{
                    let decoder = JSONDecoder()
                    if let safeData = data{
                        do{
                            let results = try decoder.decode(Result.self, from: safeData)
                            DispatchQueue.main.async {
                                self.newsCollection = results.articles
                            }
                        }catch{
                            print(error)
                        }
                    }
                }
            }
            task.resume()
        }
    }
}
