//
//  AppSettingsView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/31/23.
//

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var networkManager: NetworkManager
    @Environment(\.dismiss) var dismiss
    
    @State private var orientation = UIDevice.current.orientation
    
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    @State var shakeToReport = false
    @State var isNotificationOn = false
    @State var inAppSoundOn = false
    
    var body: some View {
        ZStack{
            Color(K.CustomColors.bluishWhiteToBlack)
                .edgesIgnoringSafeArea(.all)
            VStack{
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
                            
                            Toggle(isOn: $isNotificationOn) {
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
                    .padding(.top,50)
                
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 110)
                    .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                    .overlay{
                        VStack{
                            Toggle(isOn: $shakeToReport) {
                                HStack{
                                    Image(systemName: "iphone.gen3.radiowaves.left.and.right.circle")
                                        .imageScale(.large)
                                    Text("Shake to report")
                                        .font(.system(size: 20))
                                }
                            }
                            
                            Divider()
                            
                            Toggle(isOn: $inAppSoundOn) {
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
                
                if orientation.isLandscape{
                    RoundedRectangle(cornerRadius: 25)
                        .frame(height: 80)
                        .foregroundColor(Color(UIColor.systemBackground))
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
        .colorScheme(isDarkModeOn ? .dark : .light)
        .onChange(of: orientation){ newOrientation in
            orientation = newOrientation
        }
        .onRotate { newOrientation in
            orientation = newOrientation
        }
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
