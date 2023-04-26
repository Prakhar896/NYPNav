//
//  EditModule.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI

struct EditModule: View {
    @ObservedObject var appState: AppState
    @Binding var selectedModuleIndex: Int
    
    var body: some View {
        NavigationView {
            Text("Hello there!")
                .navigationTitle("Edit \(appState.modules[selectedModuleIndex].moduleCode)")
        }
    }
}

struct EditModule_Previews: PreviewProvider {
    static var previews: some View {
        EditModule(appState: AppState(), selectedModuleIndex: .constant(0))
    }
}
