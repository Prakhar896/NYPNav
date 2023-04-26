//
//  PortalView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI

struct CustomWebView: View {
    var link: EServiceLink
    
    var body: some View {
        SFSafariViewWrapper(url: URL(string: link.url) ?? URL(string: "https://google.com")!)
            .navigationTitle(link.name)
            .navigationBarTitleDisplayMode(.inline)
    }
}

struct PortalView: View {
    @EnvironmentObject var appState: AppState
    
    @State var showingNewLinkAlert = false
    @State var newLinkName = ""
    @State var newLinkURL = ""
    
    var body: some View {
        NavigationView {
            List {
                ForEach(appState.eServiceLinks) { link in
                    NavigationLink(link.name) {
                        CustomWebView(link: link)
                    }
                }
                .onDelete(perform: removeLinks)
            }
            .navigationTitle("E-Services")
            .alert("New Link", isPresented: $showingNewLinkAlert) {
                TextField("Enter link name", text: $newLinkName)
                TextField("Enter link URL (with HTTP/HTTPS)", text: $newLinkURL)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .keyboardType(.URL)
                
                Button("Cancel", role: .cancel) {}
                Button("Add") {
                    withAnimation {
                        appState.eServiceLinks.append(EServiceLink(name: newLinkName, url: newLinkURL))
                    }
                    newLinkName = ""
                    newLinkURL = ""
                }
            } message: {
                Text("Please enter the name and URL (with HTTP/HTTPS) of the link you'd like to add.")
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        showingNewLinkAlert = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
            }
        }
    }
    
    func removeLinks(at offsets: IndexSet) {
        appState.eServiceLinks.remove(atOffsets: offsets)
    }
}

struct PortalView_Previews: PreviewProvider {
    static var previews: some View {
        PortalView()
    }
}
