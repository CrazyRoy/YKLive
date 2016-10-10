//
//  ViewController.swift
//  映客直播
//
//  Created by CodeLL on 2016/10/9.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import IJKMediaFramework

class LiveViewController: UIViewController {
    
    var live : YKCell!
    
    var playerView : UIView!
    var ijkPlayer : IJKMediaPlayback!
    
    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var giftBtn: UIButton!
    @IBOutlet weak var likeBtn: UIButton!
    @IBOutlet weak var loadingLabel: UILabel!
    
    @IBAction func tapBack(_ sender: UIButton) {
        
        // 停止播放
        self.ijkPlayer.shutdown()
        
        self.navigationController!.popViewController(animated: true)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    // 礼物烟花动画
    @IBAction func tapGift(_ sender: UIButton) {
        let duration = 3.0
        let p918 = UIImageView(image: #imageLiteral(resourceName: "porsche"))
        
        p918.frame = CGRect(x: 0, y: 0, width: 0, height: 0)
        view.addSubview(p918)
        
        let widthP918:CGFloat = 240
        let heightP918:CGFloat = 120
        
        UIView.animate(withDuration: duration) {
            p918.frame =
                CGRect(x: self.view.center.x - widthP918/2, y: self.view.center.y - heightP918/2, width: widthP918, height: heightP918)
        }
        
        //主线程延时一个完整动画后,再让礼物图片逐渐透明,完全透明后从父视图移除
        DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
            UIView.animate(withDuration: duration, animations: {
                p918.alpha = 0
                }, completion: { (completed) in
                    p918.removeFromSuperview()
            })
        }
        
        let layerFw = CAEmitterLayer()
        view.layer.addSublayer(layerFw)
        emmitParticles(from: sender.center, emitter: layerFw, in: view)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + duration * 2) {
            layerFw.removeFromSuperlayer()
        }
    }
    
    // 点赞爱心动画
    @IBAction func tapLike(_ sender: UIButton) {
        //爱心大小
        let heart = DMHeartFlyView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        
        //爱心的中心位置
        heart.center = CGPoint(x: likeBtn.frame.origin.x, y: likeBtn.frame.origin.y)
        
        view.addSubview(heart)
        heart.animate(in: view)
        
        
        //爱心按钮的 大小变化动画
        let btnAnime = CAKeyframeAnimation(keyPath: "transform.scale")
        btnAnime.values   = [1.0, 0.7, 0.5, 0.3, 0.5, 0.7, 1.0, 1.2, 1.4, 1.2, 1.0]
        btnAnime.keyTimes = [0.0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0]
        btnAnime.duration = 0.2
        sender.layer.add(btnAnime, forKey: "SHOW")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.loadingLabel.isHidden = true
        
        if(!self.ijkPlayer.isPlaying()) {
            self.ijkPlayer.prepareToPlay()   // 播放
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //默认模糊主播头像背景
        setBg()
        
        //准备播放器
        setPlayerView()
        
        // 将按钮调整到最上层
        setBtnsFront()
    }
    
    // MARK:- 设置背景
    func setBg() {
        
        let imageUrl = URL(string: "http://img.meelive.cn/" + live.protrait)
        bgImage.kf.setImage(with: imageUrl)
        
        // 虚化效果
        let blurEffect = UIBlurEffect(style: .light)
        let effectView = UIVisualEffectView(effect: blurEffect)
        effectView.frame = bgImage.bounds
        bgImage.addSubview(effectView)
    }
    
    // MARK:- 将按钮调整到最上层
    func setBtnsFront() {
        self.view.bringSubview(toFront: self.backBtn)
        self.view.bringSubview(toFront: self.giftBtn)
        self.view.bringSubview(toFront: self.likeBtn)
        self.view.bringSubview(toFront: self.loadingLabel)
    }

    func setPlayerView() {
        // 用于显示播放器的视图
        self.playerView = UIView(frame : view.bounds)
        view.addSubview(self.playerView)
        
        // 创建播放器
        ijkPlayer = IJKFFMoviePlayerController(contentURLString: live.url, with: nil)
        let pv = ijkPlayer.view!
        
        pv.frame = playerView.bounds
        pv.autoresizingMask = [.flexibleWidth, .flexibleWidth]
        
        // 将播放的view添加到视图中
        playerView.addSubview(pv)
        
        // 自适应缩放
        ijkPlayer.scalingMode = .aspectFill
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

