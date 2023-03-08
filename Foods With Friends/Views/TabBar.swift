//
//  TabBar.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/6/23.
//

import SwiftUI

struct TabBar: View {
    @Binding var current: String
    var image: String = ""
    @Namespace var animation
    
    var body: some View {
        Button{
            withAnimation{current = image}
        } label: {
            VStack(spacing: 5) {
                Image(systemName: image)
                    .font(.title2)
                    .foregroundColor(current == image ? Color.highlight : Color.black.opacity(0.3))
                //default frame to avoid resizing
                    .frame(height: 35)
                ZStack{
                    
                    //matched geometry effect slide animation
                    if current == image{
                        Rectangle()
                            .fill(Color.clear)
                            .frame(height: 4)
                            .matchedGeometryEffect(id: "Tab", in: animation)
                    }
                }
            }
        }
    }
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        TabBar(current: Binding.constant("value"))
    }
}
