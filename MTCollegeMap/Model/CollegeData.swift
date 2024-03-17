//
//  CollegeData.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import Foundation
import CoreLocation

struct CollegeData: Decodable {
    let name: String
    let color: String
    let latitude: CLLocationDegrees
    let longitude: CLLocationDegrees
}
