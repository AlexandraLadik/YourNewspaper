//
//  FontLibrary.swift
//  YourNewspaper
//
//  Created by Александра Ладик on 25.02.2025.
//

import SwiftUI

    extension Font {
        static func newsreader(fontWeight: Weight = .regular, size: Int) -> Font {
            return Font.custom(CustomFonts(weight: fontWeight).rawValue, size: CGFloat(size))
        }
        
        
        enum CustomFonts: String {
            case regular = "PTSerif-Regular"
            case bold = "PTSerif-Bold"
            
            init(weight: Font.Weight) {
                switch weight {
                case .regular:
                    self = .regular
                case .bold:
                    self = .bold
                default:
                    self = .regular
                }
            }
        }
        static var newsTitle: Font = .newsreader(fontWeight: .bold, size: 18)
        static var newsText: Font = .newsreader(fontWeight: .regular, size: 16)
        static var newsResourceFootnote: Font = .newsreader(fontWeight: .regular, size: 16)
        static var tabFont: Font = .newsreader(fontWeight: .regular, size: 12)
    }

