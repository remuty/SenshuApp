//
//  TaskRow.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskRow: View {
    @ObservedObject(initialValue: Scraping()) var scraping: Scraping
    var body: some View {
        
        VStack {
            Text("Button").onAppear(perform: {//self.scraping.fetchSchedule()
                //self.scraping.fetchTask()
            })
        }.frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct TaskRow_Previews: PreviewProvider {
    static var previews: some View {
        TaskRow()
    }
}
