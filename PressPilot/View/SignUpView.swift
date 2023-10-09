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

struct SignUpView: View {
    @StateObject var viewModel = SignUpViewModel()
    @StateObject var authService = AuthManager.shared
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                FormElements.StartingTextView(text: "Sign up to unlock a personalized news experience tailored to your interests")
                
                VStack{
                    HStack(spacing: 30){
                        FormElements.InputFieldView(input: $viewModel.firstName, titleShown: "First Name", warningMessage: $viewModel.firstNameWarning)
                        FormElements.InputFieldView(input: $viewModel.lastName, titleShown: "Last Name", warningMessage: $viewModel.lastNameWarning)
                    }
                    FormElements.InputFieldView(input: $viewModel.email, titleShown: "Email", warningMessage: $viewModel.emailWarning)
                    
                    FormElements.PasswordFielView(pass: $viewModel.password, titleShown: "Password", warningMessage: $viewModel.passwordWarning)
                    
                    //button
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.signUpPressed()
                        }
                    } label: {
                        FormElements.ButtonLabelView(buttonText: "Sign Up")
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    //button ending
                    
                    HStack {
                        Text("Already have an account?")
                            .fontWeight(.semibold)
                        Button {
                            self.presentationMode.wrappedValue.dismiss()
                        } label: {
                            Text("Sign In")
                                .underline()
                                .fontWeight(.bold)
                        }
                        .foregroundColor(Color(UIColor.label))
                    }
                    .font(.system(size: 17))
                    
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
