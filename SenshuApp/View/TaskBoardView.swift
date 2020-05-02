//
//  TaskBoardView.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskBoardView: View {
    @ObservedObject var user:User
    var body: some View {
        HStack {
            TaskBoard(user: self.user, i: 0, title: "ToDo")
            TaskBoard(user: self.user, i: 1,title: "Done")
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TaskBoard: View {
    @ObservedObject var user:User
    var i:Int
    var title:String
    var body: some View {
        VStack {
            VStack(spacing: 0) {
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .padding(10.0)
                List {
                    ForEach(0..<self.user.toDo[i].count, id: \.self){j in
                        TaskCard(data: self.user.toDo[self.i][j])
                            .padding(.horizontal, 10.0)
                            .padding(.bottom, 7)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                if self.i == 0{
                                    self.user.toDo[1].append(self.user.toDo[self.i][j])
                                }else{
                                    self.user.toDo[0].append(self.user.toDo[self.i][j])
                                }
                                self.user.toDo[self.i].remove(at: j)
                            }
                    }.onDelete(perform: delete)
                }
            }.frame(maxWidth: .infinity)
                .background(Color.accentColor)
                .cornerRadius(10)
        }.padding(.vertical, 10.0)
            .padding(10.0)
    }
    private func delete(at indexSet: IndexSet) {
        self.user.toDo[i].remove(atOffsets: indexSet)
    }
}

struct TaskBoardView_Previews: PreviewProvider {
    static var previews: some View {
        TaskBoardView(user: User()).previewLayout(.fixed(width: 600, height: 450))
    }
}
