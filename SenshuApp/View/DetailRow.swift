//
//  DetailRow.swift
//  SenshuApp
//
//  Created by remuty on 2020/04/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct DetailRow: View {
    var body: some View {
        VStack {
            HStack {
                Text("課題名").font(.headline)
                Spacer()
                Text("未提出").font(.body)
                    .foregroundColor(Color.green)
                Text("提出期限").font(.body)
            }
            Divider()
        }
    }
}

struct DetailRow_Previews: PreviewProvider {
    static var previews: some View {
        DetailRow().previewLayout(.fixed(width: 300, height: 50))
    }
}
