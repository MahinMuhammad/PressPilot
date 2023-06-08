//
//  ContentView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/9/23.
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

struct NewsView: View {
    @State private var showSearchBox = false
    @EnvironmentObject var networkManager: NetworkManager
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var dataService: DataService
    
    @State var showAppSettings = false
    @State private var showingAlertToSignIn = false
    
    @State var showSavedState = false
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            if showSearchBox{
                                Button{
                                    withAnimation(.spring()) {
                                        showSearchBox = false
                                    }
                                    networkManager.rs.selectedKeyword = ""
                                    networkManager.rs.isKewordSearchOn = false
                                    networkManager.fetchData()
                                }label: {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color(UIColor.label))
                                        .imageScale(.large)
                                }
                                .transition(.push(from: .trailing))
                                
                                
                                TextField("Search", text: $networkManager.rs.selectedKeyword)
                                    .frame(width: 300)
                                    .textFieldStyle(.roundedBorder)
                                    .transition(.push(from: .trailing))
                                
                                Button{
                                    networkManager.fetchData()
                                }label: {
                                    Image(systemName: "checkmark")
                                        .fontWeight(.medium)
                                        .foregroundColor(Color(UIColor.label))
                                }
                                .transition(.push(from: .trailing))
                            }
                            if !showSearchBox{
                                Picker(selection: $networkManager.rs.selectedLangOrCntry, label: OptionsPickerLabelView()) {
                                    ForEach(networkManager.rs.choicesLangOrCntry, id: \.self) {
                                        Text("Search by \($0)").tag($0)
                                    }
                                }
                                .frame(width: 35,height: 35)
                                .pickerStyle(.navigationLink)
                                .animation(.easeInOut(duration: 5), value: 0)
                                .transition(.push(from: .leading))
                                .onChange(of: networkManager.rs.selectedLangOrCntry) {value in
                                    self.networkManager.fetchData()
                                }
                                ForEach($networkManager.rs.newsCategoryCollection){ $category in
                                    Toggle(category.id, isOn: $category.isSelected)
                                        .toggleStyle(.button)
                                        .cornerRadius(16.5)
                                        .foregroundColor(Color(UIColor.label))
                                        .animation(.easeInOut(duration: 5), value: 0)
                                        .transition(.push(from: .leading))
                                        .onChange(of: category.isSelected) {value in
                                            if value{
                                                networkManager.rs.unselectOtherFilter(id: category.id)
                                                self.networkManager.fetchData()
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.top, 24)
                    }
                    List(networkManager.newsCollection){news in
                        HStack(alignment:.top){
                            AsyncImage(url: news.imageUrl) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            } placeholder: {
                                Image(systemName: "photo")
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 128, height: 128)
                                    .clipped()
                                    .clipShape(RoundedRectangle(cornerRadius: 16))
                            }
                            
                            VStack(alignment: .trailing) {
                                ZStack {
                                    NavigationLink(destination: DetailView(url: news.url)){
                                        EmptyView()
                                    }
                                    .opacity(0.0)
                                    .buttonStyle(PlainButtonStyle())
                                    
                                    Text(news.title)
                                        .bold()
                                        .padding(.leading, 10)
                                        .lineLimit(3)
                                }
                                
                                Button {
                                    if authService.signedIn{
                                        if dataService.isSaved(newsURl: news.url){
                                            dataService.deleteSaveNews(url: news.url)
                                            
                                        }else{
                                            dataService.saveNews(email: dataService.userData?.email, title: news.title, url: news.url, urlToImage: news.urlToImage)
                                        }
                                        let impactMed = UIImpactFeedbackGenerator(style: .medium)
                                        impactMed.impactOccurred()
                                    }else{
                                        showingAlertToSignIn = true
                                    }
                                } label: {
                                    Image(systemName: dataService.isSaved(newsURl: news.url) == true ? "bookmark.fill" : "bookmark")
                                }
                                .alert("SignIn to Save News", isPresented: $showingAlertToSignIn) {
                                            Button("OK", role: .cancel) { }
                                        }
                                .buttonStyle(.borderless)
                                .padding()
                            }
                            
                        }
                        .listRowSeparator(.hidden)
                    }
                    .toolbar(content: {
                        ToolbarItemGroup(placement: .navigation) {
                            Image(systemName: "photo")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 32)
                            Text("PressPilot")
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                        }
                        ToolbarItemGroup {
                            Button{
                                showAppSettings = true
                            }label: {
                                Image(systemName: "gearshape")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                            .sheet(isPresented: $showAppSettings, content: AppSettingsView.init)
                            
                            Button{
                                
                            }label: {
                                Image(systemName: "bell")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                            Button{
                                withAnimation(.spring()) {
                                    showSearchBox = true
                                }
                                networkManager.rs.isKewordSearchOn = true
                            }label: {
                                Image(systemName: "magnifyingglass")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                        }
                    })
                    .padding(.top, 24)
                    .listStyle(.plain)
                    .refreshable {
                        self.networkManager.fetchData()
                    }
                }
                
                if networkManager.newsCollection.count == 0{
                    LoadingView(isAnimating: .constant(true), style: .large)
                }
            }
        }
        .padding(.top,16)
        .onAppear{
            self.networkManager.fetchData()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
            .environmentObject(NetworkManager())
            .environmentObject(AuthService())
    }
}

struct OptionsPickerLabelView: View {
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .foregroundColor(Color(UIColor.label))
            .imageScale(.large)
    }
}
