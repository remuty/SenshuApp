//
//  TaskBoardView.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskBoardView: View {
    var body: some View {
        HStack {
            TaskBoard(title: "ToDo")
            TaskBoard(title: "Done")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.accentColor)
    }
}

struct TaskBoard: View {
    var title:String
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(10.0)
                ScrollView {
                    ForEach(0..<7){_ in
                        TaskCard()
                            .padding(.horizontal, 10.0)
                            .padding(.bottom, 7)
                    }
                }
            }.frame(maxWidth: .infinity)
                .background(Color.gray)
                .cornerRadius(10)
        }.padding(.vertical, 10.0)
            .padding(10.0)
    }
}

struct TaskBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskBoardView().previewLayout(.fixed(width: 600, height: 450))
    }
}
