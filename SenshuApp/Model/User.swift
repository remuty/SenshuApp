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
    @Published var toDo:[[TaskDetailData]] = [[],[]]
    let userDefaults = UserDefaults.standard
    let dateFmt = DateFormatter()
    
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
        if let id = userDefaults.string(forKey: "id"){
            self.id = id
        }
        if let pw = userDefaults.string(forKey: "password"){
            self.password = pw
        }
        if let toDo = userDefaults.array(forKey: "toDo") as? [Data]{
            self.toDo = toDo.map { try! JSONDecoder().decode([TaskDetailData].self, from: $0) }
        }
    }
    
    func save() {
        userDefaults.set(self.id, forKey: "id")
        userDefaults.set(self.password, forKey: "password")
        let toDoData = self.toDo.map { try? JSONEncoder().encode($0) }
        userDefaults.set(toDoData, forKey: "toDo")
    }
    
    func delete() {
        userDefaults.removeObject(forKey: "id")
        userDefaults.removeObject(forKey: "password")
        userDefaults.removeObject(forKey: "toDo")
        self.id = ""
        self.password = ""
        self.toDo = [[],[]]
    }
    
    func addToDo(data: TaskDetailData) {
        self.toDo[0].append(data)
        sortToDo()
    }
    
    //ToDo,Doneのタスクを移動させる
    func moveToDo(i:Int, j:Int) {
        if i == 0{
            toDo[1].append(toDo[i][j])
        }else if i == 1{
            toDo[0].append(toDo[i][j])
        }
        toDo[i].remove(at: j)
        sortToDo()
    }
    
    //提出期限で並べ替え
    func sortToDo() {
        toDo[0].sort { $0.deadline < $1.deadline }
        toDo[1].sort { $0.deadline < $1.deadline }
    }
    
    //提出期限後ならtrueを返す
    func isAfterDeadline(data:TaskDetailData) -> Bool {
        dateFmt.dateStyle = .medium
        dateFmt.locale = Locale(identifier: "ja_JP")
        let now = Date()
        if let deadline = dateFmt.date(from: String(data.deadline.suffix(10))){
            if now > deadline {
                return true
            }else{
                return false
            }
        }
        return false
    }
}
