//
//  ContentView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var scraping = Scraping()
    var test: [TaskData] = [TaskData(lectureName: "講義名1プログラミング", lectureId: ""),TaskData(lectureName: "講義名2プログラミング", lectureId: ""),TaskData(lectureName: "講義名3プログラミング", lectureId: "")]
    
    var body: some View {
        HStack {
            Text("Hello, World!").frame(maxWidth: .infinity, maxHeight: .infinity)
            //            List(scraping.taskData){ taskData in
            //                VStack {
            //                    TaskRow(taskData: taskData)
            //                    Divider()
            //                }
            //            }.frame(maxWidth: .infinity, maxHeight: .infinity)
            List(test){ taskData in
                VStack {
                    TaskRow(taskData: taskData)
                    Divider()
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(minWidth: 600,minHeight: 350)
        //.onAppear(perform: {self.scraping.fetchTask()})
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
