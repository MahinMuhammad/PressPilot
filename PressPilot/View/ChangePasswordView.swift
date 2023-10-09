//
//  ChangePasswordView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
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

struct ChangePasswordView: View {
    @StateObject var viewModel = ChangePasswordViewModel()
    @Environment(\.dismiss) var dismiss
    var body: some View {
            ScrollView{
                VStack(alignment: .leading){
                    Text("Reset Password")
                        .font(.largeTitle)
                        .bold()
                        .padding(.bottom, 1)
                    
                    FormElements.StartingTextView(text: "Your new password must be different from previous used passwords")
                    
                    VStack{
                        FormElements.PasswordFielView(pass: $viewModel.oldPassword, titleShown: "Old Password", warningMessage: $viewModel.oldPasswordWarning)
                        
                        FormElements.PasswordFielView(pass: $viewModel.newPassword, titleShown: "New Password", warningMessage: $viewModel.newPasswordWarning)
                        
                        FormElements.PasswordFielView(pass: $viewModel.confirmPassword, titleShown: "Confirm Password", warningMessage: $viewModel.confirmPasswordWarning)
                        
                        Button {
                            if viewModel.isFormValid(){
                                viewModel.resetPressed()
                            }
                        } label: {
                            FormElements.ButtonLabelView(buttonText: "Reset")
                        }
                        .alert("Password Changed", isPresented: $viewModel.showCompletionAlert) {
                            Button("Ok", role: .none) {
                                dismiss()
                            }
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
    ChangePasswordView()
}
