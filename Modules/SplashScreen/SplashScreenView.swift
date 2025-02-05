//
//  SplashScreenView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 11/01/2025.
//

import SwiftUI

struct SplashScreenView: View {
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
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                    if kUserDefaults.kisGetStarted {
                        setRootViewController(
                            LoginView()
                        )
                    }
                    else {
                        kUserDefaults.kisGetStarted = true
                        setRootViewController(
                            GetStartedView()
                        )
                    }
                }
            }
            
        }
    }
}

#Preview {
    SplashScreenView()
}
