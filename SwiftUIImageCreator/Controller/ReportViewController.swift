//
//  ReportViewController.swift
//  SwiftUIImageCreator
//
//  Created by 小西壮 on 2021/03/19.
//

import UIKit
import RealmSwift

class ReportViewController: UIViewController,UIPopoverPresentationControllerDelegate {

    let reportDatebase = ReportDatebase()
    let popoverView = PopoverViewController()
    var taskID:Int!
    var image:UIImage!
    
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var purposeLabel: UILabel!
    @IBOutlet weak var placeLabel: UILabel!
    @IBOutlet weak var todoLabel: UILabel!
    @IBOutlet weak var detailText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dateLabel.text = reportDatebase.getDate(id: taskID!).date
        purposeLabel.text = reportDatebase.getDate(id: taskID!).purposeText
        todoLabel.text = reportDatebase.getDate(id: taskID!).todoText
        placeLabel.text = reportDatebase.getDate(id: taskID!).placeName
        detailText.text = reportDatebase.getDate(id: taskID!).detailText
        
        image = getImage(captureView)
        
    }
    
    @IBAction func captureButton(_ sender: UIButton) {
        print("hogehoge")
    }
    
    // UIViewからUIImageに変換する
    func getImage(_ view : UIView) -> UIImage {
        
        // キャプチャする範囲を取得する
        let rect = view.bounds
        
        // ビットマップ画像のcontextを作成する
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        let context : CGContext = UIGraphicsGetCurrentContext()!
        
        // view内の描画をcontextに複写する
        view.layer.render(in: context)
        
        // contextのビットマップをUIImageとして取得する
        let image : UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        
        // contextを閉じる
        UIGraphicsEndImageContext()
        
        return image
    }
    
    
    override func prepare (for segue: UIStoryboardSegue, sender: Any?) {
        let storyboard : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)

        let vc = storyboard.instantiateViewController(withIdentifier: "popoverVC") as! PopoverViewController
//        vc.delegate = self
        vc.modalPresentationStyle = UIModalPresentationStyle.popover
        vc.report = image
        
        let popover: UIPopoverPresentationController = vc.popoverPresentationController!
        popover.delegate = self

        if sender != nil {
            if let button = sender {
                // UIButtonからポップアップが出るように設定
                popover.sourceRect = (button as! UIButton).bounds
                popover.sourceView = (sender as! UIView)
            }
        }
        self.present(vc, animated: true, completion:nil)
    }

    // 表示スタイルの設定
    func adaptivePresentationStyle(for controller: UIPresentationController, traitCollection: UITraitCollection) -> UIModalPresentationStyle {
        // .noneを設定することで、設定したサイズでポップアップされる
        return .none
    }
    

}

