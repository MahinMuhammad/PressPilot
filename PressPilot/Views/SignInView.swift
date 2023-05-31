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
    
    @State var emailWarning:String?
    @State var passwordWarning:String?
    @State private var showSignInFail:Bool = false
    
    func formValidation()->Bool{
        var flag:Bool = true
        emailWarning = ""
        passwordWarning = ""
        if email == ""{
            flag = false
            emailWarning = "Email Required"
        }
        if password == ""{
            flag = false
            passwordWarning = "Password Required"
        }
        return flag
    }
    
    @EnvironmentObject var authService: AuthService
    
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    
    var body: some View {
        
        ScrollView{
            VStack(alignment: .leading){
                FormElements.StartingTextView(text: "Stay Signed In for a seamless experience")
                
                VStack{
                    FormElements.InputFieldView(input: $email,titleShown: "Email", warningMessage: $emailWarning)
                    
                    FormElements.PasswordFielView(pass: $password, warningMessage: $passwordWarning)
                    
                    HStack(alignment: .center){
                        FormElements.CheckBoxView(isCheckMarked: $isRememberOn)
                        Text("Remember me")
                        
                        Spacer()
                        
                        Text("Forgot password?")
                            .underline()
                    }
                    .padding(.top, 10)
                    
                    //button
                    Button{
                        if formValidation(){
                            authService.signInUser(email: email, password: password)
                        }
                    } label: {
                        FormElements.ButtonLabelView(buttonText: "Sign In")
                    }
                    .padding(.top)
                    .padding(.bottom, 40)
                    .alert(authService.errorMessage, isPresented: $showSignInFail) {
                        Button("Ok", role: .cancel){}
                    }
                    //button ending
                    
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
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
            .environmentObject(AuthService())
    }
}
