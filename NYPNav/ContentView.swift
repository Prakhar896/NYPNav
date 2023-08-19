//
//  ContentView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var appState: AppState
    
    @State var selectedModuleIndex: Int = 0
    
    // Sheets and alerts
    @State var manageModuleMode: ManageModuleMode = .new
    @State var showingManageModuleSheet = false
    @State var showingResetAlert = false
    @State var showingIntroSheet = false
    
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
                ManageModuleView(selectedModuleIndex: $selectedModuleIndex, mode: $manageModuleMode)
            }
            .fullScreenCover(isPresented: $showingIntroSheet) {
                IntroView()
            }
            .alert("Reset Everything?", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset With Built-in Modules", role: .destructive) {
                    appState.modules = DefaultModules.load()
                    appState.eServiceLinks = EServiceLink.loadDefaultLinks()
                    UserDefaults.standard.set(false, forKey: UserDefaults.getKeyString(forKey: .launchedBefore))
                    UserDefaults.standard.synchronize()
                    exit(0)
                }
                Button("Complete Reset", role: .destructive) {
                    appState.modules = [DefaultModules.blankModule]
                    appState.eServiceLinks = EServiceLink.loadDefaultLinks()
                    UserDefaults.standard.set(false, forKey: UserDefaults.getKeyString(forKey: .launchedBefore))
                    UserDefaults.standard.synchronize()
                    exit(0)
                }
            } message: {
                Text("You can choose to either reset the app and load built-in modules in the app or load none at all (complete reset).\n\nAll changes made will be lost and only default data will be left. This action is irreversible. The app will quit to apply changes.")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button {
                        showingResetAlert = true
                    } label: {
                        Text("Reset")
                    }
                }
                
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        manageModuleMode = .new
                        showingManageModuleSheet = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
            .onAppear(perform: checkIfFirstLaunch)
        }
    }
    
    func checkIfFirstLaunch() {
        let launchedBefore = UserDefaults.standard.bool(forKey: UserDefaults.getKeyString(forKey: .launchedBefore))
        if !launchedBefore {
            showingIntroSheet = true
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(AppState())
    }
}
