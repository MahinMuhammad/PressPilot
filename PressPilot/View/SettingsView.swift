//
//  AppSettingsView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/31/23.
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

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.dismiss) var dismiss
    @AppStorage("appTheme") var isDarkModeOn = false
    @StateObject var viewModel = SettingsViewModel()
    
    var body: some View {
        ZStack{
            Color(K.CustomColors.bluishWhiteToBlack)
                .edgesIgnoringSafeArea(.all)
            
            ScrollView {
                VStack{
                    Text("Settings")
                        .fontWeight(.bold)
                        .font(.system(size: 24))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.leading, 30)
                        .padding(.top, 30)
                    
                    Rectangle()
                        .frame(height: 1)
                        .padding(.leading, 30)
                        .padding(.trailing, 30)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 110)
                        .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                        .overlay{
                            VStack{
                                Toggle(isOn: $isDarkModeOn) {
                                    HStack{
                                        Image(systemName: "moon")
                                            .imageScale(.large)
                                        Text("Dark Mode")
                                            .font(.system(size: 20))
                                    }
                                }
                                
                                Divider()
                                
                                Toggle(isOn: $viewModel.isNotificationOn) {
                                    HStack{
                                        Image(systemName: "bell.badge")
                                            .imageScale(.large)
                                        Text("Notification")
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
//                        .padding(.top,50)
                    
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 110)
                        .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                        .overlay{
                            VStack{
                                Toggle(isOn: $viewModel.shakeToReport) {
                                    HStack{
                                        Image(systemName: "iphone.gen3.radiowaves.left.and.right.circle")
                                            .imageScale(.large)
                                        Text("Shake to report")
                                            .font(.system(size: 20))
                                    }
                                }
                                
                                Divider()
                                
                                Toggle(isOn: $viewModel.inAppSoundOn) {
                                    HStack{
                                        Image(systemName: "waveform")
                                            .imageScale(.large)
                                        Text("In-app sound")
                                            .font(.system(size: 20))
                                    }
                                }
                            }
                            .padding()
                        }
                        .padding()
                    
                    if verticalSizeClass == .compact{
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 80)
                            .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                            .padding()
                            .overlay{
                                Button{
                                    dismiss()
                                }label: {
                                    Text("Go Back")
                                        .fontWeight(.medium)
                                        .font(.system(size: 22))
                                        .tint(Color(UIColor.label))
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 55)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(UIColor.label), lineWidth: 1)
                                        }
                                        .padding(25)
                                }
                            }
                    }
                    
                    Spacer()
                }
            }
            .scrollDisabled(verticalSizeClass != .compact)
        }
        .colorScheme(isDarkModeOn ? .dark : .light)
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
