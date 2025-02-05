//
//  GlobalAlertView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 10/01/2025.
//

import SwiftUI


class AlertState: ObservableObject {
    @Published var isPresented: Bool = false
    @Published var title: String = ""
    @Published var message: String = ""
    @Published var imageIcon: Icons.iconName = .errorIcon
    var buttonOkAction: (() -> Void)? = nil
}

struct GlobalAlertView: View {
    @EnvironmentObject var alertState: AlertState

    var body: some View {
        ZStack {
            if alertState.isPresented {
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    VStack(spacing: 20) {
                        Image(alertState.imageIcon.rawValue)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 80, height: 80)
                            .padding(.top,30)
                        Text(alertState.title)
                            .font(.headline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        Text(alertState.message)
                            .font(.subheadline)
                            .foregroundColor(.black)
                            .padding(.horizontal, 20)
                        Button(action: {
                            alertState.isPresented = false
                            alertState.buttonOkAction?()
                        }) {
                            VStack {
                                Text("Okay")
                                    .font(.system(size: 16, weight: .bold))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(.white)
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
                    .frame(width: 300)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(radius: 10)
                }
            }
        }
    }
}
