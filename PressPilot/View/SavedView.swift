//
//  SavedView.swift
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

struct SavedView: View {
    @StateObject var viewModel:SavedViewModel
    @StateObject var authService = AuthManager.shared
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    List(viewModel.savedNewsCollection){news in
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
                                    Text(viewModel.getSecondLevelDomain(from: news.url) ?? "")
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
                                        viewModel.deleteButtonPressed(delete: news)
                                    } label: {
                                        Image(systemName: "bookmark.fill")
                                    }
                                    .buttonStyle(.borderless)
                                    .padding(.trailing, 10)
                                }
                                .padding(.bottom, 20)
                            }
                            .padding(.top,5)
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        viewModel.fetchSavedNews()
                    }
                    .toolbar {
                        ToolbarItemGroup(placement: .navigation) {
                            Text("Saved News")
                                .fontWeight(.bold)
                                .font(.system(size: 24))
                        }
                        ToolbarItemGroup {
                            Button {
                                viewModel.showRemoveAllNewsAlert = true
                            } label: {
                                Image(systemName: "trash")
                                    .fontWeight(.medium)
                                    .foregroundColor(Color(UIColor.label))
                            }
                            .alert("Remove all saved news", isPresented: $viewModel.showRemoveAllNewsAlert) {
                                Button("No", role: .cancel) { }
                                Button("Yes", role: .destructive) {
                                    viewModel.removeAllSavedNews()
                                }
                            }
                        }
                    }
                }
                if !viewModel.newsLoaded(){
                    LoadingView(isAnimating: .constant(true), style: .large)
                }
                else if viewModel.isNewsEmpty(){
                    Text("No Saved News")
                }
            }
            .navigationDestination(isPresented: Binding<Bool>(get: {return !viewModel.authService.isSignedIn}, set: { p in viewModel.authService.isSignedIn = p})) {
                SignInView()
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView(viewModel: SavedViewModel())
    }
}
