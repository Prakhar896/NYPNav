//
//  RootView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI

struct RootView: View {    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Modules", systemImage: "list.bullet")
                }
            
            PortalView()
                .tabItem {
                    Label("E-Services", systemImage: "display")
                }
            
            CampusMapView()
                .tabItem {
                    Label("Campus Map", systemImage: "map")
                }
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView()
    }
}
