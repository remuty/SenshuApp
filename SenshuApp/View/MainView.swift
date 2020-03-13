//
//  MainView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/11.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var scraping:Scraping
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack(spacing: 0) {
                VStack(spacing: 0) {
                    HStack(spacing: 0) {
                        ForEach(0..<6){
                            if $0 == 0{
                                Text("").frame(maxWidth: 30, maxHeight: 30)
                            }
                            Text(self.scraping.dates[$0]).frame(maxWidth: .infinity, maxHeight: 30)
                        }.border(Color.gray)
                    }
                    ForEach(0..<6){ i in
                        HStack(spacing: 0) {
                            Text("\(i + 1)").frame(maxWidth: 30, maxHeight: .infinity)
                                .border(Color.gray)
                            ForEach(0..<6){ j in
                                ScheduleCell(schedule: self.scraping.scheduleData[i][j])
                            }
                        }
                    }
                }
                
                List(self.scraping.taskData){ taskData in
                    VStack {
                        TaskRow(taskData: taskData)
                        Divider()
                    }
                }.frame(width: geometry.size.width / 3)
            }
            
        }.frame(minWidth: 600,minHeight: 450)
    }
}


struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(scraping: Scraping())
    }
}
