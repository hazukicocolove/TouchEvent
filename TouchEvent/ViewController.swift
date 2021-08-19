//
//  ViewController.swift
//  TouchEvent
//
//  Created by Hazuki Tamura on 2021/08/19.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    var imageNameArray: [String] = ["hoshi","onpu","hana","shitumon"]
   
    //選択しているスタンプ番号
    var imageIndex:Int = 0
    //背景
    @IBOutlet var haikei:UIImageView!
    //スタンプ画像
    var imageView: UIImageView!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //位置の取得
        let touch:UITouch = touches.first!
        let location:CGPoint = touch.location(in: self.view)
        
    //0じゃないつまりスタンプ選択されてる
        if imageIndex != 0{
        //正方形に設定
            imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    //押されたスタンプの画像を設定
            let image:UIImage = UIImage(named: imageNameArray[imageIndex - 1])!
            imageView.image = image
    //タッチ場所に画像置く
            imageView.center = CGPoint(x: location.x, y: location.y)
    //画像表示
            self.view.addSubview(imageView)
        }
    }

    
  
    
    @IBAction func first(){
        imageIndex = 1
    }
    
    @IBAction func second(){
        imageIndex = 2
    }
    
    @IBAction func third(){
        imageIndex = 3
    }
    
    @IBAction func fourth(){
        imageIndex = 4
    }
    
    @IBAction func back(){
        self.imageView.removeFromSuperview()
    }
    
    @IBAction func selectBackground(){
        //pickconのインスタンス
        let imagePickerController :UIImagePickerController = UIImagePickerController()
        //フォトライブラリを使う設定をする
        imagePickerController.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePickerController.delegate = self
        imagePickerController.allowsEditing = true
        //フォトライブラリを呼び出す
        self.present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        //選んだ画像設定
        let image = info[.originalImage]as?UIImage
        //imageを背景に
        haikei.image = image
        //ライブラリ閉じる
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(){
        //画面のスクショ
        let rect :CGRect = CGRect(x: 0, y: 30, width: 320, height: 380)
        UIGraphicsBeginImageContext(rect.size)
        self.view.layer.render(in: UIGraphicsGetCurrentContext()!)
        let capture = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        //保存
        UIImageWriteToSavedPhotosAlbum(capture!, nil, nil, nil)
    }
    
}

