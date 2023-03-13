//
//  Constants.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/2/23.
//

import Foundation
import SwiftUI

struct Constants{
    static let titleFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 22) ?? UIFont.systemFont(ofSize: 19))
    static let textFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19))
    static let textFontSmall: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 19) ?? UIFont.systemFont(ofSize: 13))
    static let tabFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 10) ?? UIFont.systemFont(ofSize: 10))
    static let textFontSmall: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 16) ?? UIFont.systemFont(ofSize: 19))
}
extension Color{
    static let highlight = Color("Highlight")
}
enum ViewState{
    case home
    case login
    case signup
    case forgotPassword
}

