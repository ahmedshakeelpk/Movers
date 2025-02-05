//
//  GetStartedView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 02/02/2025.
//

import SwiftUI

struct GetStartedView: View {
    let locationManager = LocationManager()
    var body: some View {
        ZStack {
            Color.black
                .edgesIgnoringSafeArea(.all) // Ensure the color covers the whole screen
            VStack {
                Spacer()
                Text("Movers")
                    .foregroundColor(.white) // Text in a contrasting color
                    .font(.largeTitle)
                Spacer()
                ButtonContinueView
            }
            .onAppear() {
                locationManager.requestLocationPermission()
            }
        }
    }
    
    var ButtonContinueView: some View {
        VStack {
            DashLineWithShadowView
            HStack {
                Text("Get Started")
                    .foregroundColor(.black) // Text in a contrasting color
                    .font(.system(size: 30, weight: .bold))
                    .padding(.leading, 20)
                    .padding(.top, 10)
                    .padding(.bottom, 20)
                Spacer()

            }
            Button(action: {
                setRootViewController(
                    LoginView()
                )
            }) {
                VStack {
                    HStack {
                        Spacer()
                        Text("Continue")
                            .font(.system(size: 14, weight: .bold))
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 5)
                        Spacer()
                        Image(.forwardArrow)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                    }
                }
                .frame(maxWidth: .infinity) // Ensure the button takes full width
                .padding() // Add padding inside the button
                .background(AppColor.colorBlack)
                .cornerRadius(10) // Add corner radius
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Rounded border
                        .stroke(AppColor.colorBorder, lineWidth: 1)
                )
            }
            .buttonStyle(PlainButtonStyle())
            .frame(height: 45)
            .padding(.horizontal, 16)
            .padding(.vertical, 12)
            .padding(.bottom, 20)
        }
        .background(.white)
    }
}

#Preview {
    GetStartedView()
}


import SwiftUI
import CoreLocation

class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private var locationManager = CLLocationManager()
    
    override init() {
        super.init()
        locationManager.delegate = self
    }
    
    func requestLocationPermission() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    // Optional: Handle updates or errors if needed
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            print("Location access granted")
        case .denied, .restricted:
            print("Location access denied")
        default:
            break
        }
    }
}
