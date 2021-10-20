//
//  AnimalDataModel.swift
//  LazyLoading
//
//  Created by Justin Bell on 10/20/21.
//

import Foundation

struct AnimalDataModel : Codable {
    let errorMessage : String
    let animals:[Animal]
    
    enum CodingKeys : String, CodingKey {
        case animals = "data"
        case errorMessage 
    }
}

struct Animal : Codable {
    let name : String
    let image : String
}
