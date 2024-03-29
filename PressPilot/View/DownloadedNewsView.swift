//
//  DownloadedView.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/15/23.
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

struct DownloadedNewsView: View {
    @StateObject var viewModel = DownloadedNewsViewModel()
    var body: some View {
        NavigationStack{
            Text("DownloadedView")
                .navigationDestination(isPresented: Binding<Bool>(get: {return !viewModel.authService.isSignedIn}, set: { p in viewModel.authService.isSignedIn = p})) {
                    SignInView()
                }
        }
    }
}

struct DownloadedNewsView_Previews: PreviewProvider {
    static var previews: some View {
        DownloadedNewsView()
    }
}
