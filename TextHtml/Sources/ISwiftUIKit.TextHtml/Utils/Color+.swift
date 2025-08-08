//
//  Color+.swift
//  ISwiftUIKit.TextHtml
//
//  Created by Taiyou on 2025/8/8.
//

//
//  Color+Extension.swift
//
//
//  Created by Macbookator on 5.06.2022.
//
import SUtilKit_SwiftUI
#if canImport(UIKit)
import UIKit

extension UIColor {
    var hex: String? {
        return UtilKUIColor.uIColor2strHex(self)
    }
}
#else
import AppKit

extension NSColor {
    var hex: String? {
        return UtilKNSColor.nSColor2strHex(self)
    }
}
#endif
