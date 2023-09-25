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
    @StateObject var viewModel = NewsViewModel()
    @StateObject var networkManager = NetworkManager()
    @StateObject var dataService = UserDataManager.shared //using this to show the realtime change of bookmark icon
    @StateObject var rs = RequestManager.shared
    
    var body: some View {
        NavigationStack{
            ZStack{
                //this solution focuses and unfocuses on a textfield to reload the view and reset the offset
                TapTargetResetLayer()
                VStack {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack{
                            if viewModel.showSearchBox{
                                Button{
                                    withAnimation(.spring()) {
                                        viewModel.showSearchBox = false
                                    }
                                    rs.selectedKeyword = ""
                                    rs.isKewordSearchOn = false
                                    networkManager.fetchData()
                                }label: {
                                    Image(systemName: "chevron.backward")
                                        .foregroundColor(Color(UIColor.label))
                                        .imageScale(.large)
                                }
                                .transition(.push(from: .trailing))
                                
                                
                                TextField("Search", text: $rs.selectedKeyword)
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
                            if !viewModel.showSearchBox{
                                Picker(selection: $rs.selectedLangOrCntry, label: OptionsPickerLabelView()) {
                                    ForEach(rs.choicesLangOrCntry, id: \.self) {
                                        Text("Search by \($0)").tag($0)
                                    }
                                }
                                .frame(width: 35,height: 35)
                                .pickerStyle(.navigationLink)
                                .animation(.easeInOut(duration: 5), value: 0)
                                .transition(.push(from: .leading))
                                .onChange(of: rs.selectedLangOrCntry) {value in
                                    self.networkManager.fetchData()
                                }
                                ForEach($rs.newsCategoryCollection){ $category in
                                    Toggle(category.id, isOn: $category.isSelected)
                                        .toggleStyle(.button)
                                        .cornerRadius(20)
                                        .foregroundColor(Color(UIColor.label))
                                        .animation(.easeInOut(duration: 5), value: 0)
                                        .transition(.push(from: .leading))
                                        .onChange(of: category.isSelected) {value in
                                            if value{
                                                rs.unselectOtherFilter(id: category.id)
                                                networkManager.fetchData()
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
                                    viewModel.saveButtonPressed(save: news)
                                } label: {
                                    Image(systemName: dataService.isSaved(newsURl: news.url) == true ? "bookmark.fill" : "bookmark")
                                }
                                .alert("SignIn to Save News", isPresented: $viewModel.showingAlertToSignIn) {
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
                                viewModel.showAppSettings = true
                            }label: {
                                Image(systemName: "gearshape")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                            
                            Button{
                                
                            }label: {
                                Image(systemName: "bell")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                            Button{
                                withAnimation(.spring()) {
                                    viewModel.showSearchBox = true
                                }
                                rs.isKewordSearchOn = true
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
        .onChange(of: viewModel.showAppSettings, perform: viewModel.showingSheetChanged) //reset the offset
        .sheet(isPresented: $viewModel.showAppSettings, content: AppSettingsView.init)
    }
}

struct OptionsPickerLabelView: View {
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .foregroundColor(Color(UIColor.label))
            .imageScale(.large)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NewsView()
    }
}
