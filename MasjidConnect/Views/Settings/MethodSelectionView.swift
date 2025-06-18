//
//  MethodSelectionView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import SwiftUI

struct MethodSelectionView: View {
    @Binding var selectedMethod: Int
    
    var body: some View {
        List {
            ForEach(CalculationMethod.allCases) { method in
                HStack {
                    Text(method.displayName)
                    Spacer()
                    if method.rawValue == selectedMethod {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedMethod = method.rawValue
                }
            }
        }
        .navigationTitle("Select Method")
    }
}
