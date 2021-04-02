//
//  CollectionViewController.swift
//  SwiftUIImageCreator
//
//  Created by 小西壮 on 2021/03/19.
//

import UIKit
import RealmSwift

class CollectionViewController: UIViewController {

    let reportDatabase = ReportDatebase()
    
    @IBOutlet weak var reportTableView: UITableView!
    var refreshControl = UIRefreshControl()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        reportTableView.delegate = self
        reportTableView.dataSource = self
        reportTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(CollectionViewController.refresh(sender:)), for: .valueChanged)
        
        reportDatabase.getAll()
        print("Report",reportDatabase.database)
        
        // Do any additional setup after loading the view.
    }
    

    @objc func refresh(sender: UIRefreshControl) {
        
        reportDatabase.database.removeAll()
        reportDatabase.getAll()
        reportTableView.reloadData()
        refreshControl.endRefreshing()
    }

}

extension CollectionViewController:UITableViewDelegate,UITableViewDataSource{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reportDatabase.database.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        print("tableview")
        let cell = tableView.dequeueReusableCell(withIdentifier: "reportCell", for: indexPath) as? ReportTableViewCell
        cell?.dateLabel!.text = reportDatabase.database[indexPath.row]["date"] as? String
        cell?.placeLabel!.text = String(reportDatabase.database[indexPath.row]["placeName"]! as! String)
        cell?.todoLabel!.text = String(reportDatabase.database[indexPath.row]["todoText"]! as! String)
        
        cell?.layoutIfNeeded()
        
        return cell!
        
    }
    
    //ボタンが押されたのを検知したときの処理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "taskDetail", sender: indexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "taskDetail"{
            
            if self.reportTableView.indexPathForSelectedRow != nil{
                //遷移先のViewControllerを格納
                let reportViewController = segue.destination as! ReportViewController
                //遷移先の変数に代入
                reportViewController.taskID = (sender as? Int)! + 1
            }
            
        }
    }
    
}
