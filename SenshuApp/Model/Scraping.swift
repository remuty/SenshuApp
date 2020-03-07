//
//  Scraping.swift
//  SenshuApp
//
//  Created by remuty on 2020/03/07.
//  Copyright © 2020 remuty. All rights reserved.
//

import Foundation
import Alamofire
import Kanna

class Scraping: ObservableObject {
    @Published var taskData:[TaskData] = []
    @Published var scheduleData:[[String]] = []
    
    let id = ""
    let pwd = ""
    
    //CoursePowerから課題状況を取得
    func fetchTask(){
        let url = "https://cp.ss.senshu-u.ac.jp"
        var parameters: [String: String] = [
            "userId": self.id,
            "password": self.pwd,
        ]
        var data:[TaskData] = []
        
        //ログイン
        AF.request(url + "/lms/lginLgir/login",method: .post,parameters: parameters).response { response in
            if let html = response.value{
                if let doc = try? HTML(html: html!, encoding: .utf8) {
                    //講義名と講義idを抽出
                    for node in doc.xpath("//*[@id='timetable']//td[contains(text(),'限')]/following-sibling::td[2]/a"){
                        var id = node["onclick"]!
                        id = id.replacingOccurrences(of: "formSubmit('", with: "")
                        id = id.replacingOccurrences(of: "')", with: "")
                        data.append(TaskData(lectureName: node.text!, lectureId: id))
                    }
                }
            }
            //講義ごとの未提出・未参照状況取得
            for i in 0..<data.count {
                parameters = ["kougiId": data[i].lectureId]
                AF.request(url + "/lms/homeHoml/linkKougi",method: .post,parameters: parameters).response { response in
                    if let html = response.value{
                        if let doc = try? HTML(html: html!, encoding: .utf8) {
                            for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), '未提出')]"){
                                data[i].notSubmitted += 1
                            }
                            for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), '未参照')]"){
                                data[i].notViewed += 1
                            }
                        }
                    }
                    if i >= data.count - 1{
                        self.taskData = data
                    }
                }
            }
        }
    }
    
    //ポータルから授業スケジュールを取得
    func fetchSchedule(){
        let url = "https://sps.acc.senshu-u.ac.jp/ActiveCampus"
        let parameters: [String: String] = [
            "login": self.id,
            "passwd": self.pwd,
            "mode": "Login",
            "clickcheck": "0",
        ]
        var data = [[String]](repeating: [String](repeating: "", count: 6), count:7)
        
        AF.request(url + "/module/Login.php",method: .post,parameters: parameters).response{ response in
            AF.request(url + "/module/MyPage.php").response { response in
                if let html = response.value{
                    if let doc = try? HTML(html: html!, encoding: .utf8) {
                        //日・時限ごとの内容を抽出
                        for i in 0..<7 {
                            for j in 0..<6 {
                                var s = (doc.at_xpath("//*[@id='ac979df3a192202adc435da109f41c7396']/table/tr[\(i + 2)]/td[\(j + 1)]")?.text)!
                                s = s.replacingOccurrences(of: " ", with: "")
                                s = s.replacingOccurrences(of: "　", with: "")
                                s = s.replacingOccurrences(of: "\n", with: "")
                                data[i][j] = s
                            }
                        }
                        self.scheduleData = data
                    }
                }
            }
        }
    }
}
