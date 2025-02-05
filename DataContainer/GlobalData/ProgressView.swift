//
//  ProgressView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 10/01/2025.
//

import SwiftUI

struct GlobalLoadingView: View {
    @EnvironmentObject var loadingState: LoadingState
    
    var body: some View {
        ZStack {
            if loadingState.isLoading {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                
                ProgressView("Loading...")
                    .progressViewStyle(CircularProgressViewStyle(tint: .white))
                    .scaleEffect(1.5)
                    .foregroundColor(.white)
            }
        }
        .animation(.easeInOut, value: loadingState.isLoading) // Smoothly animate visibility
    }
}
class LoadingState: ObservableObject {
    @Published var isLoading: Bool = false
}
