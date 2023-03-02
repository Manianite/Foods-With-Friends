//
//  ContentView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack{
            Text("Hello, world!")
                .padding()
                .font(Constants.textFont)
                .foregroundColor(Color.highlight)
            Text("Hello, world!")
                .padding()
                .font(Constants.titleFont)
                .foregroundColor(Color.highlight)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
