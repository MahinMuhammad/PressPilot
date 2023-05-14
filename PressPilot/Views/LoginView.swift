//
//  LoginView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI
import LoadingButton

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @State var isLoading: Bool = false
    
    var body: some View {
        NavigationView {
            ScrollView{
                VStack(alignment: .leading){
                    Text("Stay Signed In for a seamless experience")
                        .foregroundColor(Color(UIColor.gray))
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                    
                    VStack {
                        FloatingLabelTextField($email, placeholder: "Email")
                            .floatingStyle(ThemeTextFieldStyle())
                            .frame(height: 70)
                        
                        FloatingLabelTextField($password, placeholder: "Password")
                            .isSecureTextEntry(true)
                            .floatingStyle(ThemeTextFieldStyle())
                            .frame(height: 70)
                        
                        Text("Forgot password?")
                        
                        LoadingButton(action: {
                            self.endEditing(true)
                        }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, strokeColor: .white)) {
                            Text("Sign In")
                                .foregroundColor(Color.white)
                                .font(.system(size: 25))
                        }
                        .padding(.top)
                        .padding(.bottom, 40)
                        
                        HStack {
                            Text("Don't have an account?")
                                .fontWeight(.semibold)
                            Text("Sign Up")
                                .underline()
                                .fontWeight(.bold)
                        }
                        .font(.system(size: 17))
                    }
                    .padding(.all)
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.leading, 21)
                .padding(.trailing, 21)
                .navigationTitle("Sign In")
            }
        }
        .onTapGesture {
            self.endEditing(true)
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
