//
//  ViewController.swift
//  JSONParsing
//
//  Created by 503-03 on 19/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    //저자 이름과 제목을 저장할 배열
    var titles : [String] = [String]()
    var authors : [String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //URL를 생성
        let url = URL(string: "https://apis.daum.net/search/book?apikey=465b06fae32febacbc59502598dd7685&q=java&output=json")
        //외부 데이터를 다운로드
        let data = try! Data(contentsOf: url!)
        
        //다운로드 받은 데이터가 JSON 형식이라면 파싱해서 디셔너리로 변환
        let result = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
        
        //channel 키 값을 디셔너리로 가져오기
        let channel = result["channel"] as! NSDictionary
        
        //item 키의 값을 배열로 가져오기
        let items = channel["item"] as! NSArray
        
        for index in 0...(items.count-1){
            let item = items[index] as! NSDictionary
            titles.append(item["title"] as! String)
            authors.append(item["author"] as! String)
        }
        
        tableView.dataSource = self
    }
}

//기능확장 - extension
extension ViewController : UITableViewDataSource{
    //행의 개수를 설정하는 메소드
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    //cell를 만들어주는 메소드
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        
        //셀의 내용 설정
        cell.textLabel?.text = titles[indexPath.row]
        cell.detailTextLabel?.text = authors[indexPath.row]
        
        return cell
    }
    
    
}

