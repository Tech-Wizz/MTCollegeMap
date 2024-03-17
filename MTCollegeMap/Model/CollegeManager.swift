//
//  CollegeManager.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import Foundation
import Combine

class CollegeManager: ObservableObject {
    let collegeURL = Bundle.main.url(forResource: "college", withExtension: "json")!
    
    @Published var colleges: [CollegeData] = []
    @Published var error: Error?
    
    func fetchColleges() {
        do {
            let collegeData = try Data(contentsOf: collegeURL)
            let decoder = JSONDecoder()
            let decodedData = try decoder.decode([String: [CollegeData]].self, from: collegeData)
            self.colleges = decodedData["colleges"] ?? []
        } catch {
            self.error = error
            print("Error decoding JSON:", error)
        }
    }
}
