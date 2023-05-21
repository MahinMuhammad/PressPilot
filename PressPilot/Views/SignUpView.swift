//
//  RegistrationView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

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
    
    var body: some View {
        NavigationStack {
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
                .padding(.leading, 19)
                .padding(.trailing, 19)
                
            }
            .navigationDestination(isPresented: $regSuccess){
                MyProfileView()
            }
        }
        .navigationBarBackButtonHidden(true)
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
