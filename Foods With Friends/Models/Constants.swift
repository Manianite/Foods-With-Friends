//
//  Constants.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/2/23.
//

import Foundation
import SwiftUI

struct Constants{
    static let titleFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 22) ?? UIFont.systemFont(ofSize: 22))
    static let textFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 19) ?? UIFont.systemFont(ofSize: 19))
    static let tabFont: Font = Font(UIFont(name: "AppleSDGothicNeo-Regular", size: 10) ?? UIFont.systemFont(ofSize: 10))
}
extension Color{
    static let highlight = Color("Highlight")
}
enum ViewState{
    case homeFeed
    case personalProfile
    case search
    case comments
    case friendsList
    case friendProfile
    case authentication
    case login
    case signup
    case forgotPassword
}


