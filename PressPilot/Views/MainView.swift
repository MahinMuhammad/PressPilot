//
//  MainView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI

struct MainView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Label("Home", systemImage: "house")
                }
                .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
            
            SavedView()
                .tabItem {
                    Label("Saved", systemImage: "bookmark")
//                        .environment(\.symbolVariants, .none)
                }
                .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
            
            MyProfileView()
                .tabItem {
                    Label("My Profile", systemImage: "person")
                }
                .toolbarBackground(Color.white, for: .navigationBar, .tabBar)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
