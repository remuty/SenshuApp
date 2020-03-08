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
    var notSubmitted:Int
    var notViewed:Int
    
    init(lectureName:String, lectureId:String){
        self.lectureName = lectureName
        self.lectureId = lectureId
        self.notSubmitted = 0
        self.notViewed = 0
    }
}
