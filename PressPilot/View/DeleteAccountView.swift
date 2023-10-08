//
//  DeleteAccountView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import SwiftUI

struct DeleteAccountView: View {
    @StateObject var viewModel = DeleteAccountViewModel()
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Delete Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 1)
                
                FormElements.StartingTextView(text: "Give password to delete your account")
                
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
    DeleteAccountView()
}
