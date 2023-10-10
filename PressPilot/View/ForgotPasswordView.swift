//
//  ForgotPasswordView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/10/23.
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

struct ForgotPasswordView: View {
    @StateObject var viewModel = ForgotPasswordViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Forgot Password?")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 1)
                
                FormElements.StartingTextView(text: "Enter your email address to send a link")
                
                VStack{
                    FormElements.InputFieldView(input: $viewModel.email, titleShown: "Email", warningMessage: $viewModel.emailWarning)
                    
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.sendPressed()
                        }
                    }label: {
                        FormElements.ButtonLabelView(buttonText: "Send")
                    }
                    .alert("Email Send", isPresented: $viewModel.showCompletionAlert) {
                        Button("Ok", role: .none) {
                            dismiss()
                        }
                    }message: {
                        Text("Check your email")
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
    ForgotPasswordView()
}
