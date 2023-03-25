//
//  FoodGroup.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI

class FoodGroup: ObservableObject, Codable {
    @Published var members: [String: String]
    @Published var img: String
    @Published var name: String
    @Published var feed: [String: Review]
    @Published var isPublic: Bool
    @Published var gid: String
    
    enum CodingKeys: CodingKey {
        case members, img, feed, name, isPublic, gid
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(members, forKey: .members)
        try container.encode(img, forKey: .img)
        try container.encode(name, forKey: .name)
        try container.encode(feed, forKey: .feed)
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(gid, forKey: .gid)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        members = try container.decode([String: String].self, forKey: .members)
        img = try container.decode(String.self, forKey: .img)
        name = try container.decode(String.self, forKey: .name)
        feed = try container.decode([String: Review].self, forKey: .feed)
        isPublic = try container.decode(Bool.self, forKey: .isPublic)
        gid = try container.decode(String.self, forKey: .gid)
    }
    internal init() {
        members = [:]
        img = ""
        name = ""
        feed = [:]
        isPublic = false
        gid = ""
    }
    internal init(name: String, creatorID: String, isPublic: Bool, img: String) {
        self.members = [creatorID: "creator"]
        self.img = img
        self.name = name
        self.feed = ["_": Review(true)]
        self.isPublic = isPublic
        self.gid = creatorID
    }
    internal init(name: String, creatorID: String, isPublic: Bool) {
        self.members = [creatorID: "creator"]
        self.img = ""
        self.name = name
        self.feed = ["_": Review(true)]
        self.isPublic = isPublic
        self.gid = creatorID
    }
}
class PublicFoodGroup: ObservableObject, Codable, Comparable {
    static func < (lhs: PublicFoodGroup, rhs: PublicFoodGroup) -> Bool {
        lhs.gid < rhs.gid
    }
    
    static func == (lhs: PublicFoodGroup, rhs: PublicFoodGroup) -> Bool {
        lhs.gid == rhs.gid
    }
    
    @Published var img: String
    @Published var name: String
    @Published var isPublic: Bool
    @Published var count: Int
    @Published var gid: String
    
    enum CodingKeys: CodingKey {
        case img, name, isPublic, count, gid
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(img, forKey: .img)
        try container.encode(name, forKey: .name)
        try container.encode(isPublic, forKey: .isPublic)
        try container.encode(count, forKey: .count)
        try container.encode(gid, forKey: .gid)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        img = try container.decode(String.self, forKey: .img)
        name = try container.decode(String.self, forKey: .name)
        isPublic = try container.decode(Bool.self, forKey: .isPublic)
        count = try container.decode(Int.self, forKey: .count)
        gid = try container.decode(String.self, forKey: .gid)
    }
    internal init() {
        img = ""
        name = ""
        isPublic = false
        count = 0
        gid = ""
    }
    internal init(_ group: FoodGroup) {
        self.img = group.img
        self.name = group.name
        self.isPublic = group.isPublic
        self.count = group.members.count
        self.gid = group.members.first { (key, value) in
            value == "creator"
        }?.0 ?? "failure"
    }
}
