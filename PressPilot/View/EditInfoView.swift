//
//  EditInfoView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 10/8/23.
//

import SwiftUI

struct EditInfoView: View {
    @StateObject var viewModel = EditInfoViewModel()
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
//                        FormElements.InputFieldView(input: $viewModel.firstName, titleShown: "First Name", warningMessage: $viewModel.firstNameWarning)
//                        FormElements.InputFieldView(input: $viewModel.lastName, titleShown: "Last Name", warningMessage: $viewModel.lastNameWarning)
                    }
                    
                    Button{
                        if viewModel.isFormValid(){
                            viewModel.savePressed()
                        }
                    }label: {
                        FormElements.ButtonLabelView(buttonText: "Save")
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
    EditInfoView()
}
