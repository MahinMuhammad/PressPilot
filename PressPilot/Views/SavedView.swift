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
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var dataService: DataService
    
    var body: some View {
        NavigationStack{
            ZStack{
                VStack{
                    List(dataService.newsCollection){news in
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
                                    if dataService.isSaved(newsURl: news.url){
                                        dataService.deleteSaveNews(email: dataService.userData?.email, url: news.url)
                                    }else{
                                        dataService.saveNews(email: dataService.userData?.email, title: news.title, url: news.url, urlToImage: news.urlToImage)
                                    }
                                } label: {
                                    if dataService.isSaved(newsURl: news.url){
                                        Image(systemName: "bookmark.fill")
                                    }else{
                                        Image(systemName: "bookmark")
                                    }
                                }
                                .buttonStyle(.borderless)
                                .padding()
                            }
                        }
                        .listRowSeparator(.hidden)
                    }
                    .listStyle(.plain)
                    .refreshable {
                        self.dataService.fetchSavedNews()
                    }
                }
                if dataService.newsCollection.count == 0{
                    LoadingView(isAnimating: .constant(true), style: .large)
                }
            }
            .navigationDestination(isPresented: Binding<Bool>(get: {return !authService.signedIn}, set: { p in authService.signedIn = p})) {
                SignInView()
            }
        }
        .onAppear{
            if authService.signedIn{
                self.dataService.fetchSavedNews()
            }
        }
    }
}

struct SavedView_Previews: PreviewProvider {
    static var previews: some View {
        SavedView()
            .environmentObject(AuthService())
            .environmentObject(DataService())
    }
}
