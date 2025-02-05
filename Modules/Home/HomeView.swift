//
//  HomeView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 20/11/2024.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject var viewModel = HomeViewModel()

    var body: some View {
        ZStack {
            VStack {
                ScrollView {
                    NavigationView
                        .padding(.vertical, 20)
                    MovingAndPickingView
                    DeliveryView
                        .padding(.vertical, 12)
                    RentATruckAndMoverView
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
            .background(AppColor.colorExtraLightGray)
            if viewModel.isPresentToServiceSelectionBottomSheetView {
                ServiceSelectionBottomSheetView(isPresented: $viewModel.isPresentToServiceSelectionBottomSheetView, modelResponseServices: viewModel.modelResponseServices) { index in
                    print(index)
                    viewModel.selectedService = viewModel.modelResponseServices?.services?[index]
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                        withAnimation {
                            viewModel.navigateToMovingNPickingView = true
                        }
                    }
                }
                .transition(.move(edge: .bottom))
                .zIndex(1)
            }
            NavigationLink(
                destination: MovingNPickingView(selectedService: viewModel.selectedService),
                isActive: $viewModel.navigateToMovingNPickingView,
                label: { EmptyView() }
            )
        }
    }
    
    var NavigationView: some View {
        VStack {
            HStack {
                Text("Hello, \(kUserData?.name ?? "") !")
                    .font(.system(size: 24, weight: .bold))
                    .multilineTextAlignment(.leading)
                Spacer()
                Image(.notification)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 18, height: 18)
            }
            Spacer().frame(height: 12)
            HStack {
                Text("Pickup the available service from below")
                    .font(.system(size: 14, weight: .regular))
                    .multilineTextAlignment(.leading)
                Spacer()
            }
            
        }
    }
    
    var MovingAndPickingView: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Moving & Picking")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Book the robust movers and a truck to transport all your selected belongings to your new location.")
                            .font(.system(size: 14, weight: .thin))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                VStack {
                    Image(.pickupHomeIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 22)
        }
        .background(.white)
        .cornerRadius(10) // Add corner radius
        // Add some padding inside the border
        .overlay(
            RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                .stroke(AppColor.colorBorder, lineWidth: 1)
        )
        .onTapGesture {
            viewModel.isPresentToServiceSelectionBottomSheetView = true
        }
    }
    
    var DeliveryView: some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        Text("Delivery")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Manage the delivery of additional items that you cannot accommodate in your vehicle.")
                            .font(.system(size: 14, weight: .thin))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                }
                VStack {
                    Image(.deliveryHomeIcon)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 100, height: 100)
                }
            }
            .padding(.horizontal, 16)
            .padding(.vertical, 22)
        }
        .background(.white)
        .cornerRadius(10) // Add corner radius
        // Add some padding inside the border
        .overlay(
            RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                .stroke(AppColor.colorBorder, lineWidth: 1)
        )
    }
    
    var RentATruckAndMoverView: some View {
        HStack {
            VStack {
                VStack {
                    HStack {
                        Text("Rent-a-Truck")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Instantly secure the ideal truck for a hassle-free relocation experience.")
                            .font(.system(size: 14, weight: .thin))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    VStack {
                        Image(.rentATruckHomeIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(height: 60)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 22)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            // Add some padding inside the border
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            VStack {
                VStack {
                    HStack {
                        Text("Rent-a-Movers")
                            .font(.system(size: 18, weight: .bold))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    Spacer().frame(height: 8)
                    HStack {
                        Text("Instantly secure the ideal truck for a hassle-free relocation experience.")
                            .font(.system(size: 14, weight: .thin))
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    VStack {
                        Image(.rentAMoverHomeIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        
                    }
                    .frame(height: 60)
                    .padding(.top, 8)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 22)
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            // Add some padding inside the border
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Use `Rectangle()` for sharp corners
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
        }
    }
}

#Preview {
    HomeView()
}

