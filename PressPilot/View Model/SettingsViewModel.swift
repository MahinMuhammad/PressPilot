//
//  SettingsViewModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 9/25/23.
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

final class SettingsViewModel:ObservableObject{
    @Published var shakeToReport = false
    @Published var isNotificationOn = false
    @Published var inAppSoundOn = false
    @Published var mirrorSystem = false
    var settings:SettingsModel?
    static let shared = SettingsViewModel()
    
    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Settings.plist")
    
    let version = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String
    let buildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String
    let appVersion:String
    
    private init(){
        if let version, let buildNumber{
            appVersion = "\(version).\(buildNumber)"
        }else{
            appVersion = "Not Found"
        }
    }
    
    func saveSettings(){
        settings = SettingsModel(shakeToReport: shakeToReport, isNotificationOn: isNotificationOn, inAppSoundOn: inAppSoundOn, mirrorSystem: mirrorSystem)
        
        let encoder = PropertyListEncoder()
        
        do{
            let data = try encoder.encode(settings)
            try data.write(to: dataFilePath!)
        }catch{
            print("Failed to save settings: \(error.localizedDescription)")
        }
    }
    
    func loadSettings(){
        if let data = try? Data(contentsOf: dataFilePath!){
            let decoder = PropertyListDecoder()
            do{
                settings = try decoder.decode(SettingsModel.self, from: data)
                guard let settings else{return}
                shakeToReport = settings.shakeToReport
                isNotificationOn = settings.isNotificationOn
                inAppSoundOn = settings.inAppSoundOn
                mirrorSystem = settings.mirrorSystem
            }catch{
                print("Failed to load settings: \(error.localizedDescription)")
            }
        }
    }
}
