//
//  TaskRow.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    var taskData: TaskData
    var body: some View {
        HStack {
            Text(taskData.lectureName)
                .font(.headline)
            Spacer()
            VStack {
                Text("未提出 \(taskData.notSubmitted)")
                    .font(.body)
                    .foregroundColor(Color.green)
                Text("未参照 \(taskData.notViewed)")
                    .font(.body)
                    .foregroundColor(Color.pink)
            }
        }
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow(taskData: TaskData(lectureName: "講義名プログラミング", lectureId: "")).previewLayout(.fixed(width: 300, height: 50))
    }
}
