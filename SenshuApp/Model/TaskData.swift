//
//  TaskData.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import Foundation

struct TaskData: Identifiable{
    var id = UUID()
    
    var lectureName:String
    var lectureId:String
    var notSubmitted:Int = 0
    var notViewed:Int = 0
    var detailData:[TaskDetailData] = /*[] テストデータ->*/[TaskDetailData(lectureName: "", taskName: "課題1", status: "未提出", deadline: "提出期限"),TaskDetailData(lectureName: "", taskName: "課題2", status: "未提出", deadline: "提出期限"),TaskDetailData(lectureName: "", taskName: "課題3", status: "未提出", deadline: "提出期限")]
}
