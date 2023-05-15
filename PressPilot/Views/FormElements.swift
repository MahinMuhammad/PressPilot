//
//  FormElements.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/14/23.
//

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
    
    struct LoadingButtonView: View {
        let buttonName:String
        @State private var isLoading: Bool = false
        var body: some View {
            LoadingButton(action: {
                self.endEditing(true)
            }, isLoading: $isLoading, style: LoadingButtonStyle(cornerRadius: 27, strokeColor: .white)) {
                Text(buttonName)
                    .foregroundColor(Color.white)
                    .font(.system(size: 25))
            }
            .padding(.top)
            .padding(.bottom, 40)
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
