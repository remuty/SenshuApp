//
//  ContentView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var userData = UserData()
    
    var body: some View {
        VStack {
            if userData.id != "" {
                MainView()
            }else{
                LoginView(userData: userData)
            }
            Button(action: {
                self.userData.delete()
            }) {
                Text("ログアウト")
            }
        }.onAppear(perform: {self.userData.load()})
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
