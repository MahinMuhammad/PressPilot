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
    @State private var showRemoveAllNewsAlert = false
    @State private var logoutSuccess = false
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    
    @EnvironmentObject var networkManager: NetworkManager
    @EnvironmentObject var authService: AuthService
    @EnvironmentObject var dataService: DataService
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color("MyProfileBGColor")
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 20){
                        RoundedRectangle(cornerRadius: 15)
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
                                    
                                    Text("\(dataService.userData?.firstName ?? "") \(dataService.userData?.lastname ?? "")")
                                        .bold()
                                        .font(.system(size: 23))
                                        .padding(.top)
                                        .padding(.bottom, 1)
                                    
                                    Text(dataService.userData?.email ?? "")
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
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 110)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .overlay{
                                VStack{
                                    HStack{
                                        Picker(selection: $networkManager.rs.selectedLanguage, label: PickerLabelView(imageName: "doc.plaintext", title: "Language")) {
                                            ForEach(networkManager.rs.languages) { language in
                                                Text(language.language).tag(language.id)
                                            }
                                        }
                                        .foregroundColor(Color(UIColor.label))
                                        .pickerStyle(.navigationLink)
                                        
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color(UIColor.lightGray))
                                    }
                                    
                                    Divider()
                                    
                                    HStack{
                                        Picker(selection: $networkManager.rs.selectedCountry, label: PickerLabelView(imageName: "globe", title: "Country"))
                                        {
                                            ForEach(networkManager.rs.countries) { country in
                                                Text(country.country).tag(country.id)
                                            }
                                        }
                                        .foregroundColor(Color(UIColor.label))
                                        .pickerStyle(.navigationLink)
                                        
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color(UIColor.lightGray))
                                    }
                                }
                                .padding()
                            }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 110)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .overlay{
                                VStack{
                                    Button{
                                        showRemoveAllNewsAlert = true
                                    }label: {
                                        HStack{
                                            Image(systemName: "bookmark.slash")
                                            Text("Remove saved news")
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color(UIColor.lightGray))
                                        }
                                    }
                                    .tint(Color(UIColor.label))
                                    .alert("Remove all saved news", isPresented: $showRemoveAllNewsAlert) {
                                        Button("No", role: .cancel) { }
                                        Button("Yes", role: .destructive) {
                                            dataService.deleteAllSaveNews()
                                            let impactMed = UIImpactFeedbackGenerator(style: .heavy)
                                            impactMed.impactOccurred()
                                        }
                                    }
                                    
                                    Divider()
                                    
                                    HStack{
                                        Image(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left.slash")
                                        Text("Delete downloaded news")
                                        Spacer()
                                        Image(systemName: "chevron.forward")
                                            .foregroundColor(Color(UIColor.lightGray))
                                    }
                                }
                                .padding()
                            }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 80)
                            .foregroundColor(Color(UIColor.systemBackground))
                            .overlay{
                                Button{
                                    logoutSuccess = authService.signOut()
                                }label: {
                                    Text("Log Out")
                                        .fontWeight(.medium)
                                        .font(.system(size: 22))
                                        .tint(Color(UIColor.label))
                                        .frame(minWidth: 0, maxWidth: .infinity)
                                        .frame(height: 55)
                                        .overlay{
                                            RoundedRectangle(cornerRadius: 20)
                                                .stroke(Color(UIColor.label), lineWidth: 1)
                                        }
                                        .padding(10)
                                }
                                .navigationDestination(isPresented: $logoutSuccess) {
                                    SignInView()
                                }
                            }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                if dataService.userData == nil{
                    ZStack{
                        Color(K.CustomColors.bluishWhiteToBlack)
                            .edgesIgnoringSafeArea(.all)
                        LoadingView(isAnimating: .constant(true), style: .large)
                    }
                }
            }
            .navigationDestination(isPresented: Binding<Bool>(get: {return !authService.signedIn}, set: { p in authService.signedIn = p})) {
                SignInView()
            }
        }
        .onAppear{
            if authService.signedIn{
                self.dataService.readUserData()
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
            .environmentObject(AuthService())
            .environmentObject(NetworkManager())
            .environmentObject(DataService())
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

