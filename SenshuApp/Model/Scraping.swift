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

class Scraping {
    
    //コースパワーから課題状況を取得
    func fetchTask(id:String, pwd:String, completion: @escaping ([TaskData]) -> Void){
        let url = "https://cp.ss.senshu-u.ac.jp"
        var parameters: [String: String] = [
            "userId": id,
            "password": pwd,
        ]
        var taskData:[TaskData] = []
        
        //ログイン
        AF.request(url + "/lms/lginLgir/login",method: .post,parameters: parameters).response { response in
            if let html = response.value{
                if let doc = try? HTML(html: html!, encoding: .utf8) {
                    //講義名と講義idを抽出
                    for node in doc.xpath("//*[@id='timetable']//td[contains(text(),'period')]/following-sibling::td[2]/a"){
                        var id = node["onclick"]!
                        id = id.replacingOccurrences(of: "formSubmit('", with: "")
                        id = id.replacingOccurrences(of: "')", with: "")
                        taskData.append(TaskData(lectureName: node.text!, lectureId: id))
                    }
                }
            }
            
            //講義ごとの未提出・未参照状況取得
            for i in 0..<taskData.count {
                parameters = ["kougiId": taskData[i].lectureId]
                AF.request(url + "/lms/homeHoml/linkKougi",method: .post,parameters: parameters).response { response in
                    if let html = response.value{
                        if let doc = try? HTML(html: html!, encoding: .utf8) {
                            for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), 'Not submitted')]"){
                                taskData[i].notSubmitted += 1
                            }
                            for _ in doc.xpath("//span[@class='cs_taOpen']/../../following-sibling::td[1]/span[contains(text(), 'Not viewed')]"){
                                taskData[i].notViewed += 1
                            }
                        }
                    }
                    if i >= taskData.count - 1{
                        completion(taskData)
                    }
                }
            }
        }
    }
}
