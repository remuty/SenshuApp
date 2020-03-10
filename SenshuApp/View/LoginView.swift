//
//  LoginView.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/10.
//  Copyright © 2020 remuty. All rights reserved.
//

import SwiftUI

struct LoginView: View {
    var userData = UserData()
    @State private var id = ""
    @State private var password = ""
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                Spacer()
                Text("ログイン")
                    .font(.title)
                Spacer()
                
                VStack {
                    Text("ユーザーID")
                        .font(.headline)
                    TextField("", text: self.$id).frame(width: geometry.size.width / 2)
                }.padding()
                
                VStack {
                    Text("パスワード")
                        .font(.headline)
                    SecureField("", text: self.$password).frame(width: geometry.size.width / 2)
                }.padding()
                
                Button(action: {
                    self.userData.set(id: self.id, pw: self.password)
                }) {
                    Text("ログイン")
                }
                Spacer()
            }
        }.frame(minWidth: 400,minHeight: 450)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
