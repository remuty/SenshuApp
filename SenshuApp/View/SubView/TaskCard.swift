//
//  TaskCard.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct TaskCard: View {
    var body: some View {
        HStack {
            VStack {
                Text("課題名")
                    .font(.headline)
                Text("提出期限")
                    .font(.body)
            }.padding(7.0)
                .foregroundColor(Color.black)
            Spacer()
            Text(" > ")
                .font(.headline)
                .frame(maxHeight: .infinity)
                .background(Color.accentColor)
                .onTapGesture {}
        }.frame(maxWidth: .infinity)
            .background(Color.white)
            .cornerRadius(5)
    }
}

struct TaskCard_Previews: PreviewProvider {
    static var previews: some View {
        TaskCard().previewLayout(.fixed(width: 300, height: 0))
    }
}
