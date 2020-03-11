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
    @State private var error = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 30) {
                Text("ログイン")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                VStack {
                    HStack {
                        Text("ユーザーID")
                            .font(.headline)
                        Spacer()
                    }
                    TextField("", text: self.$id)
                }.padding()
                
                VStack {
                    HStack {
                        Text("パスワード")
                            .font(.headline)
                        Spacer()
                    }
                    SecureField("", text: self.$password)
                    VStack {
                        HStack {
                            Text("※情報科学センターのID・パスワードを使用してください")
                            Spacer()
                        }
                        if self.error {
                            HStack {
                                Text("※IDまたはパスワードが間違っています")
                                    .foregroundColor(Color.red)
                                Spacer()
                            }
                        }
                    }
                }.padding()
                
                Button(action: {
                    self.userData.login(id: self.id, pw: self.password,completion: {(err) in
                        self.error = err
                    })
                }) {
                    Text("ログイン")
                }
            }.frame(width: geometry.size.width / 2)
        }.frame(minWidth: 400,minHeight: 450)
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}
