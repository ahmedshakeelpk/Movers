//
//  MoversApp.swift
//  Movers
//
//  Created by Shakeel Ahmed on 08/01/2025.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

@main
struct MoversApp: App {
    @StateObject private var loadingState = LoadingState() // Create the instance
    @StateObject private var alertState = AlertState() // Create the alert state

    init() {
        setupApplication()
    }
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                Color.black
                    .edgesIgnoringSafeArea(.all)
                SplashScreenView()
                    .onAppear {
                        kLoadingState = loadingState
                        kAlertState = alertState
                    }
            }
        }
    }
    
    private func setupApplication() {
        GMSServices.provideAPIKey(kGOOGLE_MAP_KEY)
        GMSPlacesClient.provideAPIKey(kGOOGLE_MAP_KEY)

    }
}
