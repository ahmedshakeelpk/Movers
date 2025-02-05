//
//  ConfirmOrderView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 27/11/2024.
//

import SwiftUI

struct ConfirmOrderView: View {
    @StateObject var viewModel = ConfirmOrderViewModel()
    @Environment(\.dismiss) var myDismiss

    var navigationBar: some View {
        NavigationBarView(titleName: "Confirm Order", leftIconName: "backButton", isLeftButtonClick: {
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
                    DateTimeView
                    ServiceJourneyView
                    AdditionalInformationView
                    Spacer()
                }
                ButtonConfirmView
            }
            .background(AppColor.colorBackGroundGray)
            if viewModel.presentToPaymentMethodBottomSheet {
                PaymentMethodBottomSheet(isPresented: $viewModel.presentToPaymentMethodBottomSheet) { index in
                    print(index)
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewModel.navigateToPaymentGatewayView = true
                        }
                    }
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
            NavigationLink(
                destination: PaymentGatewayView(),
                isActive: $viewModel.navigateToPaymentGatewayView,
                label: { EmptyView() }
            )
        }
        .onAppear() {
            
        }
        .background(
            VStack {
                Color(UIColor.systemGroupedBackground)
            }
        )
        .navigationBarHidden(true) // Hide navigation bar here as well
    }
    
    var DateTimeView: some View {
        VStack(alignment: .leading) {
            Text("Service Time")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                HStack {
                    Text("Thursday, March 27 @ 03:00 PM")
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
    
    var ServiceJourneyView: some View {
        VStack(alignment: .leading) {
            HStack {
                Text("Service Journey")
                    .font(.system(size: 16, weight: .medium))
                    .padding(.horizontal, 16)
                    .padding(.top, 8)
                Spacer()
            }
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 5) {
                    ForEach(Array(viewModel.numberOfAddresses.enumerated()), id: \.element) { index, address in
                        AddressLine(index: index, address: address)
                        if index != viewModel.numberOfAddresses.count - 1 {
                            //last index
                            EmptyLine
                        }
                    }
                }
                .padding(.vertical, 25)
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
    
    func AddressLine(index: Int, address: String) -> some View {
        HStack {
            VStack(alignment: .center) {
                if index == 0 || index == viewModel.numberOfAddresses.count - 1 {
                    Image(.blackBox)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                }
                else {
                    Image(.blackCircle)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 14, height: 14)
                }
                
            }
            .frame(width: 20)
            VStack(alignment: .leading) {
                Text(address)
                    .font(.system(size: 14, weight: .regular))
            }
        }
        .padding(.horizontal, 20)
    }
    var EmptyLine: some View {
        HStack {
            VStack(alignment: .center) {
                Divider()
                    .frame(width: 2, height: 35)
                    .background(Color.black)
            }
            .frame(width: 20)
        }
        .padding(.horizontal, 20)
    }
    
    var AdditionalInformationView: some View {
        VStack(alignment: .leading) {
            Text("Additional Information")
                .font(.system(size: 16, weight: .medium))
                .padding(.horizontal, 16)
                .padding(.top, 8)
            VStack(alignment: .leading) {
                VStack(alignment: .leading, spacing: 20) {
                    HStack {
                        Image(.tick)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("Property Type: ")
                            .font(.system(size: 14, weight: .regular))
                        Text("Apartment")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Image(.tick)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("Unit Number: ")
                            .font(.system(size: 14, weight: .regular))
                        Text("3")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Image(.tick)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("No. of Bedrooms: ")
                            .font(.system(size: 14, weight: .regular))
                        Text("(3)")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Image(.tick)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("Elevator: ")
                            .font(.system(size: 14, weight: .regular))
                        Text("(Yes)")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                    HStack {
                        Image(.tick)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("Heavy Items: ")
                            .font(.system(size: 14, weight: .regular))
                        Text("(3)")
                            .font(.system(size: 14, weight: .bold))
                        Spacer()
                    }
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 25)
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
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            AddressView
            Button(action: {
                // Add your action here
                viewModel.presentToPaymentMethodBottomSheet = true
            }) {
                VStack {
                    Text("Proceed to Payment")
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
    var AddressView: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top) { // Aligns items to center vertically
                Text("Total Amount:")
                    .font(.system(size: 16, weight: .regular))
                Spacer()
                Text("$\(viewModel.getRandomNumber())")
                    .font(.system(size: 22, weight: .bold))
                Image(.infoIcon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 22, height: 22)

            }
            .onTapGesture {
                
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
        .padding(.bottom, 4)
    }
}

#Preview {
    ConfirmOrderView()
}
