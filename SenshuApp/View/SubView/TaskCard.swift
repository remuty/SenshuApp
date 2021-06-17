//
//  TaskCard.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskCard: View {
    var user:User
    var data:TaskDetailData
    var body: some View {
        HStack {
            Color.accentColor
                .frame(width: 13)
            VStack {
                HStack {
                    Text(self.data.lectureName)
                    Text(self.data.taskName)
                    Spacer()
                }.font(.headline)
                if user.isAfterDeadline(data: data){
                    Text(self.data.deadline).foregroundColor(.red)
                }else{
                    Text(self.data.deadline)
                }
            }.font(.body)
                .padding(7.0)
        }.frame(maxWidth: .infinity)
            .border(Color.accentColor,width: 2)
            .cornerRadius(5)
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard(user: User(), data: TaskDetailData(lectureName: "講義名", taskName: "レポート", status: "", deadline: "提出期限:2020/11/11")).previewLayout(.fixed(width: 300, height: 0))
    }
}
