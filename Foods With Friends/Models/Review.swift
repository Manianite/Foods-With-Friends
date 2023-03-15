//
//  Review.swift
//  Foods With Friends
//
//  Created by Arianna Ridgeway (student LM) on 3/13/23.
//

import Foundation

class Review: Codable, Identifiable, ObservableObject {
    @Published var title: String
    @Published var stars: Int
    @Published var images: [String]
    @Published var restaurant: String
    @Published var uid: String
    @Published var body: String
    let id = UUID()
    
    enum CodingKeys: CodingKey {
        case title, stars, images, restaurant, uid, body
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(stars, forKey: .stars)
        try container.encode(images, forKey: .images)
        try container.encode(restaurant, forKey: .restaurant)
        try container.encode(uid, forKey: .uid)
        try container.encode(body, forKey: .body)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        stars = try container.decode(Int.self, forKey: .stars)
        uid = try container.decode(String.self, forKey: .uid)
        images = try container.decode([String].self, forKey: .images)
        restaurant = try container.decode(String.self, forKey: .restaurant)
        body = try container.decode(String.self, forKey: .body)
    }
    internal init(title: String = "", stars: Int = 0, images: [String] = [""], restaurant: String = "", uid: String = "", body: String = "") {
        self.title = title
        self.stars = stars
        self.images = images
        self.restaurant = restaurant
        self.uid = uid
        self.body = body
    }
}
