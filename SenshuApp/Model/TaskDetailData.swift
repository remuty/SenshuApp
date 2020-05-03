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
    var taskName:String
    var status:String
    var deadline:String
}
