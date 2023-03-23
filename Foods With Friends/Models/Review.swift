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
    @Published var time: String
    let id = UUID()
    
    enum CodingKeys: CodingKey {
        case title, stars, images, restaurant, uid, body, time
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(title, forKey: .title)
        try container.encode(stars, forKey: .stars)
        try container.encode(images, forKey: .images)
        try container.encode(restaurant, forKey: .restaurant)
        try container.encode(uid, forKey: .uid)
        try container.encode(body, forKey: .body)
        try container.encode(time.replacingOccurrences(of: ".", with: ","), forKey: .time)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        stars = try container.decode(Int.self, forKey: .stars)
        uid = try container.decode(String.self, forKey: .uid)
        images = try container.decode([String].self, forKey: .images)
        restaurant = try container.decode(String.self, forKey: .restaurant)
        body = try container.decode(String.self, forKey: .body)
        time = try container.decode(String.self, forKey: .time).replacingOccurrences(of: ",", with: ".")
    }
    internal init(title: String = "", stars: Int = 0, images: [String] = [""], restaurant: String = "", uid: String = "", body: String = "", time: TimeInterval) {
        self.title = title
        self.stars = stars
        self.images = images
        self.restaurant = restaurant
        self.uid = uid
        self.body = body
        self.time = String(time)
    }
    internal init(_ empty: Bool) {
        title = ""
        stars = 0
        images = [""]
        restaurant = ""
        uid = ""
        body = ""
        time = ""
    }
    internal init(time: TimeInterval) {
        title = "I LOVED IT"
        stars = 5
        images = ["https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg","https://placekitten.com/640/360"]
        restaurant = "The Krusty Krab"
        uid = "Julia'sAccountlessUserID"
        body = "I was sort of hesitant in visiting a restaurant underwater, but the food was beyond compare! I have never before in my whole life had a burger as delectable as the Krabby Paddy. Thanks, @Patrick!"
        self.time = String(time)
    }
    internal init() {
        title = "I LOVED IT"
        stars = 5
        images = ["https://upload.wikimedia.org/wikipedia/en/a/a9/Example.jpg","https://placekitten.com/640/360"]
        restaurant = "The Krusty Krab"
        uid = "Julia'sAccountlessUserID"
        body = "I was sort of hesitant in visiting a restaurant underwater, but the food was beyond compare! I have never before in my whole life had a burger as delectable as the Krabby Paddy. Thanks, @Patrick!"
        time = "0.0"
    }
}
