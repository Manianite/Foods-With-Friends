//
//  FetchData.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 1/19/23.
//

import Foundation

class FetchRestaurantData: ObservableObject{
    @Published var response = RestaurantResponse()
    
    func getData(_ query: String) async {
        let URLString = "https://api.spoonacular.com/food/restaurants/search?query=\(query)&lat=39.9526&lng=-75.1652&distance=15&apiKey=edb7848c89934d62ba81c2fb8c7c8b0c"
        
        guard let url = URL(string: URLString) else {return}
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
            //print(String(data: data, encoding: .utf8))
            let response = try JSONDecoder().decode(RestaurantResponse.self, from: data)
            self.response = response
        } catch {
            print(error)
        }
    }
}
struct RestaurantResponse: Codable {
    var restaurants: [Restaurant] = []
}
struct Restaurant: Codable {
    var name:String = "El Limon Mexican Taquaria"
    var address:Address = Address()
    var cuisines:[String] = ["Mexican"]
    var logo_photos:[String] = []
    var is_open:Bool = false
}
extension Restaurant: Identifiable {
    var id: String {name+address.street_addr}
}
struct Address: Codable {
    var street_addr:String = "1004 E Montgomery Rd."
    var city:String = "Aardmør"
    var state:String = "PA"
}

class FetchUserData {
    
    static func getData(_ location: String) -> User {
        do {
            var data: Data = Data()
            DatabaseData.readData(location: location) { _data, _  in
                data = _data
            }
            //print(String(data: data, encoding: .utf8))
            let response = try JSONDecoder().decode(User.self, from: data)
            return response
            
        } catch {
            print(error)
        }
        return User()
    }
}
struct User: Codable {
    var username = ""
    var handle = ""
    var bio = ""
    var pofilePic = ""
    var city = "City"
    var friendsNum = 0
    var reviewsNum = 0
    var friendList:[String] = []
    var reviewList:[Review] = []
}
struct Review: Codable {
    
}
