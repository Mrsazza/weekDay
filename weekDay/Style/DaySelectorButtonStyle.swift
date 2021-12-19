//
//  DaySelectorButtonStyle.swift
//  weekDay
//
//  Created by Sazza on 19/12/21.
//

import SwiftUI

struct DaySelectorButtonStyle: ButtonStyle {
    
    var isSelected : Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .frame(width: 30, height: 30)
            .foregroundColor(isSelected ? .white : .black)
            .background(isSelected ? .black : .white)
            .cornerRadius(20)
            .overlay(
                Circle()
                    .stroke(Color.black, lineWidth: 2)
            )
            .padding(.horizontal,5)
    }
}

