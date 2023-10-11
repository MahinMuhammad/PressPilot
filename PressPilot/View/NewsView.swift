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
    @StateObject var viewModel:NewsViewModel
    @StateObject var rs = RequestManager.shared
    
    var body: some View {
        NavigationStack{
            ZStack{
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
                                    viewModel.loadNews()
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
                                    viewModel.loadNews()
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
                                    self.viewModel.loadNews()
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
                                                viewModel.loadNews()
                                            }
                                        }
                                }
                            }
                        }
                        .padding(.leading, 16)
                        .padding(.top, 24)
                    }
                    
                    List(viewModel.newsCollection){news in
                        HStack(){
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
                                
                                Spacer()
                                
                                HStack(alignment: .top){
                                    Text(viewModel.getSecondLevelDomain(from: news.url))
                                        .lineLimit(1)
                                        .font(.system(size: 13))
                                        .foregroundStyle(Color(UIColor.systemBackground))
                                        .padding(.top,1)
                                        .padding(.bottom,1)
                                        .padding(.leading,7)
                                        .padding(.trailing,7)
                                        .background {
                                            RoundedRectangle(cornerRadius: 7)
                                                .foregroundStyle(Color(K.CustomColors.grayToBluish))
                                        }
                                        .padding(.leading, 10)
                                    
                                    Spacer()
                                    
                                    Button {
                                        viewModel.saveButtonPressed(save: news)
                                    } label: {
                                        Image(systemName: viewModel.isSaved(newsURl: news.url) == true ? "bookmark.fill" : "bookmark")
                                    }
                                    .alert("SignIn to Save News", isPresented: $viewModel.showingAlertToSignIn) {
                                        Button("OK", role: .cancel) { }
                                    }
                                    .buttonStyle(.borderless)
                                    .padding(.trailing, 10)
                                }
                                .padding(.bottom, 20)
                            }
                            .padding(.top,5)
                        }
                        .listRowSeparator(.hidden)
                        .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                            Button(role: .destructive){
                                print("Hide")
                            }label: {
                                VStack{
                                    Image(systemName: "xmark.bin.fill")
                                    Text("Hide")
                                }
                            }
                            .tint(.red)
                            
                            Button{
                                print("Report")
                            }label: {
                                VStack{
                                    Image(systemName: "exclamationmark.circle.fill")
                                    Text("Report")
                                }
                            }
                            .tint(.orange)
                        }
                        .swipeActions(edge: .leading, allowsFullSwipe: true) {
                            Button{
                                print("Download")
                            }label: {
                                VStack{
                                    Image(systemName: "arrow.down.square.fill")
                                    Text("Download")
                                }
                            }
                            .tint(.accentColor)
                            
                            Button{
                                print("Share")
                            }label: {
                                VStack{
                                    Image(systemName: "arrowshape.turn.up.right.fill")
                                    Text("Share")
                                }
                            }
                            .tint(.green)
                        }
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
                        self.viewModel.loadNews()
                    }
                }
                
                if !viewModel.newsLoaded(){
                    LoadingView(isAnimating: .constant(true), style: .large)
                }
                else if viewModel.zeroNewsLoaded(){
                    Text(viewModel.emptyListMessage)
                }
            }
        }
        .padding(.top,16)
        .sheet(isPresented: $viewModel.showAppSettings, content: SettingsView.init)
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
        NewsView(viewModel: NewsViewModel())
    }
}
