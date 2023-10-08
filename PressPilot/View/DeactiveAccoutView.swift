//
//  DeactiveAccoutView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import SwiftUI

struct DeactiveAccoutView: View {
    @StateObject var viewModel = DeactivateAccountViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Deactivate Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 1)
                
                FormElements.StartingTextView(text: "Give password to deactivate your account")
                
                VStack{
                    FormElements.PasswordFielView(pass: $viewModel.password, titleShown: "Password", warningMessage: $viewModel.passwordWarning)
                    
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.confirmPressed()
                        }
                    }label: {
                        FormElements.ButtonLabelView(buttonText: "Confirm")
                    }
                }
                .padding()
            }
            .padding(.leading, 19)
            .padding(.trailing, 19)
        }
    }
}

#Preview {
    DeactiveAccoutView()
}
