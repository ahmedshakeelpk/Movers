//
//  AdditionalInformationViewModel.swift
//  Movers
//
//  Created by Shakeel Ahmed on 01/02/2025.
//

import Foundation

class AdditionalInformationViewModel: BaseViewModel {
    
    @Published var isDateTimePickerViewPresented: Bool = false
    @Published var isShowDateTimePickerView: Bool = false
    @Published var isDatePicker: Bool = false
    @Published var selectedDate: Date = Date()
    @Published var selectedDateString: String = "DD/MM/YYYY"
    @Published var selectedTimeString: String = "HH:MM"

    @Published var noOfHeavyItems: Int = 0

    @Published var navigateToDropOffLocationView: Bool = false

    var isFormValid: Bool {
        return (selectedDateString != "DD/MM/YYYY" && selectedTimeString != "HH:MM")
    }
}
