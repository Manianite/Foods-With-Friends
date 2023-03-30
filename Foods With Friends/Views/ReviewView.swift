//
//  ReviewView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/20/23.
// i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hate swift ui. i hae swift ui. i hate swift ui. i hate swigt ui. i hate swiftu i. i hate swift ui/

import SwiftUI
import struct Kingfisher.KFImage

struct ReviewView: View {
    @Binding var review: Review
    @ObservedObject var poster: PublicUser = PublicUser()
    @State var expanded = false
    var body: some View {
        DisclosureGroup(isExpanded: $expanded) {
            VStack(alignment: .leading) {
                Text(review.body)
                    .font(Constants.textFont)
                    .frame(width: UIScreen.main.bounds.width-62, alignment: .leading)
                    .fixedSize()
                TabView {
                    ForEach(review.images, id:\.self) { image in
                        KFImage(URL(string: image))
                            .placeholder {
                                Image(systemName: "ellipsis")
                            }
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                    }
                }
                .tabViewStyle(PageTabViewStyle())
                .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .always))
                .frame(height: UIScreen.main.bounds.width-40, alignment: .leading)
            }
            .padding(.horizontal, 15)
            .padding(.bottom, 15)
        } label: {
            VStack(alignment: .leading, spacing: 0) {
                Text(review.restaurant)
                    .font(Constants.titleFont)
                Divider()
                    .padding(.bottom, 5)
                HStack {
                    KFImage(URL(string: poster.profilePic))
                        .placeholder {
                            Image(systemName: "person.crop.circle.fill")
                                .resizable()
                                .frame(width: 50, height: 50)
                        }
                        .resizable()
                        .frame(width: 50, height: 50)
                    VStack(alignment: .trailing, spacing: 0) {
                        Text(review.title)
                            .font(Constants.titleFont)
                        Divider()
                        HStack {
                            Text(poster.username)
                                .font(Constants.textFont)
                            
                            Text("@"+poster.handle)
                            .font(Constants.textFontSmall)
                            .accentColor(.highlight)
                        }
                    }
                }
                .padding(.bottom, 5)
                HStack {
                    Text(expanded ? "read less" : "read more")
                        .font(Constants.textFont)
                        .foregroundColor(.highlight)
                    Spacer()
                    Image(systemName: "star.fill")
                    Image(systemName: review.stars>1 ? "star.fill": "star")
                    Image(systemName: review.stars>2 ? "star.fill": "star")
                    Image(systemName: review.stars>3 ? "star.fill": "star")
                    Image(systemName: review.stars>4 ? "star.fill": "star")
                }
                .foregroundColor(.yellow)
            }
            .foregroundColor(.black)
            .padding(.leading)
            .padding(.vertical, 10)
        }
        .accentColor(.clear)
    }
}

struct ReviewView_Previews: PreviewProvider {
    static var previews: some View {
        ReviewView(review: Binding.constant(Review()))
    }
}
