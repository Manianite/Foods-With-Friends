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
    @EnvironmentObject var user: User
    var body: some View {
        VStack {
            TextField("data", text: $dataString)
            TextField("location", text: $dir)
            Button {
                DatabaseData.uploadTxtData(dataString, "user/\(user.uid)/filename") { url in
                    dir=""
                    dataString=""
                }
            } label: {
                Text("put")
            }
            Button {
                DatabaseData.readTxtData(location: "user/\(user.uid)/filename") { dataString in
                    print(dataString)
                }
            } label: {
                Text("read")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
