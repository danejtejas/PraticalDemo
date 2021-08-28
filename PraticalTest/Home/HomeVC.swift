//
//  HomeVC.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit
import Firebase


class CustomCollectionView: UICollectionView {
    override func layoutSubviews() {
        super.layoutSubviews()
        if !(__CGSizeEqualToSize(bounds.size,self.intrinsicContentSize)){
            self.invalidateIntrinsicContentSize()
        }
    }
    override var intrinsicContentSize: CGSize {
        return contentSize
    }
}


class HomeVC: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var poolData : [PoolData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        getData()

    }
    
    func getData()  {
        poolData = AppUtility.getJsonData() ?? []
        tableView.reloadData()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        setNav()
    }
    
    
    fileprivate  func setNav()  {
        navigationController?.isNavigationBarHidden = false
        navigationController?.setNavigationBarHidden(false, animated: false)
    }

    
    @IBAction func logoutButtonClick(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            AppUtility.setIsLogin(value: false)  // logout user
            AppUtility.moveToLoginVC()
        } catch  {
            print("error singout ", error.localizedDescription)
        }
        
        
    }
    
   

}


extension  HomeVC : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return poolData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for:   indexPath) as! TableViewCell
        cell.lblPoolNanme.text = "POOL " + poolData[indexPath.row].poolName!
        cell.teams = poolData[indexPath.row].teams ?? []
        
        return cell
    }
}


extension  HomeVC : UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}
