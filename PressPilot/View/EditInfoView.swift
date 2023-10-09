//
//  EditInfoView.swift
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

struct EditInfoView: View {
    @StateObject var viewModel:EditInfoViewModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        ScrollView{
            VStack(alignment: .leading){
                Text("Edit Account")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 1)
                
                FormElements.StartingTextView(text: "Change your account informations")
                
                VStack{
                    HStack(spacing: 30){
                        FormElements.InputFieldView(input: $viewModel.firstName, titleShown: "First Name", warningMessage: $viewModel.firstNameWarning)
                        FormElements.InputFieldView(input: $viewModel.lastName, titleShown: "Last Name", warningMessage: $viewModel.lastNameWarning)
                    }
                    
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.savePressed()
                        }
                    }label: {
                        FormElements.ButtonLabelView(buttonText: "Save")
                    }
                    .alert("Update Successful", isPresented: $viewModel.showCompletionAlert) {
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
        .onAppear{
            viewModel.fetchUserData()
        }
    }
}

#Preview {
    EditInfoView(viewModel: EditInfoViewModel(profileViewModel: MyProfileViewModel()))
}
