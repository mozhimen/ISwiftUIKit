//
//  TextAlignment+.swift
//  ISwiftUIKit.TextHtml
//
//  Created by Taiyou on 2025/8/8.
//

//
//  TextAlignment+Extension.swift
//
//
//  Created by MacBookator on 18.05.2022.
//

import SwiftUI

public extension TextAlignment {
    var htmlDescription: String {
        switch self {
        case .center:
            return "center"
        case .leading:
            return "left"
        case .trailing:
            return "right"
        }
    }
}
