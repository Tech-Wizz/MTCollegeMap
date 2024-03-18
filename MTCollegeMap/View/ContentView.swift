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
    @State private var selectedCollegeIndex = 10

    var body: some View {
        VStack {
            Map(position: $camera) {
                ForEach(collegeManager.colleges, id: \.name) { college in
                    Marker(college.name, systemImage: "graduationcap.fill", coordinate: CLLocationCoordinate2D(latitude: college.latitude, longitude: college.longitude))
                        .tint(Color(red: college.mainColor[0], green: college.mainColor[1], blue: college.mainColor[2]))
                }
            }
            .onAppear {
                collegeManager.fetchColleges()
            }
            
            Picker("Select Location", selection: Binding(
                get: { selectedCollegeIndex },
                set: { newIndex in
                    selectedCollegeIndex = newIndex
                    if newIndex == 0 {
                        // Reset the camera to its default position
                        camera = .automatic
                    } else {
                        let selectedCollege = collegeManager.colleges[newIndex - 1] // Adjust index to skip "All"
                        updateCamera(lat: selectedCollege.latitude, lon: selectedCollege.longitude)
                    }
                }
            )) {
                Text("All").tag(0) // Tag "All" with index 0
                ForEach(collegeManager.colleges.indices, id: \.self) { index in
                    let college = collegeManager.colleges[index]
                    Text(college.name).tag(index + 1) // Adjust index to skip "All"
                }
            }

            .pickerStyle(WheelPickerStyle())
            .frame(height: 50) // Set the desired height for the picker
            .padding()
        }
        .safeAreaInset(edge: .bottom) {
            Spacer()
                .frame(height: 40) // Adjust spacing for better alignment
                .background(Color(.systemBackground))
        }
        .mapStyle(.standard)
    }
    
     func updateCamera(lat: Double, lon: Double) {
            camera = .region(
                MKCoordinateRegion(
                    center: CLLocationCoordinate2D(latitude: lat, longitude: lon),
                    latitudinalMeters: 200, // Adjust the desired zoom level
                    longitudinalMeters: 200 // Adjust the desired zoom level
                )
            )
        }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
