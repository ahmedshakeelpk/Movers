//
//  GlobalFunctions.swift
//  Movers
//
//  Created by Shakeel Ahmed on 10/01/2025.
//

import Foundation
import SwiftUI

//func setRootViewController<T: View>(_ rootView: T) {
//    // Access the main application window
//    guard let window = UIApplication.shared.connectedScenes
//            .compactMap({ $0 as? UIWindowScene })
//            .flatMap({ $0.windows })
//            .first(where: { $0.isKeyWindow }) else {
//        print("Error: Unable to find the key window.")
//        return
//    }
//
//    // Create the NavigationView with the root view and add overlays and environment objects
//    let navigationView = NavigationView {
//        rootView
//            .navigationBarHidden(true) // Hide the navigation bar in SwiftUI view
//    }
//    .overlay(GlobalLoadingView()) // Overlay the loading view globally
//    .environmentObject(kLoadingState) // Inject LoadingState globally
//    .overlay(GlobalAlertView())  // Overlay the alert view globally
//    .environmentObject(kAlertState) // Inject LoadingState globally
//
//    // Create a new UIHostingController for the NavigationView with overlays
//    let hostingController = UIHostingController(rootView: navigationView)
//
//    // Hide the navigation bar
//    hostingController.navigationController?.setNavigationBarHidden(true, animated: false)
//
//    // Perform the transition to the new root view controller
//    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
//        window.rootViewController = hostingController
//    }) { _ in
//        window.makeKeyAndVisible()
//    }
//}


func setRootViewController<T: View>(_ rootView: T) {
    // Access the main application window
    guard let window = UIApplication.shared.connectedScenes
            .compactMap({ $0 as? UIWindowScene })
            .flatMap({ $0.windows })
            .first(where: { $0.isKeyWindow }) else {
        print("Error: Unable to find the key window.")
        return
    }

    // Create the NavigationView with the root view and add overlays and environment objects
    let navigationView = NavigationView {
        rootView
            .navigationBarHidden(true) // Hide the navigation bar in SwiftUI view
            .preferredColorScheme(.light)
    }
    .overlay(GlobalLoadingView()) // Overlay the loading view globally
    .environmentObject(kLoadingState) // Inject LoadingState globally
    .overlay(GlobalAlertView())  // Overlay the alert view globally
    .environmentObject(kAlertState) // Inject LoadingState globally
    

    // Create a new UIHostingController for the NavigationView with overlays
    let hostingController = UIHostingController(rootView: navigationView)

    // Perform the transition to the new root view controller
    UIView.transition(with: window, duration: 0.3, options: .transitionCrossDissolve, animations: {
        window.rootViewController = hostingController

    }) { _ in
        window.makeKeyAndVisible()
    }
}

func showPopup(title: String, message: String, imageIcon: Icons.iconName = .successIcon, completion: @escaping () -> Void) {
    kAlertState.imageIcon = imageIcon
    kAlertState.title = title
    kAlertState.message = message
    kAlertState.isPresented = true
    kAlertState.buttonOkAction = {
        print("ok press")
        completion()
    }
}
