//
//  DetailViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/11/23.
//

import Foundation

final class DetailViewModel:ObservableObject{
    func getSecondLevelDomain(from url:String?)->String{
        guard let url else{return ""}
        let parsedUrl = url.components(separatedBy: ".")
        
        if parsedUrl.count < 2 || parsedUrl[1].contains("com"){
            return parsedUrl[0].replacingOccurrences(of: "https://", with: "").replacingOccurrences(of: "http://", with: "").uppercased()
        }else{
            return parsedUrl[1].uppercased()
        }
    }
}
