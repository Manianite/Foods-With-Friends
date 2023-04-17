//
//  NewPostView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct NewPostView: View {
    @State var reviewtext: String = ""
    @State var title: String = ""
    @State private var rating: Int = 0
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @State var images: [UIImage] = []
    @StateObject var data = FetchRestaurantData()
    @EnvironmentObject var appUser: User
    @State var query: String = ""
    @State var waiting: Bool = false
    @State var showRestaurants: Bool = false
    @State var restaurant: Restaurant?
    @State var showingSelectedImages = false
    @State var showingIncompleteAlert = false
    @State var showingBodylessAlert = false
    @State var groupRecipiants: [String] = []
    @State var groups: [PublicFoodGroup] = []
    @State var showingGroups = false
    @Binding var selectedTab: Tabs
    @EnvironmentObject var locationManager: LocationManager

    func addReview() {
        if title=="" || rating==0 || restaurant==nil {
            showingIncompleteAlert = true
        } else if reviewtext=="" {
            showingBodylessAlert = true
        } else if let restaurant = restaurant {
            let time = Date().timeIntervalSince1970
            let newReview = Review(title: title, stars: rating, images: ["_"], restaurant: restaurant.name, uid: appUser.uid, body: reviewtext, time: time)
            for img in images.indices {
                UserStorage.putImage(images[img], url: "reviews/\(appUser.uid)/\(time)/\(img)") { url, error in
                    if let url = url {
                        newReview.images.append(url.absoluteString)
                        if img == images.count-1 {
                            UserData.pushReview(newReview, toFriendsOf: appUser)
                            UserData.pushReview(newReview, toGroups: groupRecipiants)
                            appUser.reviews[newReview.time] = newReview
                        }
                    } else {
                        print("ERROR: cannot putImage in addReview")
                    }
                }
            }
            if images.count == 0 {
                UserData.pushReview(newReview, toFriendsOf: appUser)
                UserData.pushReview(newReview, toGroups: groupRecipiants)
                appUser.reviews[newReview.time] = newReview
            }
            selectedTab = .ProfileView
        }
    }
    var body: some View {
        VStack {
            TextField("Title", text: $title)
                .font(Constants.titleFont)
                .foregroundColor(.black)
                .padding(.top, 20)
                .padding(.horizontal)
                .multilineTextAlignment(.center)
            HStack {
                Image(systemName: rating>0 ? "star.fill": "star")
                    .onTapGesture {
                        rating = 1
                    }
                Image(systemName: rating>1 ? "star.fill": "star")
                    .onTapGesture {
                        rating = 2
                    }
                Image(systemName: rating>2 ? "star.fill": "star")
                    .onTapGesture {
                        rating = 3
                    }
                Image(systemName: rating>3 ? "star.fill": "star")
                    .onTapGesture {
                        rating = 4
                    }
                Image(systemName: rating>4 ? "star.fill": "star")
                    .onTapGesture {
                        rating = 5
                    }
            }
            .foregroundColor(.yellow)
            .padding([.top, .bottom], 10)
            HStack {
                TextField(restaurant?.name ?? "Enter Restaurant", text: $query)
                    .padding(.leading)
                Button {
                    Task {
                        waiting = true
                        await data.getData(query, locationManager)
                        waiting = false
                    }
                    showRestaurants = true
                } label: {
                    Text("Select")
                        .foregroundColor(.blue)
                        .padding(.trailing)
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(true)
            .padding(.bottom, 10)
            TextEditor(text: $reviewtext)
                .cornerRadius(10)
                .border(Color.gray, width: 1)
            
            Text("Posting to...")
                .font(Constants.textFont)
            ScrollView{
            ForEach(groups) { group in
                HStack {
                    Text(group.name)
                        .font(Constants.titleFont)
                    Spacer()
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(groupRecipiants.contains(group.gid) ? Color.highlight : Color.secondary)
                }
                .onTapGesture {
                    if groupRecipiants.contains(group.gid) {
                        groupRecipiants.removeAll { $0==group.gid }
                    } else {
                        groupRecipiants.append(group.gid)
                    }
                }
            }}
            .cornerRadius(10)
            .padding()
            .onAppear {
                UserData.getBranch(from: "groups/group_dict/", as: [String: PublicFoodGroup].self) { groupsData in
                    let isIn = appUser.groups.compactMap {$0.value == "incoming" ? nil : $0.key}
                    groups = groupsData.compactMap {isIn.contains($0.value.gid) && $0.value.gid != "_" ? $0.value : nil}
                }
            }
            
            
            HStack {
                Button {
                    showingImagePicker = true
                } label: {
                    Text("Upload Image")
                        .font(Constants.textFont)
                }
                Button {
                    if(images.count > 0){
                    showingSelectedImages = true
                    }
                } label: {
                    Text("\(images.count) images")
                        .font(Constants.textFont)
                        .foregroundColor(.highlight)
                }
            }
            Button(action: addReview) {
                Text("Post Review")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(width: 220, height: 60)
                    .background(Color.highlight)
                    .cornerRadius(15.0)
            }
            .alert("Foods With Friends", isPresented: $showingIncompleteAlert) {
                Button("OK") {
                    showingIncompleteAlert = false
                }
            } message: {
                Text("You have not completed your review!")
            }
            .alert(isPresented: $showingBodylessAlert) {
                Alert (
                    title: Text("Foods With Friends"),
                    message: Text("Your post has no body. Are you sure you want to post with no body?"),
                    primaryButton: .default(Text("Post")) {
                        reviewtext = " "
                        addReview()
                    },
                    secondaryButton: .cancel()
                )
            }
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) { image in
            if let image = image {
                images.append(image)
                print(image)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .sheet(isPresented: $showRestaurants) {
            if waiting {
                Text("Fetching restaurant data")
                    .font(Constants.titleFont)
            }
            List {
                ForEach($data.response.restaurants) {restaurant in
                    Button {
                        self.restaurant = restaurant.wrappedValue
                        showRestaurants = false
                    } label: {
                        RestaurantListView(restaurant: restaurant)
                    }
                }
            }
            .listStyle(.grouped)
        }
        .sheet(isPresented: $showingSelectedImages) {
            
            TabView {
                ForEach(images, id:\.self) { image in
                    VStack {
                        Image(uiImage: image)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                        Button {
                            images.removeAll {$0==image}
                        } label: {
                            Text("Remove")
                                .font(Constants.textFont)
                                .padding()
                                .padding(.bottom, 25)
                                .accentColor(.highlight)
                                .cornerRadius(10)
                        }
                    }
                }
            }
            .tabViewStyle(PageTabViewStyle())
            .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
        }
    }
}
struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(selectedTab: .constant(.NewPostView))
    }
}
