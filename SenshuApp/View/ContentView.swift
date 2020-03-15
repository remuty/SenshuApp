//
//  ContentView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var user = User()
    @ObservedObject var scraping = Scraping()
    
    var body: some View {
        
        VStack {
            if user.id != "" {
                VStack(spacing: 0) {
                    HStack {
                        Spacer()
                        Button(action: {self.scraping.fetchTask(self.user)}) {
                            Text("更新")}
                        Button(action: {self.user.delete()}) {
                            Text("ログアウト")}
                    }
                    MainView(scraping: self.scraping).onAppear(perform: {
                        self.scraping.fetchSchedule(self.user)
//                        self.scraping.fetchTask(self.user)
                    })
                }
            }else{
                LoginView(user: self.user)
            }
        }.onAppear(perform: {self.user.load()})
        
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
