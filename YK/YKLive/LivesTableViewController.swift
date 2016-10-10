//
//  LivesTableViewController.swift
//  映客直播
//
//  Created by CodeLL on 2016/10/9.
//  Copyright © 2016年 coderLL. All rights reserved.
//

import UIKit
import Just
import Kingfisher

class LivesTableViewController: UITableViewController {

    // 直播数据请求地址
    let livelistUrl = "http://service.ingkee.com/api/live/gettop?imsi=&uid=17800399&proto=5&idfa=A1205EB8-0C9A-4131-A2A2-27B9A1E06622&lc=0000000000000026&cc=TG0001&imei=&sid=20i0a3GAvc8ykfClKMAen8WNeIBKrUwgdG9whVJ0ljXi1Af8hQci3&cv=IK3.1.00_Iphone&devi=bcb94097c7a3f3314be284c8a5be2aaeae66d6ab&conn=Wifi&ua=iPhone&idfv=DEBAD23B-7C6A-4251-B8AF-A95910B778B7&osversion=ios_9.300000&count=5&multiaddr=1"
    
    var list : [YKCell] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 请求数据
        loadList()
        
        // 下拉刷新
        self.refreshControl = UIRefreshControl()
        self.refreshControl?.addTarget(self, action: #selector(loadList), for: .valueChanged)
    }
    
    // MARK:- 请求数据
    func loadList() {
        Just.post(livelistUrl) { (r) in
            guard let json = r.json as? NSDictionary else {
                return
            }
            
            let live = YKLiveStream(fromDictionary: json).lives!
            
            self.list = live.map({ (live) -> YKCell in
                return YKCell(protrait: live.creator.portrait, nick: live.creator.nick, location: live.city, viewers: live.onlineUsers, url: live.streamAddr)
            })
            
            OperationQueue.main.addOperation {
                // 刷新表格
                self.tableView.reloadData()
                self.refreshControl?.endRefreshing()
            }
        }
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return self.list.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 530
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "LiveCell") as! LiveTableViewCell
        
        let live = self.list[indexPath.row]

        cell.labelNick.text = live.nick
        cell.labelAddr.text = live.location
        cell.labelViewers.text = "\(live.viewers)"
        
        let imageUrl = URL(string: "http://img.meelive.cn/" + live.protrait)
        
        // 小头像
        cell.imgPor.kf.setImage(with: imageUrl)
        
        // 大头像
        cell.imgBgPor.kf.setImage(with: imageUrl)
        
        return cell
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        // 隐藏导航栏
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        let desVc = segue.destination as! LiveViewController
        
        desVc.live = self.list[tableView.indexPathForSelectedRow!.row]
    }

}
