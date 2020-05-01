//
//  TaskDetailData.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/19.
//  Copyright © 2020 remuty. All rights reserved.
//

import Foundation

struct TaskDetailData: Codable,Hashable{
    var lectureName:String
    var status:String
    var taskName:String
    var deadline:String
    
    init(_ lectureName:String, _ status:String, _ taskName:String, _ deadline:String){
        self.lectureName = lectureName
        self.status = status
        self.taskName = taskName
        self.deadline = deadline
    }
}
