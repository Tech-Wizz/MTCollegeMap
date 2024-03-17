//
//  ContentView.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    
    let capital = CLLocationCoordinate2D(latitude: 46.595805, longitude: -112.027031)
    
    let cathedral = CLLocationCoordinate2D(latitude: 46.5901472, longitude: -112.0325417)
    
    let college = CLLocationCoordinate2D(latitude: 46.6008333, longitude: -112.0386111)
    
    @State var camera: MapCameraPosition = .automatic
    
    var body: some View {
        Map(position: $camera) {
            Marker("Montana State Capital", systemImage: "building.columns", coordinate: capital)
                .tint(.blue)
            Marker("Carroll Colege", systemImage: "graduationcap", coordinate: college)
                .tint(.purple)
            Annotation("Cathedral", coordinate: cathedral) {
                Image(systemName: "book.closed")
                    .foregroundStyle(.white)
                    .padding()
                    .background(.orange)
            }

        }
        .safeAreaInset(edge: .bottom) {
            HStack{
                Button{
                    camera = .region(
                        MKCoordinateRegion(
                            center: capital,
                            latitudinalMeters: 200,
                            longitudinalMeters: 200))
                } label: {
                    Text("Capital")
                }
                Button{
                    camera = .region(
                        MKCoordinateRegion(
                            center: college,
                            latitudinalMeters: 200,
                            longitudinalMeters: 200))
                } label: {
                    Text("College")
                }
                Spacer()
            }
            .padding(.top)
            .background(.thinMaterial)
        }
        .mapStyle(.imagery)
    }
}

#Preview {
    ContentView()
}
