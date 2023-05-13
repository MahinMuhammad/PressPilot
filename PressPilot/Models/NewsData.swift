//
//  NewsData.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/12/23.
//

import Foundation

struct Result:Decodable{
    let articles:[News]
}

struct News:Decodable, Identifiable{
    var id:String{
        return url
    }
    var imageUrl:URL?{
        if let safeUrlToImage = urlToImage{
            return URL(string: safeUrlToImage)
        }
        return nil
    }
    let title:String
    let url:String
    let urlToImage:String?
}
