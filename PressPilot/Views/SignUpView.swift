//
//  RegistrationView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI

struct SignUpView: View {
    var body: some View {
        NavigationView {
            ScrollView{
                VStack{
                    
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
