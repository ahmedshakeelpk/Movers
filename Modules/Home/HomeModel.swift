//
//  HomeModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 24/01/2025.
//


extension HomeViewModel {
    // MARK: - DataClass
    struct ModelResponseServices: Codable {
        let services: [ModelResponseServicesData]?
    }
    
    struct ModelResponseServicesData: Codable {
        let id: Int?
        let name: String?
        let desc: String?
    }
}
