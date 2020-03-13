//
//  ScheduleCell.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/09.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct ScheduleCell: View {
    var schedule: ScheduleData
    var body: some View {
        ZStack{
            VStack(spacing: 10) {
                Text(schedule.lecture)
                Text(schedule.teacher)
                Text(schedule.classroom)
            }
            if schedule.status != nil{
                Text(schedule.status!)
                    .font(.body)
                    .fontWeight(.semibold)
                    .padding(2)
                    .background(Color.blue)
            }
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
        .border(Color.gray)
    }
}

struct ScheduleCell_Previews: PreviewProvider {
    static var previews: some View {
        ScheduleCell(schedule: ScheduleData(status: "休講",lecture: "[講義名]", teacher: "教員名", classroom: "教室名")).previewLayout(.fixed(width: 100, height: 100))
    }
}
