//
//  FormElements.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/14/23.
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

import Foundation
import SwiftUI
import FloatingLabelTextFieldSwiftUI
import LoadingButton

struct FormElements{
    struct StartingTextView: View {
        let text:String
        var body: some View {
            Text(text)
                .foregroundColor(Color(UIColor.gray))
                .fontWeight(.semibold)
                .font(.system(size: 18))
        }
    }
    
    struct InputFieldView: View {
        @Binding var input: String
        let titleShown: String
        @Binding var warningMessage:String?
        
        var body: some View {
            VStack(alignment: .leading) {
                FloatingLabelTextField($input, placeholder: titleShown)
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                
                Text(warningMessage ?? "")
                    .foregroundColor(.red)
            }
        }
    }
    
    struct PasswordFielView: View {
        @Binding var pass:String
        @State private var isPasswordShow: Bool = false
        @Binding var warningMessage:String?
        
        var body: some View {
            VStack(alignment: .leading) {
                FloatingLabelTextField($pass, placeholder: "Password")
                    .isSecureTextEntry(!isPasswordShow)
                    .rightView({
                        Button {
                            withAnimation {
                                isPasswordShow.toggle()
                            }
                        } label: {
                            isPasswordShow ? Image(systemName: "eye.fill") : Image(systemName: "eye.slash.fill")
                        }
                        .foregroundColor(.gray)
                    })
                    .floatingStyle(ThemeTextFieldStyle())
                    .frame(height: 70)
                
                Text(warningMessage ?? "")
                    .foregroundColor(.red)
            }
        }
    }
    
    struct CheckBoxView: View {
        @Binding var isCheckMarked:Bool
        var body: some View {
            Button {
                isCheckMarked.toggle()
            } label: {
                !isCheckMarked ? Image(systemName: "square") : Image(systemName: "checkmark.square.fill")
            }
            .imageScale(.large)
            .foregroundColor(.gray)
        }
    }
    
    struct ButtonLabelView: View {
        let buttonText:String
        var body: some View {
            Text(buttonText)
                .foregroundColor(Color.white)
                .font(.system(size: 25))
                .frame(width: 312, height: 54)
                .background(Color.blue)
                .cornerRadius(25)
        }
    }
}
