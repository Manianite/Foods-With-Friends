//
//  Review.swift
//  Foods With Friends
//
//  Created by Arianna Ridgeway (student LM) on 3/13/23.
//

import Foundation
//
//  Review.swift
//  fhZEaugi;.rS<aw
//
//  Created by Arianna Ridgeway (student LM) on 3/9/23.
//

struct Review: Codable, Identifiable {
    var title = ""
    var stars = 0
    var images = [""]
    var restaurant = ""
    var uid = ""
    var body = ""
    var id = UUID()
}
