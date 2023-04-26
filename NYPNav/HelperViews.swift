//
//  HelperViews.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI

struct ParameterView: View {
    var parameter: String
    var value: String
    
    var body: some View {
        HStack {
            Text(parameter)
            Spacer()
            Text(value)
                .bold()
                .textSelection(.enabled)
        }
        .padding(5)
    }
}

struct ParameterInputView: View {
    var parameterName: String
    @Binding var value: String
    var prompt: String
    
    var body: some View {
        HStack {
            Text(parameterName)
            TextField(prompt, text: $value)
                .multilineTextAlignment(.trailing)
        }
    }
}
