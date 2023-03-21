//
//  NewPostView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI
class RatingControl: UIStackView {
    private var ratingButtons = [UIButton]()
    var rating = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButtons()
    }
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setupButtons()
    }
    @objc func ratingButtonTapped(_ sender: UIButton) {
        guard let index = ratingButtons.firstIndex(of: sender) else {
            fatalError("The button, \(sender), is not in the ratingButtons array: \(ratingButtons)")
        }
        let rating = index + 1
        for i in 0..<ratingButtons.count {
            ratingButtons[i].isSelected = i < rating
        }
        self.rating = rating
    }
    private func setupButtons() {
        for _ in 0..<5 {
            let button = UIButton()
            
            // Set the button images
            let filledStarImage = UIImage(systemName: "star.fill")
            let emptyStarImage = UIImage(systemName: "star")
            button.setImage(emptyStarImage, for: .normal)
            button.setImage(filledStarImage, for: .selected)
            button.setImage(filledStarImage, for: [.highlighted, .selected])
            button.tintColor = UIColor.orange
            button.translatesAutoresizingMaskIntoConstraints = false
            button.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
            button.widthAnchor.constraint(equalToConstant: 44.0).isActive = true
            addArrangedSubview(button)
            ratingButtons.append(button)
            button.addTarget(self, action: #selector(ratingButtonTapped(_:)), for: .touchUpInside)
        }
    }
}
struct RatingControlWrapper: UIViewRepresentable {
    typealias UIViewType = RatingControl
    @Binding var rating: Int
    @Binding var ratingCount: Int
    func makeUIView(context: Context) -> RatingControl {
        let ratingControl = RatingControl()
        ratingControl.axis = .horizontal
        ratingControl.distribution = .fillEqually
        ratingControl.alignment = .center
        return ratingControl
    }
    func updateUIView(_ uiView: RatingControl, context: Context) {
        uiView.rating = rating
        ratingCount = uiView.rating
    }
}
struct NewPostView: View {
    @State var reviewtext: String = ""
    var image: String = ""
    @State var title: String = ""
    @State private var rating: Int = 0
    @State private var isEditable = true
    @Binding var reviews: [Review]
    @State private var ratingCount: Int = 0
    @State var showingImagePicker = false
    @State var inputImage: UIImage?
    @StateObject var data = FetchRestaurantData()
    @EnvironmentObject var user: User
    @State var query: String = ""
    @State var waiting: Bool = false
    @State var showRestaurants: Bool = false
    @State var restaurant: Restaurant
    func addReview() {
        let newReview = Review(title: title, stars: rating, images: [image], restaurant: "Unknown", uid: "Me", body: reviewtext)
    }
    var body: some View {
        VStack {
            VStack {
                HStack {
                    VStack {
                        Image("profile")
                            .resizable()
                            .frame(width: 50, height: 50)
                        Text("username")
                    }
                    VStack {
                        TextField("Title", text: $title)
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(.horizontal)
                            .disabled(!isEditable)
                        RatingControlWrapper(rating: $rating, ratingCount: $ratingCount)
                            .padding()
                            .disabled(!isEditable)
                    }
                }
                HStack {
                    TextField("Search", text: $query)
                        .padding(.leading)
                    Button {
                        Task {
                            waiting = true
                            await data.getData(query)
                            waiting = false
                        }
                        showRestaurants = true
                    } label: {
                        Text("Go")
                            .foregroundColor(.blue)
                            .padding(.trailing)
                    }
                }
            }
            .navigationViewStyle(.stack)
            .navigationBarHidden(true)
                TextEditor(text: $reviewtext)
                    .border(Color.gray, width: 1)
                    .padding()
                    .disabled(!isEditable)
                Button {
                    showingImagePicker = true
                } label: {
                    Text("Upload Image")
                }
                Button(action: addReview) {
                    Text("Post Review")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(width: 220, height: 60)
                        .background(Color.green)
                        .cornerRadius(15.0)
                }
                .padding()
                .sheet(isPresented: $showingImagePicker) {
                    ImagePicker(image: $inputImage)
                }
                .onChange(of: inputImage) { image in
                    guard let image = image else { return }
                }
            }
        .padding()
        .background(Color.white)
        .cornerRadius(10.0)
        .shadow(radius: 5.0)
        .disabled(!isEditable)
        .sheet(isPresented: $showRestaurants) {
            List {
                ForEach($data.response.restaurants) {restaurant in
                    NavigationLink {
                        RestaurantInfoView(restaurant: restaurant)
                    } label: {
                        RestaurantListView(restaurant: restaurant)
                    }
                }
            }
            .listStyle(.grouped)
        }
    }
}

struct NewPostView_Previews: PreviewProvider {
    static var previews: some View {
        NewPostView(reviewtext: "", image: "", title: "", reviews: .constant([]))
    }
}
