//
//  PortalView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI

struct PortalView: View {
    @State var showingPortal = false
    
    var body: some View {
//        Button("Background") {
//            showingPortal.toggle()
//        }
//        .fullScreenCover(isPresented: $showingPortal) {
//            SFSafariViewWrapper(url: URL(string: "https://prakhartrivedi.works")!)
//        }
        SFSafariViewWrapper(url: URL(string: "https://prakhartrivedi.works")!)
    }
}

struct PortalView_Previews: PreviewProvider {
    static var previews: some View {
        PortalView()
    }
}
