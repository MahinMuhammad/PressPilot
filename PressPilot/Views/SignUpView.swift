//
//  RegistrationView.swift
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
import LoadingButton

struct SignUpView: View {
    @State private var firstName:String = "han"
    @State private var lastName:String = "ban"
    @State private var email:String = "2@2.com"
    @State private var password:String = "123456"
    @State private var isLoading: Bool = false
    
    @State private var regSuccess = false
    
    @EnvironmentObject var authService: AuthService
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode> //to popup one view back
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                FormElements.StartingTextView(text: "Sign up to unlock a personalized news experience tailored to your interests")
                
                VStack{
                    HStack(spacing: 30){
                        FormElements.InputFieldView(input: $firstName, titleShown: "First Name")
                        FormElements.InputFieldView(input: $lastName, titleShown: "Last Name")
                    }
                    FormElements.InputFieldView(input: $email, titleShown: "Email")
                    
                    FormElements.PasswordFielView(pass: $password)
                    
                    //loading button
                    LoadingButton(action: {
                        authService.signUpUser(firstName: firstName, lastName: lastName, email: email, password: password)
                        DispatchQueue.main.async {
                            regSuccess =  authService.signedIn
                        }
                    }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, strokeColor: .white)) {
                        Text("Sign Up")
                            .foregroundColor(Color.white)
                            .font(.system(size: 25))
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    
                    FormElements.FormToFormNavigationLinkView(prompt: "Already have an account?", navigationLinkText: "Sign In", destinationView: SignInView())
                    
                }
                .padding(.all)
            }
            .navigationTitle("Sign Up")
            .navigationBarTitleDisplayMode(.large)
            .padding(.leading, 19)
            .padding(.trailing, 19)
            .navigationBarBackButtonHidden(true)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
