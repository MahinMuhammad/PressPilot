//
//  DetailViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/11/23.
//

import Foundation

final class DetailViewModel:ObservableObject{
    func getSecondLevelDomain(from url:String?)->String?{
        let parsedUrl = url?.components(separatedBy: ".")
        return parsedUrl?[1] != "com" ? parsedUrl?[1].uppercased() : "EMPTY"
    }
}
