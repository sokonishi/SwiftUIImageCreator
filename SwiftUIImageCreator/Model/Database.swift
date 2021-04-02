//
//  Database.swift
//  SwiftUIImageCreator
//
//  Created by 小西壮 on 2021/03/19.
//

import Foundation
import RealmSwift

class ReportDatebase:Object{
    
    
    @objc dynamic var id = Int()
    @objc dynamic var placeName = String()
    @objc dynamic var purposeText = String()
    @objc dynamic var todoText = String()
    @objc dynamic var detailText = String()
    @objc dynamic var date = String()
    
    var database = [NSDictionary]()
    
    //新規登録
    func create(placeName: String,purposeText: String,todoText: String,detailText:String) {
        //データベース接続
        let realm = try! Realm()
        
        //データの書き込み
        try! realm.write{

            let reportDatabase = ReportDatebase()

            let now = Date()
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy/MM/dd"
            
            reportDatabase.id = (realm.objects(ReportDatebase.self).max(ofProperty: "id") as Int? ?? 0)+1
            reportDatabase.placeName = placeName
            reportDatabase.purposeText = purposeText
            reportDatabase.todoText = todoText
            reportDatabase.detailText = detailText
            reportDatabase.date = formatter.string(from: now as Date)
            
            realm.add(reportDatabase)
            
        }
    }
    
    //取得
    func getAll() {
        let realm = try! Realm()

        //データベースから情報取得
        let database = realm.objects(ReportDatebase.self)

        //配列に入れる
        for value in database {
            let data = ["id": value.id, "placeName": value.placeName,"purposeText":value.purposeText,"todoText":value.todoText,"detailText":value.detailText, "date": value.date] as NSDictionary

            self.database.append(data)
        }
        
        print(database)
    }
    
    //削除
    func deleteAll(){
        let realm = try! Realm()
        
        let database = realm.objects(ReportDatebase.self)
        
        try! realm.write{
            
            realm.delete(database)
            
        }
    }
    
    //特定のデータのみ取得
    //-> Todoみたいな戻り値がある時は受け取る側でletで定義してあげる
    func getDate(id: Int) -> ReportDatebase {

        //DB接続
        let realm = try! Realm()

        //データを取得
        let database = realm.objects(ReportDatebase.self).filter("id = \(id)").first

        print(database)
        //取得したデータを返す
        return database!
    }
    
    //更新
    func update(id: Int,placeName: String,purposeText: String,todoText: String,detailText:String) {
        
        let realm = try! Realm()

        let database = realm.objects(ReportDatebase.self).filter("id = \(id)").first

        //更新する時
        try! realm.write {
            database!.placeName = placeName
            database!.purposeText = purposeText
            database!.todoText = todoText
            database!.detailText = detailText
        }

    }
    
    //削除
    func delete(id: Int) {
        //DBに接続
        let realm = try! Realm()

        //削除するデータを取得
        //.filter("id = 1").firstで条件を絞る.firstは１こ目を取ってくる、実際は無くていい
        let databaseElement = realm.objects(ReportDatebase.self).filter("id = \(id)").first

        //取得したデータを削除する
        try! realm.write {
            realm.delete(databaseElement!)
        }
    }
    
    
}
