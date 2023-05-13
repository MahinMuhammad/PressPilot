//
//  LoginView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/13/23.
//

import SwiftUI
import FloatingLabelTextFieldSwiftUI

struct LoginView: View {
    @State private var name: String = "Tim"
    var body: some View {
        NavigationView {
            VStack{
                Text("Stay Signed In for a seamless experience")
                    .foregroundColor(Color(UIColor.darkGray))
                    .fontWeight(.semibold)
                
                Spacer()
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 21)
//            .background(Color.green)
            .navigationTitle("Sign In")
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
