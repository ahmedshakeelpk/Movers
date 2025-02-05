//
//  DropOffLocationModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 01/02/2025.
//

import Foundation

extension DropOffLocationViewModel {
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
    
    
    // MARK: - DataClass
    struct ModelPricingResponse: Codable {
        let prices: [ModelPriceData]
    }

    // MARK: - Price
    struct ModelPriceData: Codable {
        let cost, noOfBeds: Int?
        let moversPrice: String?
        let propertyTypes: [PropertyType]
        let serviceID: Int
        let travelTimeMinuteCost: String
        let truckSize: Int
        let truckPrice: String?
        let noOfMovers: Int

        enum CodingKeys: String, CodingKey {
            case cost
            case noOfBeds = "no_of_beds"
            case moversPrice = "movers_price"
            case propertyTypes = "property_types"
            case serviceID = "service_id"
            case travelTimeMinuteCost = "travel_time_minute_cost"
            case truckSize = "truck_size"
            case truckPrice = "truck_price"
            case noOfMovers = "no_of_movers"
        }
    }

    // MARK: - PropertyType
    struct PropertyType: Codable {
        let parentID: Int?
        let id: Int
        let name: String
        let pivot: ModelPivotData

        enum CodingKeys: String, CodingKey {
            case parentID = "parent_id"
            case id, name, pivot
        }
    }

    // MARK: - Pivot
    struct ModelPivotData: Codable {
        let priceID, propertyTypeID: Int

        enum CodingKeys: String, CodingKey {
            case priceID = "price_id"
            case propertyTypeID = "property_type_id"
        }
    }
}
