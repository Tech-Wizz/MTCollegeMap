//
//  ContentView.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import SwiftUI
import MapKit

struct ContentView: View {
    @StateObject private var collegeManager = CollegeManager()
    @State private var camera: MapCameraPosition = .automatic
    
    private let capital = CLLocationCoordinate2D(latitude: 46.595805, longitude: -112.027031)
    private let collegeLocation = CLLocationCoordinate2D(latitude: 46.6008333, longitude: -112.0386111)

    var body: some View {
        Map(position: $camera) {
            ForEach(collegeManager.colleges, id: \.name) { college in
                
                Marker(college.name, systemImage: "graduationcap.fill", coordinate: CLLocationCoordinate2D(latitude: college.latitude, longitude: college.longitude))
                    .tint(Color(red: college.mainColor[0], green: college.mainColor[1], blue: college.mainColor[2]))
            }
        }
        .onAppear {
            collegeManager.fetchColleges()
        }
        .safeAreaInset(edge: .bottom) {
            HStack {
                Button {
                    camera = .region(
                        MKCoordinateRegion(
                            center: capital,
                            latitudinalMeters: 200,
                            longitudinalMeters: 200))
                } label: {
                    Text("Capital")
                }
                Button {
                    camera = .region(
                        MKCoordinateRegion(
                            center: collegeLocation,
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
        .mapStyle(.standard)
    }
}


#Preview {
    ContentView()
}
