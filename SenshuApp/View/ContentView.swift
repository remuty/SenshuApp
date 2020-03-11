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
    @ObservedObject var scraping = Scraping()
    
    var body: some View {
        VStack {
            if userData.id != "" {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {self.scraping.fetchTask()}) {
                            Text("更新")}
                        Button(action: {self.userData.delete()}) {
                            Text("ログアウト")}
                    }
                    MainView(scraping: self.scraping)
                }
            }else{
                LoginView(userData: self.userData)
            }
        }.onAppear(perform: {self.userData.load()})
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(userData: UserData())
    }
}
