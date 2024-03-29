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
    @StateObject var viewModel:MyProfileViewModel
    
    var body: some View {
        NavigationStack{
            ZStack {
                Color(K.CustomColors.bluishWhiteToBlack)
                    .edgesIgnoringSafeArea(.all)
                ScrollView {
                    VStack(spacing: 20){
                        RoundedRectangle(cornerRadius: 25)
                            .foregroundColor(Color("ProfileInfoColor"))
                            .frame(height: 150)
                            .overlay{
                                HStack(alignment: .top){
                                    RoundedRectangle(cornerRadius: 25)
                                        .frame(width: 90, height: 90)
                                        .foregroundColor(Color.gray)
                                        .overlay{
                                            Image(systemName: "person.fill")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(height: 60)
                                        }
                                    
                                    VStack(alignment: .leading){
                                        Text("\(viewModel.user?.firstName ?? "Failed to fetch") \(viewModel.user?.lastname ?? "")")
                                            .bold()
                                            .font(.system(size: 23))
                                            .padding(.top, 3)
                                            .padding(.bottom, 1)
                                            .lineLimit(1)
                                        
                                        Text(viewModel.user?.email ?? "Failed to fetch")
                                            .bold()
                                            .font(.system(size: 15))
                                            .tint(Color(UIColor.darkGray))
                                    }
                                    .frame(maxWidth: 200, alignment: .leading)
                                }
                                .padding(.leading, 30)
                                .frame(maxWidth: .infinity, alignment: .leading)
                            }
                        
                        //edit info or change password
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 110)
                            .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                            .overlay{
                                VStack{
                                    NavigationLink(destination: EditInfoView(viewModel: EditInfoViewModel(profileViewModel: viewModel))){
                                        HStack{
                                            Image(systemName: "pencil.and.outline")
                                            Text("Edit info")
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color(UIColor.lightGray))
                                        }
                                    }
                                    .tint(Color(UIColor.label))
                                    
                                    Divider()
                                    
                                    NavigationLink(destination: ChangePasswordView()) {
                                        HStack{
                                            Image(systemName: "person.badge.key")
                                            Text("Change Password")
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color(UIColor.lightGray))
                                        }
                                    }
                                    .tint(Color(UIColor.label))
                                }
                                .padding()
                            }
                        
                        //delete or deactivate account
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 110)
                            .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                            .overlay{
                                VStack{
                                    NavigationLink(destination: DeactiveAccoutView()){
                                        HStack{
                                            Image(systemName: "stop.circle")
                                            Text("Deactivate account")
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color(UIColor.lightGray))
                                        }
                                    }
                                    .tint(Color(UIColor.label))
                                    
                                    Divider()
                                    
                                    NavigationLink(destination: DeleteAccountView()) {
                                        HStack{
                                            Image(systemName: "trash")
                                            Text("Delete account")
                                            Spacer()
                                            Image(systemName: "chevron.forward")
                                                .foregroundColor(Color(UIColor.lightGray))
                                        }
                                    }
                                    .tint(Color(UIColor.label))
                                }
                                .padding()
                            }
                        
                        //                        RoundedRectangle(cornerRadius: 25)
                        //                            .frame(height: 110)
                        //                            .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                        //                            .overlay{
                        //                                VStack{
                        //                                    Button{
                        //                                        viewModel.showRemoveAllNewsAlert = true
                        //                                    }label: {
                        //                                        HStack{
                        //                                            Image(systemName: "bookmark.slash")
                        //                                            Text("Remove saved news")
                        //                                            Spacer()
                        //                                            Image(systemName: "chevron.forward")
                        //                                                .foregroundColor(Color(UIColor.lightGray))
                        //                                        }
                        //                                    }
                        //                                    .tint(Color(UIColor.label))
                        //                                    .alert("Remove all saved news", isPresented: $viewModel.showRemoveAllNewsAlert) {
                        //                                        Button("No", role: .cancel) { }
                        //                                        Button("Yes", role: .destructive) {
                        //                                            viewModel.removeSavedNews()
                        //                                        }
                        //                                    }
                        //
                        //                                    Divider()
                        //
                        //                                    HStack{
                        //                                        Image(systemName: "rectangle.and.arrow.up.right.and.arrow.down.left.slash")
                        //                                        Text("Delete downloaded news")
                        //                                        Spacer()
                        //                                        Image(systemName: "chevron.forward")
                        //                                            .foregroundColor(Color(UIColor.lightGray))
                        //                                    }
                        //                                }
                        //                                .padding()
                        //                            }
                        
                        RoundedRectangle(cornerRadius: 25)
                            .frame(height: 80)
                            .foregroundColor(Color(K.CustomColors.whiteToDarkGray))
                            .overlay{
                                Button{
                                    viewModel.logoutSuccess = viewModel.signOut()
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
                                .navigationDestination(isPresented: $viewModel.logoutSuccess) {
                                    SignInView()
                                }
                            }
                    }
                    .padding(.leading)
                    .padding(.trailing)
                }
                .toolbar {
                    ToolbarItem(placement: .navigation) {
                        Text("Profile")
                            .fontWeight(.bold)
                            .font(.system(size: 24))
                            .padding(.leading)
                    }
                }
                if !viewModel.userLoaded(){
                    ZStack{
                        Color(K.CustomColors.bluishWhiteToBlack)
                            .edgesIgnoringSafeArea(.all)
                        LoadingView(isAnimating: .constant(true), style: .large)
                    }
                }
            }
            .navigationDestination(isPresented: Binding<Bool>(get: {return !viewModel.authManager.isSignedIn}, set: { p in viewModel.authManager.isSignedIn = p})) {
                SignInView()
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView(viewModel: MyProfileViewModel())
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

