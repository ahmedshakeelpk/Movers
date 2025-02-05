//
//  PickLocationMapView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 22/11/2024.
//

import SwiftUI
import GoogleMaps
import GooglePlaces

struct PickLocationMapView: View {
    @Environment(\.dismiss) var myDismiss
    @StateObject var viewModel = PickLocationMapViewModel()

    @State var isForDropOff = false
    
    @State var isLoadView: Bool = false
    
    var didClickOnConfirmPickupHandler: (String, Double, Double) -> Void?

    var body: some View {
        ZStack {
            VStack(spacing: 0) {
                navigationBar
                    .padding(.bottom, 0)
                    .padding(.horizontal, 16)
                VStack {
                    SearchAddressView
                    // Add the GoogleMapView here
                    if isLoadView {
                        googleMapView
                    }
                    Spacer()
                    ButtonConfirmView
                        .padding(.bottom, 16)
                }
            }
            .background(AppColor.colorBackGroundGray)
            .edgesIgnoringSafeArea(.bottom) // Allows map to extend to edges if needed
        }
        .navigationBarHidden(true) // Hide navigation bar here as well
        .onAppear() {
            if !isLoadView {
                isLoadView = true
            }
        }
    }
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Pickup Location", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    
    var googleMapView: some View {
        GoogleMapView(latitude: viewModel.latitude, longitude: viewModel.longitude)
            .cornerRadius(10)
            .padding(.horizontal, 16)
            .edgesIgnoringSafeArea(.all)
    }
    
    var SearchAddressView: some View {
        VStack {
            VStack {
                Button(action: {
                    showAutocomplete()
                }, label: {
                    HStack {
                        Image(.search)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 20, height: 20)
                        TextField("Toronto, Ontario", text: $viewModel.textFieldSearchAddress)
                            .font(.system(size: 14, weight: .regular))
                            .multilineTextAlignment(.leading) // Align text to the left
                        Image(.cross)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 16, height: 16)
                        
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 16)
                })
            }
            .background(.white)
            .cornerRadius(10) // Add corner radius
            .overlay(
                RoundedRectangle(cornerRadius: 10) // Rounded border
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
        }
        .padding(.top, 16)
    }
    
    var AddressView: some View {
        VStack(spacing: 10) {
            HStack(alignment: .top) { // Aligns items to center vertically
                Image(.gpsButton)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)

                Text("Erskine Ave")
                    .font(.system(size: 16, weight: .regular))
                
                Spacer() // Pushes content to the left
            }
            HStack {
                Spacer().frame(width: 32) // Indents the text
                Text("211 Erskine Ave, Toronto, ON M4P 1Z5, Canada 211 Erskine Ave, Toronto, ON M4P 1Z5, Canada")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(AppColor.colorGrayTextColor)
                Spacer()
            }
        }
        .padding(.horizontal, 16)
        .padding(.top, 10)
        .padding(.bottom, 8)
    }

    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            AddressView
            Button(action: {
                // Add your action here
                didClickOnConfirmPickupHandler(viewModel.textFieldSearchAddress, viewModel.latitude, viewModel.longitude)
                myDismiss()
            }) {
                VStack {
                    Text(isForDropOff ? "Confirm Drop-off" : "Confirm Pickup")
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
    
    private func showAutocomplete() {
        let controller = AutocompleteView(selectedAddress: $viewModel.textFieldSearchAddress, latitude: $viewModel.latitude, longitude: $viewModel.longitude)
        // Present the autocomplete view as a sheet
        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
           let window = windowScene.windows.first {
            let rootViewController = window.rootViewController
            let hostingController = UIHostingController(rootView: controller)
            rootViewController?.present(hostingController, animated: true, completion: nil)
        }
    }
}

#Preview {
    PickLocationMapView(didClickOnConfirmPickupHandler: {_,_,_ in })
}

struct GoogleMapView: UIViewRepresentable {
    var latitude: Double
    var longitude: Double
    var mapView = GMSMapView()

    func makeUIView(context: Context) -> GMSMapView {
        return mapView
    }

    func updateUIView(_ uiView: GMSMapView, context: Context) {
        // Update map camera position if needed
        print("latitude: \(latitude)")
        print("longitude: \(longitude)")
        drawMarkerOnMap(uiView)
    }
    
    func drawMarkerOnMap(_ uiView: GMSMapView) {
        let camera = GMSCameraPosition(latitude: latitude, longitude: longitude, zoom: 14.0)
        uiView.animate(to: camera)
        
        // Clear previous markers and add new one
        uiView.clear()
        
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
        marker.title = "Location"
        marker.snippet = "Coordinates: (\(latitude), \(longitude))"
        marker.map = uiView
    }
 
}

struct AutocompleteView: UIViewControllerRepresentable {
    
    class Coordinator: NSObject, GMSAutocompleteViewControllerDelegate {
        func viewController(_ viewController: GMSAutocompleteViewController, didAutocompleteWith place: GMSPlace) {
            parent.selectedAddress = place.formattedAddress ?? "No address available"
            parent.latitude = place.coordinate.latitude
            parent.longitude = place.coordinate.longitude
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the autocomplete view
        }
        
        func viewController(_ viewController: GMSAutocompleteViewController, didFailAutocompleteWithError error: any Error) {
            print("Error: \(error.localizedDescription)")
        }
        
        func wasCancelled(_ viewController: GMSAutocompleteViewController) {
            parent.presentationMode.wrappedValue.dismiss() // Dismiss the autocomplete view
        }
        
        
        var parent: AutocompleteView
        
        init(parent: AutocompleteView) {
            self.parent = parent
        }
    }
    
    @Binding var selectedAddress: String
    @Binding var latitude: Double
    @Binding var longitude: Double
    
    
    @Environment(\.presentationMode) var presentationMode
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
    
    func makeUIViewController(context: Context) -> GMSAutocompleteViewController {
        let autocompleteController = GMSAutocompleteViewController()
        autocompleteController.delegate = context.coordinator
        return autocompleteController
    }
    
    func updateUIViewController(_ uiViewController: GMSAutocompleteViewController, context: Context) {
        // No need to update the view controller as it doesn't change dynamically
    }
}
