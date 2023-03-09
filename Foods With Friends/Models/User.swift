//
//  User.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/9/23.
//

import Foundation

class User: ObservableObject, Codable {
    @Published var username: String
    @Published var handle: String
    @Published var uid: String
    @Published var bio: String
    @Published var profilePic: String
    @Published var city: String
    @Published var friends:[String]
    @Published var reviews:[Review]
    
    enum CodingKeys: CodingKey {
        case username, handle, uid, bio, profilePic, city, friends, reviews
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(handle, forKey: .handle)
        try container.encode(uid, forKey: .uid)
        try container.encode(bio, forKey: .bio)
        try container.encode(profilePic, forKey: .profilePic)
        try container.encode(city, forKey: .city)
        try container.encode(friends, forKey: .friends)
        try container.encode(reviews, forKey: .reviews)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        handle = try container.decode(String.self, forKey: .handle)
        uid = try container.decode(String.self, forKey: .uid)
        bio = try container.decode(String.self, forKey: .bio)
        profilePic = try container.decode(String.self, forKey: .profilePic)
        city = try container.decode(String.self, forKey: .city)
        friends = try container.decode([String].self, forKey: .friends)
        reviews = try container.decode([Review].self, forKey: .reviews)
    }
    internal init(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.bio = ""
        self.profilePic = ""
        self.city = ""
        self.friends = []
        self.reviews = []
    }
    internal init() {
        self.username = ""
        self.handle = ""
        self.uid = ""
        self.bio = ""
        self.profilePic = ""
        self.city = ""
        self.friends = []
        self.reviews = []
    }
    func reinit(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.bio = ""
        self.profilePic = ""
        self.city = ""
        self.friends = []
        self.reviews = []
    }
    func reinit(_ user: User) {
        self.username = user.username
        self.handle = user.handle
        self.uid = user.uid
        self.bio = user.bio
        self.profilePic = user.profilePic
        self.city = user.city
        self.friends = user.friends
        self.reviews = user.reviews
    }
}
struct UserDict: Codable {
    var handles:[String] = []
    var uids:[String] = []
    var usernames:[String] = []
    var profilePics:[String] = []
}
