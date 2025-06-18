//
//  SchoolSelectionView.swift
//  MasjidConnect
//
//  Created by Nedim Delic on 6/18/25.
//

import SwiftUI

struct SchoolSelectionView: View {
    @Binding var selectedSchool: Int
    
    var body: some View {
        List {
            ForEach(MadhabSchool.allCases) { school in
                HStack {
                    Text(school.displayName)
                    Spacer()
                    if school.rawValue == selectedSchool {
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                    }
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    selectedSchool = school.rawValue
                }
            }
        }
        .navigationTitle("Select School")
    }
}
