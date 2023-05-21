//
//  LoginView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import LoadingButton

struct SignInView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var isRememberOn:Bool = false
    @State private var isLoading: Bool = false
    
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
            }
        }
//        .toolbar(.hidden, for: .navigationBar)
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

struct SignInView_Previews: PreviewProvider {
    static var previews: some View {
        SignInView()
    }
}
