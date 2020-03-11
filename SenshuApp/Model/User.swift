//
//  UserData.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/11.
//  Copyright © 2020 remuty. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class User: ObservableObject {
    @Published var id = ""
    @Published var password = ""
    
    func login(id:String, pw:String, completion: @escaping (Bool) -> Void) {
        let url = "https://cp.ss.senshu-u.ac.jp"
        let parameters: [String: String] = [
            "userId": id,
            "password": pw
        ]
        AF.request(url + "/lms/lginLgir/login",method: .post,parameters: parameters).response { response in
            if let html = response.value{
                if let doc = try? HTML(html: html!, encoding: .utf8) {
                    //ログイン判定をする
                    if let _ = doc.at_xpath("//*[@id='cs_loginInfo']"){
                        UserDefaults.standard.set(id, forKey: "id")
                        UserDefaults.standard.set(pw, forKey: "password")
                        self.id = id
                        self.password = pw
                        completion(false)
                    }else{
                        completion(true)
                    }
                }
            }
        }
    }
    
    func load() {
        if UserDefaults.standard.string(forKey: "id") != nil {
            self.id = UserDefaults.standard.string(forKey: "id")!
            self.password = UserDefaults.standard.string(forKey: "password")!
        }
    }
    
    func delete() {
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "password")
        self.id = ""
        self.password = ""
    }
}
