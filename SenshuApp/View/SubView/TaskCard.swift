//
//  TaskCard.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskCard: View {
    var data:TaskDetailData
    var body: some View {
        HStack {
            Color.accentColor
                .frame(width: 13)
            VStack {
                HStack {
                    Text(self.data.lectureName).font(.headline)
                    Text(self.data.taskName).font(.headline)
                }
                Text("提出期限:\(self.data.deadline)").font(.body)
            }.padding(7.0)
            Spacer()
        }.frame(maxWidth: .infinity)
            .border(Color.accentColor,width: 2)
            .cornerRadius(5)
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard(data: TaskDetailData(lectureName: "講義名", taskName: "レポート", status: "", deadline: "11月11日")).previewLayout(.fixed(width: 300, height: 0))
    }
}
