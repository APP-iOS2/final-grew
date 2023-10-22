//
//  GrewGenderButtonsView.swift
//  Grew
//
//  Created by 마경미 on 22.10.23.
//

import SwiftUI

struct GrewGenderButtonsView: View {
    @State var isSelectedGenders: [Bool] = [false, false, false]
    
    @Binding var selectedGender: Gender
    var body: some View {
        HStack {
            DefaultSelectedButton(isSelected: $isSelectedGenders[0], isBig: true, action: {
                selectGender(.male)
            }, text: "남성")
            DefaultSelectedButton(isSelected: $isSelectedGenders[1], isBig: true, action: {
                selectGender(.female)
            }, text: "여성")
            DefaultSelectedButton(isSelected: $isSelectedGenders[2], isBig: true, action: {
                selectGender(.any)
            }, text: "누구나")
        }
    }
    
    private func selectGender(_ gender: Gender) {
        for index in 0..<isSelectedGenders.count {
            isSelectedGenders[index] = false
        }
        
        switch gender {
        case .any:
            isSelectedGenders[2] = true
        case .female:
            isSelectedGenders[1] = true
        case .male:
            isSelectedGenders[0] = true
        }
        
        selectedGender = gender
    }
}

#Preview {
    GrewGenderButtonsView(selectedGender: .constant(.any))
}
