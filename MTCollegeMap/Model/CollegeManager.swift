//
//  CollegeManager.swift
//  MTCollegeMap
//
//  Created by Kruize Christensen on 3/17/24.
//

import Foundation
import CoreLocation
let apiID = "" //Enter api ID here

protocol CollegeManagerDelegate {
    func didUpdateColleges(_ collegeManager: CollegeManager, colleges: [CollegeData])
    func didFailWithError(error: Error)
}

struct CollegeManager {
    let collegeURL = "https://www.kruizechristensen.com/data/college.json"
    
    var delegate: CollegeManagerDelegate?
    
    func fetchColleges() {
        if let url = URL(string: collegeURL){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let colleges = self.parseJSON(safeData) {
                        self.delegate?.didUpdateColleges(self, colleges: colleges)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ collegeData: Data) -> [CollegeData]? {
        let decoder = JSONDecoder()
        do {
            let colleges = try decoder.decode([CollegeData].self, from: collegeData)
            return colleges
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
}

