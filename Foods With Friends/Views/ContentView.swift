//
//  ContentView.swift
//  Foods With Friends
//
//  Created by Speer-Zisook, Ella on 3/1/23.
//

import SwiftUI

struct ContentView: View {
    @State var viewState: ViewState = .login
    @State var dataString: String = "1234567890"
    @State var dir: String = "1234567890"
    var body: some View {
        LoginView(viewState: $viewState)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
