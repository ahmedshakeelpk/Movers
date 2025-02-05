//
//  PickLocationMapViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 28/01/2025.
//

import Foundation

class PickLocationMapViewModel: BaseViewModel {
    @Published var navigateToPickLocationMapView: Bool = false

    @Published var latitude: Double = 37.7749
    @Published var longitude: Double = -122.4194
    
    @Published var labelTitleAddress = ""
    @Published var labelAddress = ""
    
    
}
