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
import LoadingButton

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRememberOn:Bool = false
    @State private var isLoading: Bool = false
    
    @EnvironmentObject var authService: AuthService
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        NavigationStack {
            ScrollView{
                VStack(alignment: .leading){
                    FormElements.StartingTextView(text: "Stay Signed In for a seamless experience")
                    
                    VStack{
                        FormElements.InputFieldView(input: $email,titleShown: "Email")
                        
                        FormElements.PasswordFielView(pass: $password)
                        
                        HStack(alignment: .center){
                            FormElements.CheckBoxView(isCheckMarked: $isRememberOn)
                            Text("Remember me")

                            Spacer()
                            
                            Text("Forgot password?")
                                .underline()
                        }
                        
                        //loading button
                        LoadingButton(action: {
                            //action
                        }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, strokeColor: .white)) {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .font(.system(size: 25))
                        }
                        .padding(.top)
                        .padding(.bottom, 40)
                        
                        FormElements.FormToFormNavigationLinkView(prompt: "Don't have an account?", navigationLinkText: "Sign Up", destinationView: SignUpView())
                    }
                    .padding(.all)
                }
                .padding(.leading, 19)
                .padding(.trailing, 19)
                .navigationTitle("Sign In")
                .navigationBarTitleDisplayMode(.large)
                .navigationBarBackButtonHidden(true)
            }
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
