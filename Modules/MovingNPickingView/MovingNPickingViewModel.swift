//
//  MovingNPickingViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 28/01/2025.
//

import Foundation

class MovingNPickingViewModel: BaseViewModel {
    @Published var navigateToPickLocationMapView: Bool = false
    @Published var navigateToAdditionalInformationView: Bool = false
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
    
    override init() {
        super.init()
        getPropertyTypes()
    }
    
    var modelResponsePropertyTypes: ModelResponsePropertyTypes? {
        didSet {
            
        }
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
    
    func isFormNotValid() {
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
    
    func getPlaceHolderForUnit() -> String {
        return "Enter Your \(selectedPropertyType) Number"
    }
}
