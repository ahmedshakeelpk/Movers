//
//  DropOffLocationView.swift
//  Movers
//
//  Created by Shakeel Ahmed on 01/02/2025.
//

import SwiftUI

var kArrayLocationsDropOff = [String]()
var kArrayLocationsLatitudeLongitudeDropOff = [(Double, Double)]()
var kArrayDropOffLocationsDropOff = [String]()
var kArrayDropOffLocationsLatitudeLongitudeDropOff = [(Double, Double)]()
var kSelectedPropertyTypesDataDropOff: DropOffLocationViewModel.ModelResponsePropertyTypesData!
var kTextFieldUnitNumberApartmentDropOff = ""
var kSelectedPropertySizeDropOff = ""
var kSelectedFromTimeDropOff = ""
var kSelectedToTimeDropOff = ""
var kFloorNumberDropOff: Int = 0
var kNoOfBedDropOff: Int = 0
var kNoOfMoversDropOff: Int = 0

struct DropOffLocationView: View {
    @Environment(\.dismiss) var myDismiss
    @StateObject var viewModel = DropOffLocationViewModel()
    
    @State private var arrayNumberOfStops: [Int] = [0] // Initial array with a single stop
    
    var selectedService: HomeViewModel.ModelResponseServicesData!
    
    var body: some View {
        ZStack {
            ZStack {
                // Main Content
                VStack {
                    navigationBar
                        .padding(.horizontal, 16)
                    ScrollView {
                        SelectPickUpView
                        AddStopView
                        DescriptionView
                        PropertyTypeView
                        if viewModel.isShowPropertySize {
                            PropertySizeView
                        }
                        if viewModel.slapOne.contains(viewModel.selectedPropertyType) {
                            UnitNumberView
                            ElevatorTimeSlotView
                            if viewModel.isOnElevatorTimeSlot {
                                ElevatorTimeFromToView
                            }
                            FloorNumberView
                            NoOfBedroomsView
                            NoOfMoversView
                        } else if viewModel.slapTwo.contains(viewModel.selectedPropertyType) {
                            UnitNumberView
                            ElevatorTimeSlotView
                            if viewModel.isOnElevatorTimeSlot {
                                ElevatorTimeFromToView
                            }
                            FloorNumberView
                            NoOfBedroomsView
                            NoOfMoversView
                        } else if viewModel.slapThree.contains(viewModel.selectedPropertyType) {
                            UnitNumberView
                            ElevatorTimeSlotView
                            if viewModel.isOnElevatorTimeSlot {
                                ElevatorTimeFromToView
                            }
                            FloorNumberView
                            NoOfBedroomsView
                            NoOfMoversView
                        } else if viewModel.slapFour.contains(viewModel.selectedPropertyType) {
                            ElevatorTimeSlotView
                                .padding(.top, 20)
                            if viewModel.isOnElevatorTimeSlot {
                                ElevatorTimeFromToView
                            }
                            NoOfMoversView
                        } else if viewModel.slapFive.contains(viewModel.selectedPropertyType) {
                            OfficeView
                            ElevatorTimeSlotView
                            if viewModel.isOnElevatorTimeSlot {
                                ElevatorTimeFromToView
                            }
                            FloorNumberView
                            NoOfMoversView
                        } else {
                            EmptyView() // Optional: Handle cases where none of the conditions are met
                        }
                        Spacer()
                    }
                    ButtonConfirmView
                }
                .background(AppColor.colorBackGroundGray)
                .onTapGesture {
                    if viewModel.isPresentPropertyTypeDropDown {
                        withAnimation {
                            viewModel.isPresentPropertySizeDropDown = false
                            viewModel.isPresentPropertyTypeDropDown = false
                        }
                    }
                }
                .onTapGesture {
                    hideKeyboard()
                }
                
                // Dropdown Property Type Picker
                if viewModel.isPresentPropertyTypeDropDown {
                    VStack {
                        DropdownPickerView(
                            showPicker: $viewModel.isPresentPropertyTypeDropDown,
                            selectedOption: $viewModel.selectedPropertyType,
                            arrayOptions: viewModel.modelResponsePropertyTypes?.propertyTypes?.compactMap { $0.name } ?? [], didSelectRowHandler: { index in
                                print(index)
                                viewModel.setMaximumNumberOfBed()
                                if viewModel.modelResponsePropertyTypes?.propertyTypes?[index].children.count ?? 0 > 0 {
                                    viewModel.isShowPropertySize = true
                                    viewModel.selectedPropertyTypesData = viewModel.modelResponsePropertyTypes?.propertyTypes?[index]
                                }
                            }
                        )
                        .frame(height: 300) // Set desired height for the dropdown
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 16)
                        .offset(y: viewModel.propertyTypeViewOffset) // Adjust position vertically if needed
                        Spacer()
                    }
                }
                
                // Dropdown Property Size Picker
                if viewModel.isPresentPropertySizeDropDown {
                    VStack {
                        DropdownPickerView(
                            showPicker: $viewModel.isPresentPropertySizeDropDown,
                            selectedOption: $viewModel.selectedPropertySize,
                            arrayOptions: viewModel.selectedPropertyTypesData?.children.compactMap { $0.name } ?? [],
                            didSelectRowHandler: { index in
                                print("Index: \(index)")
                                print("Selected Property Type: \(viewModel.selectedPropertyTypesData?.children[index].name ?? "No Name")")
                            }                        )
                        .frame(height: 300) // Set desired height for the dropdown
                        .background(Color.white)
                        .cornerRadius(10)
                        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 2)
                        .padding(.horizontal, 16)
                        .offset(y: viewModel.propertySizeViewOffset) // Adjust position vertically if needed
                        Spacer()
                    }
                }
                
                NavigationLink(
                    destination: PickLocationMapView(didClickOnConfirmPickupHandler: {
                        address, latitude, longitude in
                        if viewModel.selectedTextFieldIndex == 0 {
                            viewModel.textFieldHomeAddress1 = address
                            viewModel.addressLatitudeLongitude1 = (latitude, longitude)
                        }
                        else if viewModel.selectedTextFieldIndex == 1 {
                            viewModel.textFieldHomeAddress2 = address
                            viewModel.addressLatitudeLongitude2 = (latitude, longitude)
                        }
                        else if viewModel.selectedTextFieldIndex == 2 {
                            viewModel.textFieldHomeAddress3 = address
                            viewModel.addressLatitudeLongitude3 = (latitude, longitude)
                        }
                    }),
                    isActive: $viewModel.navigateToPickLocationMapView,
                    label: { EmptyView() }
                )
            }
            .navigationBarHidden(true) // Hide navigation bar here as well
            .background(
                VStack {
                    Color(UIColor.systemGroupedBackground)
                    GeometryReader { geometry in
                        Color.clear
                            .onAppear {
                                viewModel.viewHeight = geometry.frame(in: .global).maxY
                                print(viewModel.viewHeight)
                            }
                            .onChange(of: geometry.frame(in: .global)) { newFrame in
                                viewModel.viewHeight = newFrame.maxY
                                print(viewModel.viewHeight)
                            }
                    }
                }
            )
            if viewModel.isShowTimePickerView {
                TimePickerView
            }
            NavigationLink(
                destination: ConfirmOrderView(),
                isActive: $viewModel.navigateToConfirmOrderView,
                label: { EmptyView()})
        }
    }
    
    var navigationBar: some View {
        NavigationBarView(titleName: "Moving & Packing", leftIconName: "backButton", isLeftButtonClick: {
            print("isLeftButtonClick Clicked")
            myDismiss()
        }, isRightButtonClick: {})
    }
    
    var SelectPickUpView: some View {
        VStack {
            HStack {
                Text("DropOff Location")
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
        }
    }
    
    func TextFieldSelectPickUpView(index: Int) -> some View {
        VStack {
            HStack {
                Button(action: {
                    viewModel.selectedTextFieldIndex = index
                    viewModel.navigateToPickLocationMapView = true
                }, label: {
                    VStack {
                        HStack {
                            HStack {
                                Image(.navigationIcon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 16, height: 16)
                                
                                TextField(
                                    index == 0 ? "Select DropOff" : "Stop \(index)",
                                    text: (index == 0) ? $viewModel.textFieldHomeAddress1 : (index == 1) ? $viewModel.textFieldHomeAddress2 : $viewModel.textFieldHomeAddress3
                                )
                                .frame(height: 30)
                                .font(.system(size: 14, weight: .regular))
                                .padding(.leading, 8) // Add padding to ensure left spacing
                                .multilineTextAlignment(.leading) // Align text to the left
                                .background(Color.white) // Ensure visible field background
                                .cornerRadius(5) // Optional for better UI
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
                })
                
                if index > 0 {
                    Button(action: {
                        guard arrayNumberOfStops.count > 0 else { return }
                        arrayNumberOfStops.remove(at: index)
                        if index == 0 {
                            viewModel.addressLatitudeLongitude1 = nil
                            viewModel.textFieldHomeAddress1 = ""
                        }
                        else if index == 1 {
                            viewModel.addressLatitudeLongitude2 = nil
                            viewModel.textFieldHomeAddress2 = ""
                        }
                        else if index == 2 {
                            viewModel.addressLatitudeLongitude3 = nil
                            viewModel.textFieldHomeAddress3 = ""
                        }
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
                }
            }
            .padding(.horizontal, 16)
        }
    }
    
    var AddStopView: some View {
        HStack {
            HStack {
                Button(action: {
                    guard arrayNumberOfStops.count <= 2 else { return }
                    // Safely get the last index or start with 0 if the array is empty
                    let index = (arrayNumberOfStops.last ?? 0) + 1
                    // Append the new index to the array
                    arrayNumberOfStops.append(index)
                }) {
                    HStack {
                        Image(.plusIcon)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 14, height: 14)
                        Text("Add Stops")
                            .font(.system(size: 14, weight: .regular))
                            .foregroundColor(AppColor.colorTextBlack)
                            .multilineTextAlignment(.leading)
                            .padding(.leading, 5)
                    }
                    .padding(.horizontal, 16)
                    .padding(.vertical, 12)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .background(Color.white) // Background color
            .overlay(
                Capsule()
                    .stroke(AppColor.colorBorder, lineWidth: 1) // Capsule border
            )
            .clipShape(.capsule)
            .padding(.horizontal, 16)
            Spacer()
        }
        .padding(.top, 12)
    }
    
    var DescriptionView: some View {
        VStack {
            HStack {
                Text("You are allowed to add upto 3 stops")
                    .font(.system(size: 12, weight: .regular))
                    .foregroundColor(AppColor.colorGrayTextColor)
                    .multilineTextAlignment(.leading)
                    .padding(.top, 12)
                    .padding(.horizontal, 16)
                Spacer()
            }
            .padding(.bottom, 8)
            DashLineView
                .padding(.horizontal, 16)
        }
    }
    
    var PropertyTypeView: some View {
        VStack {
            HStack {
                Text("Property Type")
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
                            viewModel.propertyTypeViewOffset = geometry.frame(in: .global).maxY
                            print(viewModel.propertyTypeViewOffset)
                        }
                        .onChange(of: geometry.frame(in: .global)) { newFrame in
                            viewModel.propertyTypeViewOffset = newFrame.maxY
                            print(viewModel.propertyTypeViewOffset)
                        }
                }
            )
            VStack {
                HStack {
                    Text(viewModel.selectedPropertyType)
                        .frame(height: 30)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(viewModel.selectedPropertyType == "Select Property Type" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
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
                    viewModel.isPresentPropertySizeDropDown = false
                    viewModel.isPresentPropertyTypeDropDown = true
                    print("Total Height: \(viewModel.viewHeight)")
                    print("DropDown Height: \(viewModel.propertyTypeViewOffset)")
                    print("Remeaning Height: \(viewModel.viewHeight-viewModel.propertyTypeViewOffset)")
                }
            }
        }
    }
    
    var PropertySizeView: some View {
        VStack {
            HStack {
                Text("Property Size")
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
                            viewModel.propertySizeViewOffset = geometry.frame(in: .global).maxY
                            print(viewModel.propertySizeViewOffset)
                        }
                        .onChange(of: geometry.frame(in: .global)) { newFrame in
                            viewModel.propertySizeViewOffset = newFrame.maxY
                            print(viewModel.propertySizeViewOffset)
                        }
                }
            )
            VStack {
                HStack {
                    Text(viewModel.selectedPropertySize)
                        .frame(height: 30)
                        .font(.system(size: 14, weight: .regular))
                        .foregroundColor(viewModel.selectedPropertySize == "Select Property Size" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
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
                    viewModel.isPresentPropertySizeDropDown = true
                    viewModel.isPresentPropertyTypeDropDown = false
                    print("Total Height: \(viewModel.viewHeight)")
                    print("DropDown Height: \(viewModel.propertySizeViewOffset)")
                    print("Remeaning Height: \(viewModel.viewHeight-viewModel.propertyTypeViewOffset)")
                }
            }
        }
    }
    
    var UnitNumberView: some View {
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
                                    "\(viewModel.getPlaceHolderForUnit())"
                                    ,text: $viewModel.textFieldUnitNumberApartment)
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
        }
        .padding(.horizontal, 16)
    }
    var ElevatorTimeSlotView: some View {
        VStack {
            HStack {
                Text("Elevator Time Slot")
                    .font(.system(size: 16, weight: .medium))
                Spacer()
                Toggle(isOn: $viewModel.isOnElevatorTimeSlot) {
                    Text("\(viewModel.isOnElevatorTimeSlot ? "ON" : "OFF")")
                        .font(.headline)
                }
                .toggleStyle(SwitchToggleStyle(tint: AppColor.colorTextBlack)) // Customizing the toggle color
            }
            DashLineView
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
    }
    
    var FloorNumberView: some View {
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
                        Button(action: {
                            if viewModel.floorNumber == 0 {
                                return()
                            }
                            viewModel.floorNumber -= 1
                        }, label: {
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
                        })
                        
                        VStack {
                            Text("\(viewModel.floorNumber)")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 55) // Set the desired width for the VStack
                        .background(.white)
                        
                        Button(action: {
                            if viewModel.maximumNumberOfFloor == viewModel.floorNumber {
                                return()
                            }
                            viewModel.floorNumber += 1
                        }, label: {
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
                        })
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
        .padding(.horizontal, 16)
    }
    
    var ElevatorTimeFromToView: some View {
        VStack {
            HStack {
                // From Section
                VStack(alignment: .leading, spacing: 0) {
                    Text("From")
                        .font(.system(size: 16, weight: .medium))
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                viewModel.isSelectFromTime = true
                                viewModel.isShowTimePickerView.toggle()
                                print("Total Height: \(viewModel.viewHeight)")
                                print("DropDown Height: \(viewModel.propertyTypeViewOffset)")
                                print("Remaining Height: \(viewModel.viewHeight - viewModel.propertyTypeViewOffset)")
                            }
                        }) {
                            VStack {
                                HStack {
                                    Text(viewModel.selectedFromTime)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(viewModel.selectedFromTime == "00:00 AM" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
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
                
                // To Section
                VStack(alignment: .leading, spacing: 0) {
                    Text("To")
                        .font(.system(size: 16, weight: .medium))
                    
                    VStack {
                        Button(action: {
                            withAnimation {
                                viewModel.isSelectFromTime = false
                                viewModel.isShowTimePickerView.toggle()
                                print("Total Height: \(viewModel.viewHeight)")
                                print("DropDown Height: \(viewModel.propertyTypeViewOffset)")
                                print("Remaining Height: \(viewModel.viewHeight - viewModel.propertyTypeViewOffset)")
                            }
                        }) {
                            VStack {
                                HStack {
                                    Text(viewModel.selectedToTime)
                                        .frame(height: 30)
                                        .font(.system(size: 14, weight: .regular))
                                        .foregroundColor(viewModel.selectedToTime == "00:00 AM" ? AppColor.colorTextPlaceHolder : AppColor.colorTextBlack)
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
        .padding(.horizontal, 16)
    }
    
    var TimePickerView: some View {
        VStack {
            Spacer() // Push content to the bottom
            VStack {
                HStack {
                    Spacer() // Pushes the button to the right
                    Button {
                        viewModel.isShowTimePickerView = false
                        viewModel.isTimePickerPresented = false
                    } label: {
                        Text("Done")
                            .font(.headline)
                            .foregroundColor(.blue)
                            .padding(.vertical, 8)
                            .padding(.horizontal, 16)
                            .background(Color.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                
                DatePicker(
                    "Select Time",
                    selection: $viewModel.selectedDate,
                    displayedComponents: [.hourAndMinute]
                )
                .datePickerStyle(WheelDatePickerStyle())
                .labelsHidden()
                .frame(height: 200)
                .background(Color.white)
                .cornerRadius(10)
                .padding()
                .onChange(of: viewModel.selectedDate) { newDate in
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm a"
                    if viewModel.isSelectFromTime {
                        viewModel.selectedFromTime = dateFormatter.string(from: viewModel.selectedDate)
                    } else {
                        viewModel.selectedToTime = dateFormatter.string(from: viewModel.selectedDate)
                    }
                }
            }
            .padding()
            .background(Color.white)
            .cornerRadius(12)
            .shadow(radius: 10)
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(.white, lineWidth: 2)
            )
        }
        .background(
            Group {
                if viewModel.isTimePickerPresented {
                    Color.black.opacity(0.1).edgesIgnoringSafeArea(.all)
                } else {
                    Color.clear
                }
            }
        )
        .transition(.move(edge: .bottom))
        .animation(.easeInOut, value: viewModel.isShowTimePickerView)
        .onAppear() {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
                viewModel.isTimePickerPresented = true
            }
        }
    }
    
    var NoOfBedroomsView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 8){
                    Text("No. of Bedrooms \(viewModel.noOfBed)")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    HStack (spacing: 0) {
                        Button(action: {
                            if viewModel.noOfBed == 0 {
                                return()
                            }
                            viewModel.noOfBed -= 1
                        }, label: {
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
                        })
                        
                        VStack {
                            Text("\(viewModel.noOfBed)")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 55) // Set the desired width for the VStack
                        .background(.white)
                        
                        Button(action: {
                            if viewModel.maximumNumberOfBed == viewModel.noOfBed {
                                return()
                            }
                            viewModel.noOfBed += 1
                        }, label: {
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
                        })
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
        .padding(.horizontal, 16)
    }
    
    var NoOfMoversView: some View {
        VStack {
            HStack {
                VStack (alignment: .leading, spacing: 8){
                    Text("No. of Movers \(viewModel.noOfMovers)")
                        .font(.system(size: 16, weight: .bold))
                        .multilineTextAlignment(.leading)
                }
                Spacer()
                VStack {
                    HStack (spacing: 0) {
                        Button(action: {
                            if viewModel.noOfMovers == 0 {
                                return()
                            }
                            viewModel.noOfMovers -= 1
                        }, label: {
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
                        })
                        
                        VStack {
                            Text("\(viewModel.noOfMovers)")
                                .font(.system(size: 16, weight: .regular))
                                .multilineTextAlignment(.center)
                                .foregroundColor(AppColor.colorTextBlack)
                                .padding()
                        }
                        .frame(width: 55) // Set the desired width for the VStack
                        .background(.white)
                        
                        Button(action: {
                            if viewModel.maximumNumberOfMover == viewModel.noOfMovers {
                                return()
                            }
                            viewModel.noOfMovers += 1
                        }, label: {
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
                        })
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
        .padding(.horizontal, 16)
        .padding(.top, 8)
        .padding(.bottom, 70)
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
                }
                .padding(.vertical, 12)
            }
            DashLineView
        }
        .padding(.horizontal, 16)
    }
    
    
    var ButtonConfirmView: some View {
        VStack {
            DashLineWithShadowView
            
            Button(action: {
                // Add your action here
                kSelectedPropertyTypesDataDropOff = viewModel.selectedPropertyTypesData
                kTextFieldUnitNumberApartmentDropOff = viewModel.textFieldUnitNumberApartment
                kSelectedFromTimeDropOff = viewModel.selectedFromTime
                kSelectedToTimeDropOff = viewModel.selectedToTime
                kFloorNumberDropOff = viewModel.floorNumber
                kNoOfBedDropOff = viewModel.noOfBed
                kNoOfMoversDropOff = viewModel.noOfMovers
                kSelectedPropertySizeDropOff = viewModel.selectedPropertySize
                
                for index in arrayNumberOfStops {
                    if index == 0 {
                        kArrayLocationsDropOff.append(viewModel.textFieldHomeAddress1)
                        kArrayLocationsLatitudeLongitudeDropOff.append(viewModel.addressLatitudeLongitude1!)
                    }
                    else if index == 1 {
                        kArrayLocationsDropOff.append(viewModel.textFieldHomeAddress2)
                        kArrayLocationsLatitudeLongitudeDropOff.append(viewModel.addressLatitudeLongitude2!)
                    }
                    else if index == 2 {
                        kArrayLocationsDropOff.append(viewModel.textFieldHomeAddress3)
                        kArrayLocationsLatitudeLongitudeDropOff.append(viewModel.addressLatitudeLongitude3!)
                    }
                }
                viewModel.navigateToConfirmOrderView = true
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
            .disabled(!viewModel.isFormValid)
        }
        .background(.white)
    }
}

#Preview {
    DropOffLocationView()
}
