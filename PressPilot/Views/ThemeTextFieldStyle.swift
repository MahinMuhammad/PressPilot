//
//  ThemeTextFieldStyle.swift
//  PressPilot
//
//  Created by Md. Mahinur Rahman on 5/14/23.
//

import Foundation
import FloatingLabelTextFieldSwiftUI
import SwiftUI

struct ThemeTextFieldStyle: FloatingLabelTextFieldStyle {
    func body(content: FloatingLabelTextField) -> FloatingLabelTextField {
        content
            .spaceBetweenTitleText(30) // Sets the space between title and text.
            .textAlignment(.leading) // Sets the alignment for text.
            .lineHeight(1) // Sets the line height.
            .selectedLineHeight(1.5) // Sets the selected line height.
            .lineColor(.gray) // Sets the line color.
            .selectedLineColor(.blue) // Sets the selected line color.
            .titleColor(.gray) // Sets the title color.
            .selectedTitleColor(.blue) // Sets the selected title color.
            .titleFont(.system(size: 15)) // Sets the title font.
            .textColor(Color(UIColor.label)) // Sets the text color.
            .selectedTextColor(Color(UIColor.label)) // Sets the selected text color.
            .textFont(.system(size: 18)) // Sets the text font.
            .placeholderColor(.gray) // Sets the placeholder color.
            .placeholderFont(.system(size: 18)) // Sets the placeholder font.
            .errorColor(.red) // Sets the error color.
            .addDisableEditingAction([.paste]) // Disable text field editing action. Like cut, copy, past, all etc.
            .enablePlaceholderOnFocus(false) // Enable the placeholder label when the textfield is focused.
            .allowsHitTesting(true) // Whether this view participates in hit test operations.
            .disabled(false) // Whether users can interact with this.
    }
}
