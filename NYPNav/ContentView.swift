//
//  ContentView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState: AppState = AppState()
    
    @State var selectedModuleIndex: Int = 0
    
    // Sheets and alerts
    @State var manageModuleMode: ManageModuleMode = .new
    @State var showingManageModuleSheet = false
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Module:")
                        Spacer()
                        Picker("Select a module", selection: $selectedModuleIndex.animation()) {
                            ForEach(0..<appState.modules.count, id: \.self) { moduleIndex in
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
                        HStack {
                            Text("Module Info")
                            Spacer()
                            Button {
                                manageModuleMode = .edit
                                showingManageModuleSheet = true
                            } label: {
                                Image(systemName: "square.and.pencil")
                            }
                        }
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
            .sheet(isPresented: $showingManageModuleSheet) {
                ManageModuleView(appState: appState, selectedModuleIndex: $selectedModuleIndex, mode: $manageModuleMode)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        manageModuleMode = .new
                        showingManageModuleSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
