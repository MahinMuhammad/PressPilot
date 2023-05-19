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
    
    @State private var isShowingSignInView = false
    @State private var logoutSuccess = false
    
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        NavigationStack {
            VStack{
                
            }
            .toolbar{
                Button("Log Out"){
                    do {
                        try Auth.auth().signOut()
                        logoutSuccess = true
                    } catch let signOutError as NSError {
                      print("Error signing out: %@", signOutError)
                    }
                }
                .navigationDestination(isPresented: $logoutSuccess) {
                    SignInView()
                }
            }
            .navigationDestination(isPresented: $isShowingSignInView) {
                SignInView()
            }
        }
        .onAppear{
            isShowingSignInView = !authService.signedIn
            
            //use below line to avoid firebase dependency
//            isShowingSignInView = false
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
    }
}
