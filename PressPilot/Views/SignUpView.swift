//
//  RegistrationView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName:String = ""
    @State private var lasttName:String = ""
    @State private var email:String = ""
    @State private var password:String = ""
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading){
                    FormElements.StartingTextView(text: "Sign up to unlock a personalized news experience tailored to your interests")
                    
                    VStack{
                        HStack(spacing: 30){
                            FormElements.InputFieldView(input: $firstName, titleShown: "First Name")
                            FormElements.InputFieldView(input: $lasttName, titleShown: "Last Name")
                        }
                        FormElements.InputFieldView(input: $email, titleShown: "Email")
                        
                        FormElements.PasswordFielView(pass: $password)
                        
                        FormElements.LoadingButtonView(buttonName: "Sign Up")
                        
                        FormElements.FormToFormNavigationLinkView(prompt: "Already have an account?", navigationLinkText: "Sign In", destinationView: SignInView())
                    }
                    .padding(.all)
                }
                .padding(.leading, 19)
                .padding(.trailing, 19)
                .navigationTitle("Sign Up")
            }
        }
        .toolbar(.hidden, for: .navigationBar)
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}
