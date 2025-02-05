//
//  MovingNPickingModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 28/01/2025.
//

import Foundation

extension MovingNPickingViewModel {
    // MARK: - DataClass
    struct ModelResponsePropertyTypes: Codable {
        let propertyTypes: [ModelResponsePropertyTypesData]?
    }
    struct ModelResponsePropertyTypesData: Codable {
        let id: Int?
        let name: String?
        let children: [PropertyTypesChildData]
    }

    // MARK: - Child
    struct PropertyTypesChildData: Codable {
        let id: Int
        let name: String
        let parentID: Int

        enum CodingKeys: String, CodingKey {
            case id, name
            case parentID = "parent_id"
        }
    }
}
