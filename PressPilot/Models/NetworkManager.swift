//
//  NetworkManager.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/12/23.
//

import Foundation

class NetworkManager: ObservableObject{
    
    @Published var newsCollection = [News]()
    
    let urlString = "https://newsapi.org/v2/top-headlines?country=us"
    
    func getURL()->String{
        let finaUrlString = "\(urlString)&apiKey=\(Config.apiKey)"
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
