//
//  GroupListView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/23/23.
//

import SwiftUI
import struct Kingfisher.KFImage

struct GroupListView: View {
    var group: PublicFoodGroup
    
    init(group: Binding<FoodGroup>) {
        self.group = PublicFoodGroup(group.wrappedValue)
    }
    init(publicGroup: Binding<PublicFoodGroup>) {
        self.group = publicGroup.wrappedValue
    }
    var body: some View {
        ZStack(alignment: .leading) {
            Color.white
                .padding()
            HStack {
                KFImage(URL(string: group.img))
                    .placeholder {
                        ZStack {
                            Color.black
                                .clipShape(Circle())
                            Color.white
                                .clipShape(Circle())
                                .frame(width: 49, height: 49)
                            Image(systemName: "person.3.fill")
                                .resizable()
                                .frame(width: 55, height: 25)
                                .aspectRatio(contentMode: .fit)
                                .padding(.top, 8)
                        }
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    }
                    .resizable()
                    .frame(width: (UIScreen.main.bounds.width)/6, height: (UIScreen.main.bounds.width)/6)
                    .aspectRatio(contentMode: .fill)
                    .clipShape(Circle())
                    .padding(2)
                VStack {
                    Text(group.name)
                        .font(Constants.titleFont)
                    Text("\(group.count) members")
                        .font(Constants.textFontSmall)
                }
            }
        }
    }
}

struct GroupListView_Previews: PreviewProvider {
    static var previews: some View {
        GroupListView(publicGroup: .constant(PublicFoodGroup()))
    }
}
