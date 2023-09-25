//
//  LoginView.swift
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
import FloatingLabelTextFieldSwiftUI

struct SignInView: View {
    @StateObject var viewModel = SignInViewModel()
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                FormElements.StartingTextView(text: "Stay Signed In for a seamless experience")
                
                VStack{
                    FormElements.InputFieldView(input: $viewModel.email,titleShown: "Email", warningMessage: $viewModel.emailWarning)
                    
                    FormElements.PasswordFielView(pass: $viewModel.password, warningMessage: $viewModel.passwordWarning)
                    
                    HStack(alignment: .center){
                        FormElements.CheckBoxView(isCheckMarked: $viewModel.isRememberOn)
                        Text("Remember me")
                        
                        Spacer()
                        
                        Text("Forgot password?")
                            .underline()
                    }
                    .padding(.top, 10)
                    
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.signInPressed()
                        }
                    } label: {
                        FormElements.ButtonLabelView(buttonText: "Sign In")
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    
                    HStack {
                        Text("Don't have an account?")
                            .fontWeight(.semibold)
                        NavigationLink(destination: SignUpView()) {
                            Text("Sign Up")
                                .underline()
                                .fontWeight(.bold)
                        }
                        .foregroundColor(Color(UIColor.label))
                    }
                    .font(.system(size: 17))
                }
                .padding(.all)
            }
            .padding(.leading, 19)
            .padding(.trailing, 19)
            .navigationTitle("Sign In")
            .navigationBarTitleDisplayMode(.large)
            .navigationBarBackButtonHidden(true)
            .onAppear{
                viewModel.fetchSignInDetails()
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthManager())
    }
}
