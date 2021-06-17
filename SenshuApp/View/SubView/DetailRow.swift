//
//  DetailRow.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct DetailRow: View {
    @ObservedObject var user:User
    
    var data:TaskDetailData
    
    var body: some View {
        VStack {
            HStack {
                Text(data.taskName).font(.headline)
                Text(data.status).font(.body)
                    .foregroundColor(Color.green)
                Text(data.deadline).font(.body)
                Spacer()
                Text("ToDo")
                    .padding(.horizontal, 10)
                    .frame(maxHeight: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .onTapGesture {self.user.addToDo(data: self.data)}
            }
            Divider()
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(user: User(), data: TaskDetailData(lectureName: "講義名",taskName: "レポート",status: "未提出",deadline: "提出期限")).previewLayout(.fixed(width: 300, height: 50))
    }
}
