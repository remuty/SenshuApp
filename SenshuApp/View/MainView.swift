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
    @State var detail = false
    var taskData:TaskData = TaskData(lectureName: "a", lectureId: "0")
    
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
                ZStack{
                    List(0..<12/*self.scraping.taskData*/){ taskData in
                        TaskRow(taskData: self.taskData)
                            .contentShape(Rectangle())
                            .onTapGesture {self.detail = true}
                    }
                    if self.detail{
                        HStack(spacing: 0) {
                            Text(" > ")
                                .font(.headline)
                                .frame(maxHeight: .infinity)
                                .background(Color.accentColor)
                                .contentShape(Rectangle())
                                .onTapGesture {self.detail = false}
                            VStack(spacing: 0) {
                                Text("講義名")
                                    .font(.headline)
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                List(0..<12){_ in
                                    DetailRow()
                                }.frame(maxHeight: .infinity)
                            }
                        }
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
