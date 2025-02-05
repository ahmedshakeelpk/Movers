//
//  DeliveryView.swift
//   Movers
//
//  Created by Shakeel Ahmed on 26/11/2024.
//

import SwiftUI


struct DeliveryView: View {
    @Environment(\.dismiss) var myDismiss
    @State var textFieldHomeAddress = ""
    @State private var arrayNumberOfStops: [Int] = [0] // Initial array with a single stop
    
    @State private var showPicker = false // Controls picker visibility
    @State private var selectedOption = "Select Property Type"
    @State private var propertyViewOffset: CGFloat = 0 // To store the vertical offset of PropertyView
    @State private var viewHeight: CGFloat = 0 // To store the vertical offset of PropertyView

    
    var navigationBar: some View {
        NavigationBarView(titleName: "Moving & Packing", leftIconName: "backButton", isLeftButtonClick: {
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
                    SelectDropOffView
                    PropertyView
                    Spacer()
                }
                ButtonConfirmView
            }
            .background(AppColor.colorBackGroundGray)
            
            // Dropdown Picker
            if showPicker {
                VStack {
                    DropdownPickerView(
                        showPicker: $showPicker,
                        selectedOption: $selectedOption
                        , 
                        arrayOptions: ["test1", "test2", "test3"],
                        didSelectRowHandler: { index in
                            
                        }
                    )
                    .frame(height: 300) // Set desired height for the dropdown
                    .background(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                    .padding(.horizontal, 16)
                    .offset(y: propertyViewOffset) // Adjust position vertically if needed
                    Spacer()
                }
            }
        }
        .onTapGesture {
            if showPicker {
                withAnimation {
                    showPicker = false
                }
            }
        }
        .background(
            VStack {
                Color(UIColor.systemGroupedBackground)
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            viewHeight = geometry.frame(in: .global).maxY
                            print(viewHeight)
                        }
                        .onChange(of: geometry.frame(in: .global)) { newFrame in
                            viewHeight = newFrame.maxY
                            print(viewHeight)
                        }
                }
            }
        )
    }
    
    var SelectDropOffView: some View {
        VStack {
            HStack {
                Text("Drop-off Location")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColor.colorTextBlack)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 12)
                    .padding(.bottom, 0)
                    .padding(.horizontal, 16)
                Spacer()
            }
            ForEach(arrayNumberOfStops.indices, id: \.self) { index in
                TextFieldSelectPickUpView(index: index)
            }
            
            DashLineView
                .padding(.top, 8)
        }
    }
    
    func TextFieldSelectPickUpView(index: Int) -> some View {
        VStack {
            HStack {
                VStack {
                    HStack {
                        HStack {
                            Image(.navigationIcon)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                            
                            TextField(
                                index == 0 ? "Select Pickup" : "Stop \(index)"
                                ,text: $textFieldHomeAddress)
                            .frame(height: 30)
                            .font(.system(size: 14, weight: .regular))
                        }
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                    }
                }
                .background(.white)
                .cornerRadius(10) // Add corner radius
                .overlay(
                    RoundedRectangle(cornerRadius: 10) // Rounded border
                        .stroke(AppColor.colorBorder, lineWidth: 1)
                )
                if index > 0 {
                    Button(action: {
                        guard arrayNumberOfStops.count > 0 else { return }
                        arrayNumberOfStops.remove(at: index)
                    }, label: {
                        HStack {
                            Spacer()
                            Image(.cross2)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 12)
                        }
                        .frame(width: 30)
                    })
                    .buttonStyle(PlainButtonStyle())
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    var PropertyView: some View {
        VStack {
            HStack {
                Text("Property")
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(AppColor.colorTextBlack)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 16)
                    .padding(.horizontal, 16)
                Spacer()
            }
            .background(
                GeometryReader { geometry in
                    Color.clear
                        .onAppear {
                            propertyViewOffset = geometry.frame(in: .global).maxY
                            print(propertyViewOffset)
                        }
                        .onChange(of: geometry.frame(in: .global)) { newFrame in
                            propertyViewOffset = newFrame.maxY
                            print(propertyViewOffset)
                        }
                }
            )
            VStack {
                HStack {
                    Text(selectedOption)
                        .frame(height: 30)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(selectedOption == "Select Property Type" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 16, height: 16)
                        .foregroundColor(.gray)
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 9)
            }
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(AppColor.colorBorder, lineWidth: 1)
            )
            .padding(.horizontal, 16)
            .onTapGesture {
                withAnimation {
                    showPicker.toggle()
                    print("Total Height: \(viewHeight)")
                    print("DropDown Height: \(propertyViewOffset)")
                    print("Remeaning Height: \(viewHeight-propertyViewOffset)")
                }
            }
            if selectedOption == "Apartment" {
                ApartmentView
            }
            else if selectedOption == "Office" {
                OfficeView
            }
        }
    }
    
    @State private var isOn: Bool = false
    var ApartmentView: some View {
        VStack {
            DashLineView
                .padding(.top, 20)

            HStack {
                Text("Unit Number")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(AppColor.colorTextBlack)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 12)
                    .padding(.bottom, 0)
                Spacer()
            }
            VStack {
                HStack {
                    VStack {
                        HStack {
                            HStack {
                                TextField(
                                    "Enter Your Apartment Number"
                                    ,text: $textFieldHomeAddress)
                                .frame(height: 30)
                                .font(.system(size: 14, weight: .regular))
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 10)
                        }
                    }
                    .background(.white)
                    .cornerRadius(10) // Add corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Rounded border
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                }
            }
            DashLineView
                .padding(.top, 20)
            ElevatorTimeSlotView
        }
        .padding(.horizontal, 16)
    }
    var ElevatorTimeSlotView: some View {
        VStack {
            HStack {
                Text("Elevator Time Slot")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                VStack {
                    Toggle(isOn: $isOn) {
                        if isOn {
                            Text("\(isOn ? "ON" : "OFF")")
                                .font(.headline)
                        }
                    }
                    .toggleStyle(SwitchToggleStyle(tint: AppColor.colorTextBlack)) // Customizing the toggle color
                }
            }
            DashLineView
                .padding(.bottom, 16)
            VStack {
                if !isOn {
                    ElevatorTimeSlotOnView
                }
                else {
                    ElevatorTimeSlotOffView
                }
                NoOfBedroomsView
                    .padding(.top, 8)
                    .padding(.bottom, 70)
                
            }
        }
    }
    
    
    var ElevatorTimeSlotOffView: some View {
        VStack(spacing: 0) {
            HStack {
                VStack (alignment: .leading, spacing: 8){
                    Text("Floor Number")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                    Text("Let us know on which floor your apartment is")
                        .font(.system(size: 14, weight: .regular))
                        .multilineTextAlignment(.leading)
                        .foregroundColor(AppColor.colorGrayTextColor)
                }
                Spacer()
                VStack {
                    HStack (spacing: 0) {
                        VStack {
                            Image(.minusButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .frame(width: 45)
                        .background(AppColor.colorMediumGray)

                        VStack {
                            Text("1")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 45) // Set the desired width for the VStack
                        .background(.white)
                        

                        VStack {
                            Image(.plustButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .frame(width: 45)
                        .background(AppColor.colorTextBlack)
                    }
                    .frame(height: 40)
                    .cornerRadius(10) // Add corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Rounded border
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                    Spacer()
                }
            }
        }
    }
    @State var selectedTime = "00:00 AM"
    var ElevatorTimeSlotOnView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 0){
                    Text("From")
                        .font(.system(size: 16, weight: .medium))

                    VStack {
                        Button(action: {
                            withAnimation {
                                showPicker.toggle()
                                print("Total Height: \(viewHeight)")
                                print("DropDown Height: \(propertyViewOffset)")
                                print("Remeaning Height: \(viewHeight-propertyViewOffset)")
                            }
                        }) {
                            VStack {
                                HStack {
                                    Text(selectedTime)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(selectedTime == "00:00 AM" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
                                    Spacer()
                                    Image(.clock)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 9)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                }
                Spacer()
                VStack (alignment: .leading, spacing: 0){
                    Text("To")
                        .font(.system(size: 16, weight: .medium))
                    VStack {
                        Button(action: {
                            withAnimation {
                                showPicker.toggle()
                                print("Total Height: \(viewHeight)")
                                print("DropDown Height: \(propertyViewOffset)")
                                print("Remeaning Height: \(viewHeight-propertyViewOffset)")
                            }
                        }) {
                            VStack {
                                HStack {
                                    Text(selectedTime)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(selectedTime == "00:00 AM" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
                                    Spacer()
                                    Image(.clock)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 16, height: 16)
                                        .foregroundColor(.gray)
                                }
                                .padding(.horizontal, 16)
                                .padding(.vertical, 9)
                            }
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                    .background(Color.white)
                    .cornerRadius(10)
                    .overlay(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                }
            }
            DashLineView
                .padding(.top, 20)
        }
    }
    
    var NoOfBedroomsView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 8){
                    Text("No. of Bedrooms \("1")")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    HStack (spacing: 0) {
                        VStack {
                            Image(.minusButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .frame(width: 45)
                        .background(AppColor.colorMediumGray)
                        VStack {
                            Text("1")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 45) // Set the desired width for the VStack
                        .background(.white)


                        VStack {
                            Image(.plustButton)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 16, height: 16)
                                .foregroundColor(.gray)
                                .padding()
                        }
                        .frame(width: 45)
                        .background(AppColor.colorTextBlack)
                    }
                    .frame(height: 40)
                    .cornerRadius(10) // Add corner radius
                    .overlay(
                        RoundedRectangle(cornerRadius: 10) // Rounded border
                            .stroke(AppColor.colorBorder, lineWidth: 1)
                    )
                    Spacer()
                }
                
            }
            .padding(.top, 8)
        }
    }
    @State private var isCheckedOffice = false
    var OfficeView: some View {
        VStack {
            DashLineView
                .padding(.top, 20)
            VStack {
                HStack(spacing: 12) {
                    Button(action: {
                        isCheckedOffice.toggle()
                    }) {
                        HStack(spacing: 12) {
                            VStack(alignment: .leading) {
                                Image(systemName: isCheckedOffice ? "checkmark.square.fill" : "square")
                                    .resizable()
                                    .frame(width: 20, height: 20)
                                    .foregroundColor(isCheckedOffice ? AppColor.colorTextBlack : AppColor.colorMediumGray)
                                    .background(.white)
                                Spacer()
                            }
                            VStack(alignment: .leading, spacing: 4) {
                                Text("Do you want Dis-Assembly Service")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundColor(AppColor.colorTextBlack)
                                    .multilineTextAlignment(.leading)
                                    Text("Hint Text")
                                        .font(.system(size: 12, weight: .regular))
                                        .foregroundColor(AppColor.colorGrayTextColor)
                                        .multilineTextAlignment(.leading)
                                        .padding(.bottom, 0)
                            }
                            Spacer()
                        }
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .padding(.vertical, 12)
            }
            DashLineView
            ElevatorTimeSlotView
            
         }
        .padding(.horizontal, 16)
    }

    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            
            Button(action: {
                // Add your action here
            }) {
                VStack {
                    Text("Proceed to Checkout")
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
    DeliveryView()
}
    
