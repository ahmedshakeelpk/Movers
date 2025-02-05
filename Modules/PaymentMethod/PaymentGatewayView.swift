//
//  PaymentsGatewayView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 27/11/2024.
//

import SwiftUI

struct PaymentGatewayView: View {
    @Environment(\.dismiss) var myDismiss
    
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Payment Getaway", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    var body: some View {
        ZStack {
            // Main Content
            VStack {
                navigationBar
                    .padding(.horizontal, 16)
                ScrollView {
                    NameOnCardView
                    CardNoView
                    CVVAndExpirtyView
                    Spacer()
                }
                ButtonConfirmView
            }
            .background(AppColor.colorBackGroundGray)
        }
        .background(
            VStack {
                Color(UIColor.systemGroupedBackground)
            }
        )
        .navigationBarHidden(true) // Hide navigation bar here as well
    }
    
    var NameOnCardView: some View {
        VStack(alignment: .leading) {
            Text("Name on card")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                HStack {
                    Text("Olivia Rhye")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
        }
    }
    var CardNoView: some View {
        VStack(alignment: .leading) {
            Text("Name on card")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                HStack {
                    Image(.blackBox)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                    Text("1234 1234 1234 1234")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
        }
    }
    
    var CVVAndExpirtyView: some View {
        HStack(spacing: 8) {
            CVVView
            ExpiryView
        }
        .padding(.horizontal, 16)
    }
    
    var CVVView: some View {
        VStack(alignment: .leading) {
            Text("CVV")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                HStack {
                    Text("1234")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
        }
    }
    
    var ExpiryView: some View {
        VStack(alignment: .leading) {
            Text("Expiry")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                HStack {
                    Text("06 / 2024")
                        .font(.system(size: 14, weight: .regular))
                    Spacer()
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 20)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
        }
    }
    
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            
            Button(action: {
                // Add your action here
                showPopup(title: "Success", message: "Thank you for placing your order. Our administration will contact you shortly.") {
                    setRootViewController(HomeTabBarView())
                }
            }) {
                VStack {
                    Text("Make Payment")
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
        }
        .background(.white)
    }
}
#Preview {
    PaymentGatewayView()
}
