//
//  MainView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/11.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct MainView: View {
    @ObservedObject var user:User
    @ObservedObject var scraping:Scraping
    @State var detail = false
    @State var toDo = false
    
    //テスト用データ
    var taskData:TaskData = TaskData(lectureName: "a", lectureId: "0")
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                //メニュー
                HStack(spacing: 0) {
                    ZStack{
                        if !self.toDo{
                            Color.accentColor
                        }else{
                            Color.gray
                        }
                        Text("時間割")
                            .font(.subheadline)
                            .onTapGesture {self.toDo = false}
                    }.frame(width: 60,height: 25)
                    ZStack{
                        if self.toDo{
                            Color.accentColor
                        }else{
                            Color.gray
                        }
                        Text("ToDo")
                            .font(.subheadline)
                            .onTapGesture {self.toDo = true}
                    }.frame(width: 60,height: 25)
                    Spacer()
                    Button(action: {self.scraping.fetchTask(self.user)}) {
                        Text("更新")}
                    Button(action: {self.user.delete()}) {
                        Text("ログアウト")}
                }
                
                HStack(spacing: 0) {
                    if !self.toDo{
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
                    }else{
                        TaskBoardView()
                    }
                    
                    //未提出・未参照リスト
                    ZStack{
                        List(0..<12/*self.scraping.taskData*/){ taskData in
                            TaskRow(taskData: self.taskData)
                                .contentShape(Rectangle())
                                .onTapGesture {self.detail = true}
                        }
                        if self.detail{
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Spacer()
                                    Text("講義名")
                                    Spacer()
                                    Text("×")
                                        .foregroundColor(Color.red)
                                        .padding(.horizontal, 10)
                                        .frame(maxHeight: .infinity)
                                        .contentShape(Rectangle())
                                        .onTapGesture {self.detail = false}
                                }.font(.headline)
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.gray)
                                List(0..<12){_ in
                                    DetailRow()
                                }
                            }
                        }
                        
                    }.frame(width: geometry.size.width / 3)
                }
            }
        }.frame(minWidth: 600,minHeight: 450)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: User(),scraping: Scraping())
    }
}
