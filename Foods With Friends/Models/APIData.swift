//
//  FetchData.swift
//  Midterm
//
//  Created by Speer-Zisook, Ella on 1/19/23.
//

import Foundation

@MainActor class FetchRestaurantData: ObservableObject{
    @Published var response = RestaurantResponse()
    
    func getData(_ query: String, _ locationManager: LocationManager = LocationManager()) async {
       var URLString = "https://api.spoonacular.com/food/restaurants/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&lat=39.9526&lng=-75.1652&distance=15&apiKey=edb7848c89934d62ba81c2fb8c7c8b0c"
        
        if let location = locationManager.location {
            URLString = "https://api.spoonacular.com/food/restaurants/search?query=\(query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")&lat=\(location.coordinate.latitude)&lng=\(location.coordinate.longitude)&distance=15&apiKey=edb7848c89934d62ba81c2fb8c7c8b0c"
        }
   
        guard let url = URL(string: URLString) else {return}
        
        do {
            let (data,_) = try await URLSession.shared.data(from: url)
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
    var id: String {name+"∆"+address.street_addr}
}
struct Address: Codable {
    var street_addr:String = "1004 E Montgomery Rd."
    var city:String = "Aardmør"
    var state:String = "PA"
}

