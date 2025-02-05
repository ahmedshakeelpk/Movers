//
//  DropOffLocationViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 01/02/2025.
//

import Foundation

class DropOffLocationViewModel: BaseViewModel {
    @Published var navigateToPickLocationMapView: Bool = false
    @Published var navigateToConfirmOrderView: Bool = false
    @Published var textFieldApartmentNumber = ""
    
    @Published var textFieldHomeAddress1 = ""
    @Published var textFieldHomeAddress2 = ""
    @Published var textFieldHomeAddress3 = ""
    var addressLatitudeLongitude1: (Double, Double)? = nil
    var addressLatitudeLongitude2: (Double, Double)? = nil
    var addressLatitudeLongitude3: (Double, Double)? = nil
    
    @Published var selectedPropertyType = "Select Property Type"
    @Published var selectedPropertySize = "Select Property Size"
    
    @Published var selectedPropertyTypesData: ModelResponsePropertyTypesData!
    
    @Published var propertyTypeViewOffset: CGFloat = 0 // To store the vertical offset of PropertyView
    @Published var propertySizeViewOffset: CGFloat = 0 // To store the vertical offset of PropertyView
    @Published var viewHeight: CGFloat = 0 // To store the vertical offset of PropertyView

    var slapOne = ["Apartment", "Condominium", "Basement", "Open Basement"]
    var slapTwo = ["Stacked Condo", "Townhouse", "Town House", "Stackede Townhouse", "Semi Detached House"]
    var slapThree = ["Detached House"]
    var slapFour = ["Storage"]
    var slapFive = ["Office"]

    var maximumNumberOfBed = 0
    var maximumNumberOfFloor = 20
    var maximumNumberOfMover = 20
    
    @Published var selectedDate: Date = Date()
    @Published var isSelectFromTime: Bool = true
    @Published var isTimePickerPresented: Bool = false
    
    @Published var isShowPropertySize: Bool = false
    @Published var isPresentPropertySizeDropDown: Bool = false
    @Published var isPresentPropertyTypeDropDown = false // Controls picker visibility

    
    @Published var selectedFromTime = "00:00 AM"
    @Published var selectedToTime = "00:00 AM"
    @Published var floorNumber: Int = 0
    @Published var noOfBed: Int = 0
    @Published var noOfMovers: Int = 0
    
    //Apartment
    @Published var textFieldUnitNumberApartment: String = ""
    
    //Office
    @Published var isDisAssemblySericesChecked: Bool = false
    
    @Published var isOnElevatorTimeSlot: Bool = false
    @Published var isShowTimePickerView: Bool = false

    var selectedTextFieldIndex: Int = 1
    
    var modelResponsePropertyTypes: ModelResponsePropertyTypes? {
        didSet {
            
        }
    }
    
    var modelPricingResponse: ModelPricingResponse? {
        didSet {
            
        }
    }
    
    override init() {
        super.init()
        getPropertyTypes()
        getPricing()
    }
    
    func getPropertyTypes() {
        APIs.getAPI(apiName: .propertyTypes) { responseData, success, errorMsg, statusCode  in
            if success { }
            
            do {
                let model: ApiResponse<ModelResponsePropertyTypes>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    self.modelResponsePropertyTypes = model?.data
                }
                else {
                    print("getPropertyTypes (\(type(of: self))): \(model?.message ?? "")")
//                    showPopup(title: "Error!", message: model?.message ?? "", imageIcon: .errorIcon) {
//
//                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
    
    func setMaximumNumberOfBed() {
        isShowPropertySize = false
        if slapOne.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            maximumNumberOfBed = 3
            maximumNumberOfMover = 3
        } else if slapTwo.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            maximumNumberOfBed = 4
            maximumNumberOfMover = 4
        } else if slapThree.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            maximumNumberOfBed = 4
            maximumNumberOfMover = 4
        } else if slapFour.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            maximumNumberOfBed = 0
        } else if slapFive.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            maximumNumberOfBed = 0
        } else {
            maximumNumberOfBed = 0
        }
    }
//    @Published var isFormValid: Bool = true

    var isFormValid: Bool {
        var isValid = false
        if slapOne.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            isValid =
            !textFieldHomeAddress1.isEmpty
            &&
            !textFieldUnitNumberApartment.isEmpty
            &&
            noOfBed > 0
            &&
            noOfMovers > 0
            &&
            floorNumber > 0
            &&
            (isOnElevatorTimeSlot ? (selectedFromTime != "00:00 AM" && selectedToTime != "00:00 AM") : true)
        } else if slapTwo.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            return false
        } else if slapThree.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            return false
        } else if slapFour.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            isValid =
            !textFieldHomeAddress1.isEmpty
            &&
            (selectedPropertySize.lowercased() != "Select Property Size".lowercased())
            &&
            noOfMovers > 0
            &&
            (isOnElevatorTimeSlot ? (selectedFromTime != "00:00 AM" && selectedToTime != "00:00 AM") : true)
        } else if slapFive.map({ $0.lowercased() }).contains(selectedPropertyType.lowercased()) {
            isValid =
            !textFieldHomeAddress1.isEmpty
            &&
            (selectedPropertySize.lowercased() != "Select Property Size".lowercased())
            &&
            noOfMovers > 0
            &&
            floorNumber > 0
            &&
            (isOnElevatorTimeSlot ? (selectedFromTime != "00:00 AM" && selectedToTime != "00:00 AM") : true)
        }
        return isValid
    }
    
    func getPlaceHolderForUnit() -> String {
        return "Enter Your \(selectedPropertyType) Number"
    }
    
    func getPricing() {
        APIs.getAPI(apiName: .pricing) { responseData, success, errorMsg, statusCode  in
            if success { }
            
            do {
                let model: ApiResponse<ModelPricingResponse>? = try APIs.decodeDataToObject(data: responseData)
                if model?.status == 200 {
                    self.modelPricingResponse = model?.data
                }
                else {
                    print("getPropertyTypes (\(type(of: self))): \(model?.message ?? "")")
//                    showPopup(title: "Error!", message: model?.message ?? "", imageIcon: .errorIcon) {
//
//                    }
                }
            } catch {
                print("Error decoding data: \(error.localizedDescription)")
            }
        }
    }
}
