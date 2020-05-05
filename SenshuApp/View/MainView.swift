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
    @State var detailIdx = -1
    @State var isToDo = false
    //テスト用データ
    @State var taskData:[TaskData] = []
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 0) {
                
                //メニュー
                HStack(spacing: 0) {
                    ZStack{
                        if !self.isToDo{
                            Color.accentColor
                        }else{
                            Color.gray
                        }
                        Text("時間割")
                            .font(.subheadline)
                            .onTapGesture {self.isToDo = false}
                    }.frame(width: 60,height: 25)
                    ZStack{
                        if self.isToDo{
                            Color.accentColor
                        }else{
                            Color.gray
                        }
                        Text("ToDo")
                            .font(.subheadline)
                            .onTapGesture {self.isToDo = true}
                    }.frame(width: 60,height: 25)
                    Spacer()
                    Button(action: {self.scraping.fetchTask(self.user)}) {
                        Text("更新")}
                    Button(action: {self.user.delete()}) {
                        Text("ログアウト")}
                }
                
                HStack(spacing: 0) {
                    if !self.isToDo{
                        //時間割
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
                        //タスクボード(ToDo)
                        TaskBoardView(user: self.user)
                    }
                    
                    //未提出・未参照リスト
                    ZStack{
                        List(self.taskData/*self.scraping.taskData*/){data in
                            TaskRow(taskData: data)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    if let idx = self.taskData.firstIndex(where: {$0.lectureName == data.lectureName}) {
                                        self.detailIdx = idx
                                    }
                            }
                        }
                        //詳細表示
                        if self.detailIdx != -1{
                            VStack(spacing: 0) {
                                HStack(spacing: 0) {
                                    Spacer()
                                    Text(self.taskData[self.detailIdx].lectureName)
                                    Spacer()
                                    Text("×")
                                        .padding(.horizontal, 10)
                                        .frame(maxHeight: .infinity)
                                        .contentShape(Rectangle())
                                        .onTapGesture {self.detailIdx = -1}
                                }.font(.headline)
                                    .frame(height: 30)
                                    .frame(maxWidth: .infinity)
                                    .background(Color.accentColor)
                                
                                List(self.taskData[self.detailIdx].detailData, id: \.self){
                                    DetailRow(user: self.user, data:$0)
                                }
                            }
                        }
                        
                    }.frame(width: geometry.size.width / 3)
                }
            }
        }
            //テストデータ
            .onAppear(perform: {
                for i in 0..<5{
                    self.taskData.append(TaskData(lectureName: "講義名\(i)", lectureId: "0"))
                }
                for i in 0..<self.taskData.count{
                    for j in 0..<5 {
                        self.taskData[i].detailData.append(TaskDetailData(lectureName: self.taskData[i].lectureName, taskName: "課題\(j)", status: "未提出", deadline: "提出期限:2020/0\(i + 1)/0\(j + 1)"))
                    }
                }
            })
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(user: User(),scraping: Scraping())
    }
}
