//
//  SettingsModel.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/16/23.
//

import Foundation

struct SettingsModel:Codable{
    let shakeToReport:Bool
    let isNotificationOn :Bool
    let inAppSoundOn :Bool
    let mirrorSystem :Bool
}
