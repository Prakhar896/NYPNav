//
//  IntroView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 30/4/23.
//

import SwiftUI

struct IntroView: View {
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                Image(systemName: "info.circle")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 70, height: 70)
                    .foregroundColor(.blue)
                    .padding()
                    .background(.ultraThinMaterial)
                    .cornerRadius(10)
                    .padding(.top, 30)
                
                Text("NYPNav")
                    .font(.largeTitle.weight(.black))
            }
            
            VStack {
                Text("Welcome to NYPNav!")
                    .font(.headline)
                Text("This app aims to help you, an an NYP student, navigate your daily life on- and off-campus easier.\n\n")
                Text("From translating cryptic module codes to detailed module information into guiding you through your way around the large campus, this app is your all-in-one go-to app for all your NYP related needs.\n")
                Text("This app was developed by me, Prakhar Trivedi, in 2023 for myself! Drop by @Prakhar896 on GitHub if you have time.\n\nHope you have a great experience!\n")
                
                Button {
                    UserDefaults.standard.set(true, forKey: UserDefaults.getKeyString(forKey: .launchedBefore))
                    dismiss()
                } label: {
                    Text("Jump In!")
                        .font(.title2.weight(.heavy))
                        .padding(.vertical, 15)
                        .padding(.horizontal, UIScreen.main.bounds.width * 0.3)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
            }
            .padding(.top, 50)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
        }
    }
}

struct IntroView_Previews: PreviewProvider {
    static var previews: some View {
        IntroView()
    }
}
