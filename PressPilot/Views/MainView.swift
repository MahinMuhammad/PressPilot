//
//  MainView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
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

struct MainView: View {
    
    var body: some View {
        TabView{
            NewsView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar, .tabBar)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
                .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar, .tabBar)
            
            DownloadsView()
                .tabItem {
                    Label("Downloads", systemImage: "platter.filled.bottom.and.arrow.down.iphone")
                }
                .toolbarBackground(Color(UIColor.systemBackground), for: .navigationBar, .tabBar)
            
            MyProfileView()
                .tabItem {
                    Label("My Profile", systemImage: "person")
                }
                .toolbarBackground(Color("MyProfileBGColor"), for: .navigationBar, .tabBar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AuthService())
            .environmentObject(NetworkManager())
            .environmentObject(DataService())
    }
}
