//
//  AppSettingsView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/31/23.
//

import SwiftUI

struct AppSettingsView: View {
    @EnvironmentObject var networkManager: NetworkManager
    
    @AppStorage("appTheme") private var isDarkModeOn = false
    
    @State var isNotificationOn = false
    
    var body: some View {
        ZStack{
            Color(K.CustomColors.bluishWhiteToBlack)
                .edgesIgnoringSafeArea(.all)
            VStack{
                RoundedRectangle(cornerRadius: 25)
                    .frame(height: 110)
                    .foregroundColor(Color(UIColor.systemBackground))
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
                Spacer()
            }
        }
        .colorScheme(isDarkModeOn ? .dark : .light)
    }
}

struct AppSettingsView_Previews: PreviewProvider {
    static var previews: some View {
        AppSettingsView()
    }
}
