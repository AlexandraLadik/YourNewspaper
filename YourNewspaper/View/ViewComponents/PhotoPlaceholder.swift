//
//  PhotoPlaceholder.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 13.06.2025.
//

import SwiftUI

struct PhotoPlaceholder: View {
    var body: some View {
        Image(systemName: "photo")
            .foregroundStyle(.secondary)
            .frame(width: 358, height: 201)
            .background(Color.gray.opacity(0.1))
            .clipShape(RoundedRectangle(cornerRadius: 12.0))
    }
}
