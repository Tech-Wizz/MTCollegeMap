//
//  CollegeData.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import Foundation

struct CollegeData: Codable {
    let name: String
    let acronym: String
    let city: String
    let latitude: Double
    let longitude: Double
    let foundedYear: Int
    let numberOfStudents: Int
    let mascot: String
    let mainColor: [Double]
    let division: String
    let degrees: [Degree]
    
    struct Degree: Codable {
        let name: String
        let category: String
        let yearsToComplete: Int
    }
}

