//
//  NewModule.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI
import UIKit

struct ManageModuleView: View {
    @ObservedObject var appState: AppState
    @Binding var selectedModuleIndex: Int
    @Environment(\.dismiss) var dismiss
    @Binding var mode: ManageModuleMode
    
    @State var moduleCode: String = ""
    @State var moduleName: String = ""
    @State var tutorName: String = ""
    @State var tutorNumber: String = ""
    @State var addData: [String: String] = [:]
    
    @StateObject var addParams: AddParams = AddParams(params: [])
    
    // Alerts
    @State var showingAlert = false
    @State var alertTitle: String = ""
    @State var alertMessage: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                // Basic module info section
                Section {
                    ParameterInputView(parameterName: "Module Code:", value: $moduleCode, prompt: "e.g IT1234")
                    ParameterInputView(parameterName: "Module Name:", value: $moduleName, prompt: "e.g Mathematics")
                    ParameterInputView(parameterName: "Tutor Name:", value: $tutorName, prompt: "e.g Mr John Appleseed")
                    ParameterInputView(parameterName: "Tutor Number:", value: $tutorNumber, prompt: "e.g +65 1234 5678")
                        .keyboardType(.phonePad)
                } header: {
                    Text("Basic Module Info")
                }
                
                // Additional parameters section
                Section {
                    ForEach(0..<addParams.params.count, id: \.self) { index in
                        HStack {
                            TextField("Parameter Name", text: $addParams.params[index].paramName)
                            Divider()
                            TextField("Parameter Value", text: $addParams.params[index].paramValue)
                        }
                        .padding(3)
                    }
                    .onDelete(perform: removeParam)
                } header: {
                    HStack {
                        Text("Additional Parameters")
                        Spacer()
                        Button {
                            withAnimation {
                                addParams.params.append(AdditionalParameter(paramName: "", paramValue: ""))
                            }
                        } label: {
                            Image(systemName: "plus")
                        }
                    }
                } footer: {
                    if addParams.params.count > 0 {
                        Text("Note: Parameters for which a valid name and value are not provided will be rejected. You can swipe left on a row to delete a parameter.")
                    }
                }
                
                // Save button section
                Section {
                    Button(action: validateAndUpdateModule) {
                        Text(mode == .new ? "Save Module": "Save Changes")
                            .bold()
                            .foregroundColor(.accentColor)
                            .padding()
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                    }
                    .background(Color.accentColor.opacity(0.2))
                    .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                }
                
                // Delete module button section
                if mode == .edit {
                    Section {
                        Button(action: deleteModule) {
                            Text("Delete Module")
                                .bold()
                                .foregroundColor(.red)
                                .padding()
                                .frame(maxWidth: .infinity, maxHeight: .infinity)
                        }
                        .background(Color.red.opacity(0.2))
                        .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
                    }
                }
            }
            .navigationTitle(mode == .new ? "New Module": "Edit \(appState.modules[selectedModuleIndex].moduleCode)")
            .onAppear {
                // fill in form if in edit mode
                if mode == .edit {
                    moduleCode = appState.modules[selectedModuleIndex].moduleCode
                    moduleName = appState.modules[selectedModuleIndex].name
                    tutorName = appState.modules[selectedModuleIndex].tutorName
                    tutorNumber = appState.modules[selectedModuleIndex].tutorNumber
                    
                    appState.modules[selectedModuleIndex].addData.forEach { key, value in
                        addParams.params.append(AdditionalParameter(paramName: key, paramValue: value))
                    }
                }
            }
            .toolbar {
                ToolbarItem(placement: .keyboard) {
                    HStack {
                        Button("Done") {
                            UIApplication.shared.endEditing()
                        }
                    }
                }
            }
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }

        }
    }
    
    func removeParam(at offsets: IndexSet) {
        addParams.params.remove(atOffsets: offsets)
    }
    
    func makeAndShowAlert(withTitle title: String, andMessage message: String) {
        alertTitle = title
        alertMessage = message
        showingAlert = true
    }
    
    func deleteModule() {
        appState.modules.remove(at: selectedModuleIndex)
        selectedModuleIndex = 0
        dismiss()
    }
    
    func validateAndUpdateModule() {
        guard moduleCode.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            makeAndShowAlert(withTitle: "Module code is required.", andMessage: "Please enter a valid module code.")
            return
        }
        
        guard moduleName.trimmingCharacters(in: .whitespacesAndNewlines) != "" else {
            makeAndShowAlert(withTitle: "Module name is required.", andMessage: "Please provide a valid module name for this new module.")
            return
        }
        
        for param in addParams.params {
            if param.paramName.trimmingCharacters(in: .whitespacesAndNewlines) == "" || param.paramValue.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
                makeAndShowAlert(withTitle: "Unfulfilled parameter requirements.", andMessage: "One or more additional parameters have not been provided a valid parameter name or value. Please provide one and try again.")
                return
            }
        }
        
        // success case
        var addData: [String: String] = [:]
        for addParam in addParams.params {
            addData[addParam.paramName] = addParam.paramValue
        }
        
        withAnimation {
            if mode == .new {
                appState.modules.append(
                    Module(
                        moduleCode: moduleCode,
                        name: moduleName,
                        tutorName: tutorName == "" ? "NIL": tutorName,
                        tutorNumber: tutorNumber == "" ? "NIL": tutorNumber,
                        addData: addData
                    )
                )
                selectedModuleIndex = appState.modules.count - 1
            } else {
                appState.modules[selectedModuleIndex] = Module(
                    moduleCode: moduleCode,
                    name: moduleName,
                    tutorName: tutorName == "" ? "NIL": tutorName,
                    tutorNumber: tutorNumber == "" ? "NIL": tutorNumber,
                    addData: addData
                )
            }
            
            dismiss()
        }
    }
}

struct NewModule_Previews: PreviewProvider {
    static var previews: some View {
        ManageModuleView(appState: AppState(), selectedModuleIndex: .constant(0), mode: .constant(.new))
    }
}
