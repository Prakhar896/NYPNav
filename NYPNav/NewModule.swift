//
//  NewModule.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI
import UIKit

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

struct NewModule: View {
    @ObservedObject var appState: AppState
    
    @State var moduleCode: String = ""
    @State var moduleName: String = ""
    @State var tutorName: String = ""
    @State var tutorNumber: String = ""
    @State var addData: [String: String] = [:]
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    ParameterInputView(parameterName: "Module Code:", value: $moduleCode, prompt: "e.g IT1234")
                    ParameterInputView(parameterName: "Module Name:", value: $moduleName, prompt: "e.g Mathematics")
                    ParameterInputView(parameterName: "Tutor Name:", value: $tutorName, prompt: "e.g Mr John Appleseed")
                    ParameterInputView(parameterName: "Tutor Number:", value: $tutorNumber, prompt: "e.g +65 1234 5678")
                        .keyboardType(.phonePad)
                } header: {
                    Text("Basic Module Info")
                }
            }
            .navigationTitle("New Module")
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button("Done") {
                            UIApplication.shared.endEditing()
                        }
                    }
                }
            }
        }
    }
}

struct NewModule_Previews: PreviewProvider {
    static var previews: some View {
        NewModule(appState: AppState())
    }
}
