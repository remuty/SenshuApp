//
//  ContentView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var scraping = Scraping()
    
    var body: some View {
        GeometryReader { geometry in
            
            HStack(spacing: 0) {
                
                VStack(spacing: 0) {
                    ForEach(0..<6){ i in
                        HStack(spacing: 0) {
                            ForEach(0..<6){ j in
                                ScheduleCell(schedule: self.scraping.scheduleData[i][j])
                            }
                        }
                    }
                }.frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack {
                    List(self.scraping.taskData){ taskData in
                        VStack {
                            TaskRow(taskData: taskData)
                            Divider()
                            
                        }
                    }.frame(width: geometry.size.width / 3)
                    Button(action: {self.scraping.fetchTask()}) {
                        Text(/*@START_MENU_TOKEN@*/"Button"/*@END_MENU_TOKEN@*/)
                    }
                }
                
            }
        }.frame(minWidth: 600,minHeight: 450)
            .onAppear(perform: {self.scraping.fetchSchedule()
                print("fetchsc")
            })
            .onAppear(perform: {self.scraping.fetchTask()
                print("fetchta")
            })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
