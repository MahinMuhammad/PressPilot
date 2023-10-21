//
//  DetailViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/11/23.
//

import Foundation

final class DetailViewModel:ObservableObject{
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
}
