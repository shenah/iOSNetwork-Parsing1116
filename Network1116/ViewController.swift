//
//  ViewController.swift
//  Network1116
//
//  Created by 503-03 on 19/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imgView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        //문자열을 가져올 URL을 생성
        let url = URL(string: "https://www.naver.com")
        //데이터 가져오기
        let data = try! Data(contentsOf: url!)
        //콘솔에 출력
        //print(data)
        
        //문자열로 변환해서 출력
        let daumString = NSString(data: data, encoding: String.Encoding.utf8.rawValue)
        print(daumString!)
        
        //파일 매니저 객체를 생성
        let fm = FileManager.default
        //도큐먼트 디렉토리 경로를 생성
        let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let docDir = dirPaths[0]
        //파일 경로를 생성
        let filePath = docDir + "/suzi.jpg"
        
        //파일이 없다면
        if fm.fileExists(atPath: filePath) == false{
            //이미지 파일의 내용을 다운로드 받기
            let addr = "http://img.hani.co.kr/imgdb/resize/2018/0518/00502318_20180518.JPG"
            let imageUrl = URL(string: addr)
            let imageData = try! Data(contentsOf: imageUrl!)
            //다운로드 받은 데이터로 파일을 생성
            fm.createFile(atPath: filePath, contents: imageData, attributes: nil)
            print("다운로드")
        }
        let dataBuffer = fm.contents(atPath: filePath)
        //이미지 데이터로 변환
        let image = UIImage(data: dataBuffer!)
        //화면에 출력
        imgView.image = image
    }

}
