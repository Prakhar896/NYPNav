//
//  ContentView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 23/4/23.
//

import SwiftUI

struct ContentView: View {
    @StateObject var appState: AppState = AppState()
    
//    @State var selectedModule: Module = DefaultModules.
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    HStack {
                        Text("Module:")
//                        Picker("Select a module", selection: <#T##Binding<_>#>, content: <#T##() -> _#>)
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
