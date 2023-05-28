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
    @ObservedObject var requestSettings = RequestSettings()
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        NavigationStack{
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack{
                        Picker(selection: $requestSettings.selectedOption, label: PickerLabelView()) {
                            ForEach(requestSettings.options, id: \.self) {
                                Text($0)
                            }
                        }
                        .frame(width: 35,height: 35)
                        .pickerStyle(.navigationLink)
                        
                        ForEach($requestSettings.newsFilterCollection){ $filter in
                            Toggle(filter.id, isOn: $filter.isSelected)
                                .toggleStyle(.button)
                                .cornerRadius(16.5)
                                .foregroundColor(Color(UIColor.label))
                                .onChange(of: filter.isSelected) {value in
                                    if value{
                                        filter.isSelected = true
                                        requestSettings.unselectOtherFilter(id: filter.id)
                                        self.networkManager.fetchData()
                                    }else{
//                                        filter.isSelected = true
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
                                print("Saved \(news.title)")
                            } label: {
                                Image(systemName: "bookmark")
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
                        Image(systemName: "gearshape")
                            .padding(.trailing, 15)
                        
                        Image(systemName: "bell")
                            .fontWeight(.medium)
                            .padding(.trailing, 15)
                        Image(systemName: "magnifyingglass")
                            .fontWeight(.medium)
                    }
                })
                .padding(.top, 24)
                .listStyle(.plain)
                .refreshable {
                    self.networkManager.fetchData()
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
    }
}

struct PickerLabelView: View {
    var body: some View {
        Image(systemName: "line.3.horizontal")
            .foregroundColor(Color(UIColor.label))
            .imageScale(.large)
    }
}
