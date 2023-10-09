//
//  DeactiveAccoutView.swift
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
