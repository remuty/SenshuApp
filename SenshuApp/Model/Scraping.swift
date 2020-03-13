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
    @Published var scheduleData = [[ScheduleData]](repeating: [ScheduleData](repeating: ScheduleData(), count: 6), count: 6)
    @Published var dates = [String](repeating: "", count: 6)
    
    //CoursePowerから課題状況を取得
    func fetchTask(_ user: User){
        let url = "https://cp.ss.senshu-u.ac.jp"
        var parameters: [String: String] = [
            "userId": user.id,
            "password": user.password
        ]
        var data:[TaskData] = []
        self.taskData = []
        
        //ログイン
        AF.request(url + "/lms/lginLgir/login",method: .post,parameters: parameters).response { response in
            if let html = response.value{
                if let doc = try? HTML(html: html!, encoding: .utf8) {
                    //講義名と講義idを抽出
                    for node in doc.xpath("//*[@id='timetable']//td[contains(text(),'限') or contains(text(),'period')]/following-sibling::td[2]/a"){
                        var id = node["onclick"]!
                        id = id.replacingOccurrences(of: "formSubmit('", with: "")
                        id = id.replacingOccurrences(of: "')", with: "")
                        data.append(TaskData(lectureName: node.text!, lectureId: id))
                    }
                    if data.count != 0{
                        fetchEachLecture(i: 0)
                    }
                }
            }
        }
        
        //講義ごとの未提出・未参照状況取得
        func fetchEachLecture(i:Int) {
            parameters = ["kougiId": data[i].lectureId]
            AF.request(url + "/lms/homeHoml/linkKougi",method: .post,parameters: parameters).response { response in
                if let html = response.value{
                    if let doc = try? HTML(html: html!, encoding: .utf8) {
                        for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), '未提出') or contains(text(), 'Not submitted')]"){
                            data[i].notSubmitted += 1
                        }
                        for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), '未参照') or contains(text(), 'Not viewed')]"){
                            data[i].notViewed += 1
                        }
                        if data[i].notSubmitted != 0 || data[i].notViewed != 0 {
                            self.taskData.append(data[i])
                        }
                        if i < data.count - 1{
                            fetchEachLecture(i: i + 1)
                        }
                    }
                }
            }
        }
        
    }
    
    //ポータルから授業スケジュールを取得
    func fetchSchedule(_ user: User){
        let url = "https://sps.acc.senshu-u.ac.jp/ActiveCampus"
        let parameters: [String: String] = [
            "login": user.id,
            "passwd": user.password,
            "mode": "Login",
            "clickcheck": "0",
        ]
        var data = [[ScheduleData]](repeating: [ScheduleData](repeating: ScheduleData(), count: 6), count: 6)
        var dates = [String](repeating: "", count: 6)
        
        AF.request(url + "/module/Login.php",method: .post,parameters: parameters).response{ response in
            AF.request(url + "/module/MyPage.php").response { response in
                if let html = response.value{
                    if let doc = try? HTML(html: html!, encoding: .utf8) {
                        //日付を取得
                        for i in 0..<6 {
                            if let s = doc.at_xpath("//*[@id='ac979df3a192202adc435da109f41c7396']//tr[1]/th[\(i + 1)]")?.text{
                                dates[i] = s.trimmingCharacters(in: .whitespacesAndNewlines)
                            }
                        }
                        self.dates = dates
                    }
                }
                //TODO: 本番環境のデータを使う処理に書き換える
                //テスト用のデータ(後期の内容)取得
                AF.request(url + "/module/Jikanwari.php?mode=latter").response { response in
                    if let html = response.value{
                        if let doc = try? HTML(html: html!, encoding: .utf8) {
                            //日・時限ごとの内容を抽出
                            for i in 0..<6 {
                                for j in 0..<6 {
                                    let path = "//*[@id='portlet_acPortlet_0']/table[1]/tr[\(i + 3)]/td[\(j + 1)]"
                                    if let img = doc.at_xpath("\(path)/img") {
                                        data[i][j].status = img["title"]
                                    }
                                    if var s = doc.at_xpath("\(path)/a")?.text{
                                        data[i][j].lecture = s
                                        s = (doc.at_xpath("\(path)/text()[4]")?.text)!
                                        data[i][j].teacher = s.trimmingCharacters(in: .whitespacesAndNewlines)
                                        s = (doc.at_xpath("\(path)/text()[5]")?.text)!
                                        data[i][j].classroom = s.trimmingCharacters(in: .whitespacesAndNewlines)
                                    }
                                }
                            }
                            self.scheduleData = data
                        }
                    }
                }
            }
        }
    }
}
