//
//  MyProfileView.swift
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
import FirebaseAuth

struct MyProfileView: View {
    @State private var logoutSuccess = false
    @State private var email = ""
    
    @ObservedObject var networkManager = NetworkManager()
    
    @EnvironmentObject var authService: AuthService
    
    init() {
        // Modify UITableView appearance
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().tableFooterView = UIView()
    }
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("MyProfileBGColor")
                    .edgesIgnoringSafeArea(.all)
                VStack{
                    RoundedRectangle(cornerRadius: 15)
                        .padding(.leading)
                        .padding(.trailing)
                        .foregroundColor(Color("ProfileInfoColor"))
                        .frame(height: 330)
                        .overlay{
                            VStack{
                                RoundedRectangle(cornerRadius: 50)
                                    .frame(width: 150, height: 150)
                                    .foregroundColor(Color.gray)
                                    .overlay{
                                        Image(systemName: "figure.stand")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(height: 100)
                                    }
                                
                                Text("Mahinur Rahman")
                                    .bold()
                                    .font(.system(size: 23))
                                    .padding(.top)
                                    .padding(.bottom, 1)
                                
                                Text("1@2.com")
                                    .bold()
                                    .font(.system(size: 15))
                                    .tint(Color(UIColor.darkGray))
                                
                                Button{
                                    
                                }label: {
                                    RoundedRectangle(cornerRadius: 50)
                                        .frame(width: 159, height: 40)
                                        .overlay{
                                            HStack{
                                                Text("Edit Profile")
                                                Image(systemName: "chevron.forward")
                                            }
                                            .fontWeight(.medium)
                                            .foregroundColor(.white)
                                        }
                                }
                            }
                        }
                    
                    List {
                        Picker(selection: $networkManager.rs.selectedLanguage, label: PickerLabelView(imageName: "doc.plaintext", title: "Language")) {
                            ForEach(networkManager.rs.languages) { language in
                                Text(language.language).tag(language.id)
                            }
                        }
                        .foregroundColor(Color(UIColor.label))
                        .pickerStyle(.navigationLink)
                        
                        Picker(selection: $networkManager.rs.selectedCountry, label: PickerLabelView(imageName: "globe", title: "Country")) {
                            ForEach(networkManager.rs.countries) { country in
                                Text(country.country).tag(country.id)
                            }
                        }
                        .foregroundColor(Color(UIColor.label))
                        .pickerStyle(.navigationLink)
                    }
                    .scrollDisabled(true)
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    
                    List{
                        
                        HStack{
                            Image(systemName: "bookmark.slash")
                            Text("Remove saved news")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color(UIColor.lightGray))
                                .imageScale(.small)
                        }
                        
                        HStack{
                            Image(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left.slash")
                            Text("Delete downloaded news")
                            Spacer()
                            Image(systemName: "chevron.forward")
                                .foregroundColor(Color(UIColor.lightGray))
                                .imageScale(.small)
                        }
                    }
                    .scrollDisabled(true)
                    .padding(.top,-40)
                    
                    Spacer()
                }
                .toolbar{
                    Button("Log Out"){
                        logoutSuccess = authService.signOut()
                    }
                    .navigationDestination(isPresented: $logoutSuccess) {
                        SignInView()
                    }
                }
            }
            //            .navigationDestination(isPresented: Binding<Bool>(get: {return !authService.signedIn}, set: { p in authService.signedIn = p})) {
            //                SignInView()
            //            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
            .environmentObject(AuthService())
    }
}

struct PickerLabelView: View {
    let imageName:String
    let title:String
    var body: some View {
        Image(systemName: imageName)
            .foregroundColor(Color(UIColor.label))
            .imageScale(.large)
        Text(title)
    }
}

