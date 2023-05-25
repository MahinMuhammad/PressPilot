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
        var body: some View {
            FloatingLabelTextField($input, placeholder: titleShown)
                .floatingStyle(ThemeTextFieldStyle())
                .frame(height: 70)
        }
    }
    
    struct PasswordFielView: View {
        @Binding var pass:String
        @State private var isPasswordShow: Bool = false
        var body: some View {
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
    
    struct FormToFormNavigationLinkView<TheView: View>: View {
        let prompt:String
        let navigationLinkText:String
        let destinationView: TheView
        var body: some View {
            HStack {
                Text(prompt)
                    .fontWeight(.semibold)
                NavigationLink(destination: destinationView) {
                    Text(navigationLinkText)
                        .underline()
                        .fontWeight(.bold)
                }
                .foregroundColor(Color(UIColor.label))
            }
            .font(.system(size: 17))
        }
    }

}
