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
    
    @EnvironmentObject var authService: AuthService
    
    var body: some View {
        if !authService.signedIn{
            SignInView()
        }else{
            VStack{
                Text("MyProfileView")
            }
            .toolbar{
                Button("Log Out"){
                    //below condition is checked to avoid firebase dependency on preview
                    if ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"{
                        //no firebase medhod is called. any value is needed provided by another way.
                    }else{
                        logoutSuccess = authService.signOut() //firebase method is called and the value used
                    }
                }
                .navigationDestination(isPresented: $logoutSuccess) {
                    SignInView()
                }
            }
        }
    }
}

struct MyProfileView_Previews: PreviewProvider {
    static var previews: some View {
        MyProfileView()
            .environmentObject(AuthService())
    }
}
