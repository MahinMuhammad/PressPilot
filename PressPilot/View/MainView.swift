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
    @StateObject var authService = AuthManager.shared
    @StateObject var viewModel = MainViewModel()
    
    @StateObject var newsViewModel = NewsViewModel()
    @StateObject var savedViewModel = SavedViewModel()
    var downloadViewModel = DownloadedNewsViewModel()
    var profileViewModel = MyProfileViewModel()
    var networkManager = NetworkManager()
    
    //to solve Tabbar remains fully transparent after content scrolls below
    init(){
        UITabBar.appearance().scrollEdgeAppearance = UITabBarAppearance.init(idiom: .unspecified)
    }
    
    var body: some View {
        TabView{
            NewsView(viewModel: newsViewModel, networkManager: networkManager)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            SavedView(viewModel: savedViewModel)
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
                }
            
            DownloadedNewsView(viewModel: downloadViewModel)
                .tabItem {
                    Label("Downloads", systemImage: "platter.filled.bottom.and.arrow.down.iphone")
                }
            
            MyProfileView(viewModel: profileViewModel)
                .tabItem {
                    Label("My Profile", systemImage: "person")
                }
        }
        .onAppear{
            networkManager.fetchData()
            if authService.isSignedIn{
                profileViewModel.fetchUserData()
                savedViewModel.fetchSavedNews()
                newsViewModel.fetchSavedNews()
            }
        }
        .onChange(of: authService.isSignedIn) { isSignedIn in
            savedViewModel.fetchSavedNews()
            newsViewModel.fetchSavedNews()
            if isSignedIn{
                profileViewModel.fetchUserData()
            }
        }
        .onChange(of: newsViewModel.savedNewsCollection.count){ value in
            savedViewModel.savedNewsCollection = newsViewModel.savedNewsCollection
        }
        .onChange(of: savedViewModel.savedNewsCollection.count){ value in
            newsViewModel.savedNewsCollection = savedViewModel.savedNewsCollection
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
