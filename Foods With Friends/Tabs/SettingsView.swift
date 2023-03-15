//
//  SettingsView.swift
//  Foods With Friends
//
//  Created by Busra Coskun (student LM) on 3/7/23.
//

import SwiftUI

struct SettingsView: View {
    @Binding var viewState: ViewState
    var body: some View {
        List {
            Text("Settings view")
            Button {
                UserDefaults.standard.removeObject(forKey: "userID")
                viewState = .login
            } label: {
                Text("Log Out")
                    .font(Constants.titleFont)
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(viewState: Binding.constant(.home))
    }
}
