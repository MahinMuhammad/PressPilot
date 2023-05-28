//
//  CustomPicker.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/28/23.
//

import Foundation
import SwiftUI

struct CustomPicker<SelectionValue, Content>: View where SelectionValue: Hashable, Content: View {
    @Binding var selectedOption: SelectionValue?
    let content: Content
    
    init(selectedOption: Binding<SelectionValue?>, @ViewBuilder content: () -> Content) {
        self._selectedOption = selectedOption
        self.content = content()
    }
    
    var body: some View {
        VStack {
            if selectedOption != nil {
                content.hidden()
            } else {
                Picker(selection: $selectedOption, label: Image(systemName: "line.3.horizontal").foregroundColor(Color(UIColor.label)).imageScale(.large)) {
                    content
                }
                .pickerStyle(SegmentedPickerStyle())
            }
        }
    }
}
