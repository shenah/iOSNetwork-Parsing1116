//
//  RootViewController.swift
//  XMLParsing
//
//  Created by 503-03 on 19/11/2018.
//  Copyright © 2018 shenah. All rights reserved.
//

import UIKit
class Book{
    var id : String!
    var title : String!
    var author : String!
    var summary : String! 
}
class RootViewController: UITableViewController, XMLParserDelegate {
    //파싱에 필요한 변수
    //태그 하나의 하나의 값을 저장할 변수
    var elementValue : String!
    //Book 1개를 저장할 변수
    var book : Book!
    //전체 데이터를 저장할 변수
    var books = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //데이터를 다운로드 받을 주소를 URL 인스턴스로 생성
        let url = URL(string: "http://sites.google.com/site/iphonesdktutorials/xml/Books.xml")
        //데이터를 다운로드 받아서 파싱할 객체 만들기
        let xmlParser = XMLParser(contentsOf: url!)
        //파싱을 수행할 객체 지정
        xmlParser?.delegate = self
        //파싱을 요청하고 결과 받기
        let result = xmlParser?.parse()
        
        if result == true{
            self.title = "파싱 성공"
        }else{
            self.title = "파싱 실패"
        }
        
    }
    
    // 여는 태그 만났을 때
    func parser(_ parser: XMLParser, didStartElement elementName: String, namespaceURI: String?, qualifiedName qName: String?, attributes attributeDict: [String : String] = [:]){
        if elementName == "Book"{
            book = Book()
            //Book 태그에 있는 id 속성의 값을 찾아서 book에 저장
            var dic = attributeDict as Dictionary
            book.id = dic["id"]
            
        }
    }
    //닫는 태그를 만났을 때 호출되는 메소드
    //하나의 객체를 닫는 태그를 만나면 객체를 배열이나 리스트에 저장하고
    //객체 내의 태그를 만났을 때 그 태그에 해당하는 프로퍼티에 데이터를 저장
    func parser(_ parser: XMLParser, didEndElement elementName: String, namespaceURI: String?, qualifiedName qName: String?){
        
        //하나의 객체를 닫는 태그를 만난 경우
        if elementName == "Book"{
            books.append(book)
            
        }else if elementName == "title"{
            book.title = elementValue
        }else if elementName == "author"{
            book.author = elementValue
        }else if elementName == "summary"{
            book.summary = elementValue
        }
        elementValue = nil
    }
    
    //여는 태그와 닫는 태그 사이의 내용을 만났을 때 호출되는 메소드
    //이 메소드는 유일하게 동일한 데이터 가지고 두 번 이상 호출될 수 있는 메소드
    //elementValue의 값이 nil이면 바로 저장하고
    //그렇지 않으면 이전 데이터에 추가해야 합니다.
    //태그에 적는 내용은 하나의 패킷 이하로 만들어지기 때문에 한번에 전송되지만
    //여는 태그와 닫는 태그 사이에 작성하는 내용은
    //하나의 패킷 이상이 될 수 있어서 입니다.
    //이 부분은 다른 네트워크 프로그램을 만들 때도 기억해야 합니다.
    
    func parser(_ parser: XMLParser, foundCharacters string: String){
        if elementValue == nil{
            elementValue = string
        }else{
            elementValue = "\(elementValue!)\(string)"
        }
    }
    
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return books.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let book = books[indexPath.row]
        cell.textLabel?.text = book.title

        return cell
    }
    
    //셀을 선택했을 때 호출되는 메소드
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let book = books[indexPath.row]
        
        let detailViewController = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailViewController.book = book
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
