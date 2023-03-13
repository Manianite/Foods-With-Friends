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
        self.friends = [""]
        self.reviews = [Review()]
    }
    internal init() {
        self.username = "Julia Zorc"
        self.handle = "juliazorc123"
        self.uid = "Julia'sAccountlessUserID"
        self.bio = "Hi! I am Julia and, just like you, I love food! I post reviews at least once a week. Be my friend to see my opinions and be a better informed foodie :)"
        self.profilePic = ""
        self.city = "Wynnewood, PA"
        self.friends = [""]
        self.reviews = [Review()]
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
    func reinit(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.bio = ""
        self.profilePic = ""
        self.city = ""
        self.friends = [""]
        self.reviews = [Review()]
    }
}
class PublicUser: ObservableObject, Codable {
    @Published var username: String
    @Published var handle: String
    @Published var profilePic: String
    
    enum CodingKeys: CodingKey {
        case username, handle, profilePic
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(handle, forKey: .handle)
        try container.encode(profilePic, forKey: .profilePic)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        handle = try container.decode(String.self, forKey: .handle)
        profilePic = try container.decode(String.self, forKey: .profilePic)
    }
    internal init(username: String, handle: String) {
        self.username = username
        self.handle = handle
        self.profilePic = ""
    }
    internal init(_ user: User) {
        self.username = user.username
        self.handle = user.handle
        self.profilePic = user.profilePic
    }
    internal init() {
        self.username = ""
        self.handle = ""
        self.profilePic = ""
    }
    func reinit(username: String, handle: String) {
        self.username = username
        self.handle = handle
        self.profilePic = ""
    }
    func reinit(_ user: PublicUser) {
        self.username = user.username
        self.handle = user.handle
        self.profilePic = user.profilePic
    }
}

extension Encodable {
    var toDictionnary: [String : Any] {
        guard let data =  try? JSONEncoder().encode(self) else {
            return [:]
        }
        guard let dict = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] else {
            print("ERROR!!! could not convert object to dictionary")
            return [:]
        }
        return dict
    }
}
extension Dictionary {
    func asObject<T>(_ type: T.Type, from dict: [String: Any]) throws -> T where T: Codable {
        let data = try JSONSerialization.data(withJSONObject: dict)
        let obj = try JSONDecoder().decode(T.self, from: data)
        return obj
    }
}
