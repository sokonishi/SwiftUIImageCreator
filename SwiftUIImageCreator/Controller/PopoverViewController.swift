//
//  PopoverViewController.swift
//  SwiftUIImageCreator
//
//  Created by 小西壮 on 2021/03/30.
//

import UIKit

class PopoverViewController: UIViewController {

    @IBOutlet weak var reportImage: UIImageView!
    @IBOutlet weak var textLabel: UILabel!
    var report:UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textLabel.text = "hogehgoe"
        reportImage.image = report
        // Do any additional setup after loading the view.
    }
    
    @IBAction func saveButton(_ sender: UIButton) {
        print("保存")
        UIImageWriteToSavedPhotosAlbum(self.report,self,
            #selector(self.didFinishSavingImage(_:didFinishSavingWithError:contextInfo:)),nil)
        
    }
    @objc func didFinishSavingImage(_ image: UIImage, didFinishSavingWithError error: NSError!, contextInfo: UnsafeMutableRawPointer) {
       
       // 結果によって出すアラートを変更する
       var title = "保存完了"
       var message = "カメラロールに保存しました"
       let ok = "OK"
       
       if error != nil {
           title = "エラー"
           message = "保存に失敗しました"
       }
       
       let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
       alertController.addAction(UIAlertAction(title: ok, style: .default, handler: { _ in
           
       }))
       self.present(alertController, animated: true, completion: nil)
    }

}
