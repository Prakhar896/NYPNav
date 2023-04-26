//
//  ContentView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
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

struct ContentView: View {
    @StateObject var appState: AppState = AppState()
    
    @State var selectedModuleIndex: Int = 0
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Module:")
                        Spacer()
                        Picker("Select a module", selection: $selectedModuleIndex.animation()) {
                            ForEach(0..<appState.modules.count) { moduleIndex in
                                Text(appState.modules[moduleIndex].completeModName)
                            }
                        }
                        .labelsHidden()
                    }
                    .frame(height: 80)
                }
                
                if selectedModuleIndex != 0 {
                    Section {
                        ParameterView(parameter: "Module Code:", value: appState.modules[selectedModuleIndex].moduleCode)
                        ParameterView(parameter: "Name:", value: appState.modules[selectedModuleIndex].name)
                        ParameterView(parameter: "Tutor Name:", value: appState.modules[selectedModuleIndex].tutorName)
                        ParameterView(parameter: "Tutor Number:", value: appState.modules[selectedModuleIndex].tutorNumber)
                    } header: {
                        Text("Module Info")
                    }
                    
                    if appState.modules[selectedModuleIndex].addData.count != 0 {
                        Section {
                            ForEach(Array(appState.modules[selectedModuleIndex].addData.keys), id: \.self) { key in
                                ParameterView(parameter: key, value: appState.modules[selectedModuleIndex].addData[key] ?? "No value")
                            }
                        } header: {
                            Text("Additional Module Info")
                        }
                    }
                }
            }
            .navigationTitle("NYPNav")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
