//
//  User.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/9/23.
//

import Foundation

class User: ObservableObject, Codable, Equatable {
    static func == (lhs: User, rhs: User) -> Bool {lhs.handle==rhs.handle}
    
    @Published var username: String
    @Published var handle: String
    @Published var uid: String
    @Published var bio: String
    @Published var profilePic: String
    @Published var city: String
    @Published var friends:[String: Bool]
    @Published var newFriends:[String: Bool]
    @Published var reviews:[Review]
    
    enum CodingKeys: CodingKey {
        case username, handle, uid, bio, profilePic, city, friends, reviews, new_friends
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
        try container.encode(newFriends, forKey: .new_friends)
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
        friends = try container.decode([String: Bool].self, forKey: .friends)
        newFriends = try container.decode([String: Bool].self, forKey: .new_friends)
        reviews = try container.decode([Review].self, forKey: .reviews)
    }
    internal init(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.bio = ""
        self.profilePic = "person.crop.circle.fill"
        self.city = ""
        self.friends = ["_": false]
        self.newFriends = ["_": false]
        self.reviews = [Review()]
    }
    internal init() {
        self.username = "Julia Zorc"
        self.handle = "juliazorc123"
        self.uid = "Julia'sAccountlessUserID"
        self.bio = "Hi! I am Julia and, just like you, I love food! I post reviews at least once a week. Be my friend to see my opinions and be a better informed foodie :)"
        self.profilePic = "person.crop.circle.fill"
        self.city = "Wynnewood, PA"
        self.friends = ["_": false]
        self.newFriends = ["_": false]
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
        self.newFriends = user.newFriends
        self.reviews = user.reviews
    }
    func reinit(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.bio = ""
        self.profilePic = "person.crop.circle.fill"
        self.city = ""
        self.friends = ["_": false]
        self.newFriends = ["_": false]
        self.reviews = [Review()]
    }
}
class PublicUser: ObservableObject, Codable, Equatable {
    static func == (lhs: PublicUser, rhs: PublicUser) -> Bool {lhs.handle==rhs.handle}
    
    @Published var username: String
    @Published var handle: String
    @Published var uid: String
    @Published var profilePic: String
    enum CodingKeys: CodingKey {
        case username, handle, profilePic, uid
    }
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(username, forKey: .username)
        try container.encode(handle, forKey: .handle)
        try container.encode(uid, forKey: .uid)
        try container.encode(profilePic, forKey: .profilePic)
    }
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        username = try container.decode(String.self, forKey: .username)
        handle = try container.decode(String.self, forKey: .handle)
        uid = try container.decode(String.self, forKey: .uid)
        profilePic = try container.decode(String.self, forKey: .profilePic)
    }
    internal init(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.profilePic = "person.crop.circle.fill"
    }
    internal init(_ user: User) {
        self.username = user.username
        self.handle = user.handle
        self.uid = user.uid
        self.profilePic = user.profilePic
    }
    internal init() {
        self.username = "Julia Zorc"
        self.handle = "juliazorc123"
        self.uid = "Julia'sAccountlessUserID"
        self.profilePic = "person.crop.circle.fill"
    }
    func reinit(username: String, handle: String, uid: String) {
        self.username = username
        self.handle = handle
        self.uid = uid
        self.profilePic = "person.crop.circle.fill"
    }
    func reinit(_ user: PublicUser) {
        self.username = user.username
        self.handle = user.handle
        self.uid = user.uid
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
