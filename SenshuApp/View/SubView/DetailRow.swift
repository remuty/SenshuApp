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
    var body: some View {
        VStack {
            HStack {
                Text("課題名").font(.headline)
                Text("未提出").font(.body)
                    .foregroundColor(Color.green)
                Text("提出期限").font(.body)
                Spacer()
                Text("ToDo")
                    .padding(.horizontal, 10)
                    .frame(maxHeight: .infinity)
                    .background(Color.accentColor)
                    .cornerRadius(10)
                    .contentShape(Rectangle())
                    .onTapGesture {self.user.addToDo()}
            }
            Divider()
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow(user: User()).previewLayout(.fixed(width: 300, height: 50))
    }
}
