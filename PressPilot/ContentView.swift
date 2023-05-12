//
//  ContentView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/9/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            List{
                
            }
            .listStyle(.plain)
            
            .toolbar {
                ToolbarItemGroup(placement: .bottomBar) {
                    VStack{
                        Image(systemName: "house")
                        Text("Home")
                    }
                    .padding(.leading)
                    
                    Spacer()
                    
                    VStack{
                        Image(systemName: "heart")
                        Text("Supporting")
                    }
                    
                    Spacer()
                    
                    VStack{
                        Image(systemName: "bookmark")
                        Text("Saved")
                    }
                    
                    Spacer()
                    
                    VStack{
                        Image(systemName: "person")
                        Text("My Profile")
                    }
                    .padding(.trailing)
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
