//
//  InterestsScrollView.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 03.03.2025.
//

import SwiftUI

struct InterestsScrollView: View {
    @State var interestsVM: UserSettingsViewModel
    @State private var selectedInterests: String = ""
    @State var viewModel: NewsViewModel
    var body: some View {
        ScrollView(.horizontal) {
            HStack(spacing: 30) {
                ForEach(interestsVM.user.interests.filter({ $0.isOn })) { interest in
                    Button(action: {
                        if selectedInterests.contains(interest.name) {
                            selectedInterests.removeAll()
                           
                        } else {
                            selectedInterests = interest.name
                        }
                        viewModel.fetchDatabyWord(searchWord: interest.name)
                    }) {
                        Text(interest.name)
                            .font(.newsTitle)
                            .tint(selectedInterests.contains(interest.name) ? .gray : .customBlue)
                    }
                }
            }
        }
        .padding(.vertical, 12)
        .frame(width: 358)
        .scrollIndicators(.never)
    }
}

