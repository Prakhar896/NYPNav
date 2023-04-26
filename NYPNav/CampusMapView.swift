//
//  CampusMapView.swift
//  NYPNav
//
//  Created by Prakhar Trivedi on 26/4/23.
//

import SwiftUI
import MapKit
import CoreLocationUI

struct CampusMapView: View {
    @StateObject var locationModel = LocationModel()
    
    var body: some View {
        ZStack {
            Map(coordinateRegion: $locationModel.region, interactionModes: [.all], showsUserLocation: true)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .edgesIgnoringSafeArea(.top)
            HStack {
                VStack {
                    Text("Campus Map")
                        .font(.largeTitle.weight(.heavy))
                        .padding([.top, .leading], 15)
                    Spacer()
                }
                Spacer()
                VStack {
                    Spacer()
                    ZStack {
                        RoundedRectangle(cornerRadius: 10)
                            .frame(width: 50, height: 50)
                            .foregroundColor(.white)
                            .opacity(0.7)
                        Button {
                            withAnimation {
                                locationModel.switchToOpposite()
                            }
                        } label: {
                            Image(systemName: locationModel.locationMode == .nyp ? "person.circle.fill": "building.columns.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 30, height: 30)
                        }
                    }
                    .padding(.bottom, 50)
                    .padding(.trailing, 25)
                }
            }
        }
        .onAppear {
            locationModel.requestAuthorisation(always: false)
            locationModel.locationManager.startUpdatingLocation()
        }
    }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        CampusMapView()
    }
}
