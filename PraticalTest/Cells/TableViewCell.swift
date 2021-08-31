//
//  TableViewCell.swift
//  PraticalTest
//
//  Created by admin on 28/08/21.
//

import UIKit

enum Header : Int, CaseIterable {
    case rank
    case name
    case w
    case l
    case mr
    case wTotal
    case ps
    case pa
    case pr
    
    var title : String {
        
        switch self {
        
        case .rank:
            return "Rank"
        case .name:
            return "Team Name"
        case .w:
            return "W"
        case .l:
            return "L"
        case .mr:
            return "MR"
        case .wTotal:
            return "W"
        case .ps:
            return "PS"
        case .pa:
            return "PA"
        case .pr:
            return "PR"
        }
        
    }
    
}


class TableViewCell: UITableViewCell {
    @IBOutlet weak var collectionView: CustomCollectionView!
    
    @IBOutlet weak var lblPoolNanme: UILabel!
    
    var teams : [Team] = [] {
        didSet {
            collectionView.reloadData()
            self.collectionView.layoutIfNeeded()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.dataSource = self
        collectionView.delegate = self
        
    }
    
    
    
}


extension TableViewCell  : UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return   teams.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Header.allCases.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell =  collectionView.dequeueReusableCell(withReuseIdentifier: "DataCollectionViewCell" , for: indexPath) as! DataCollectionViewCell
        
        var data : String = ""
        
        if indexPath.section == 0 {
            data =  Header.init(rawValue: indexPath.row)?.title ?? ""
            cell.backgroundColor = #colorLiteral(red: 0.1922997534, green: 0.1840691566, blue: 0.1964299083, alpha: 1)
            cell.lblData.textColor = .yellow
        }
        else
        {
            cell.lblData.textColor = #colorLiteral(red: 0.3372146487, green: 0.3372780979, blue: 0.3372106552, alpha: 1)
            if  indexPath.section / 2 == 0  {
                cell.backgroundColor = #colorLiteral(red: 0.9646012187, green: 0.9647662044, blue: 0.9645908475, alpha: 1)
            }
            else
            {
                cell.backgroundColor = #colorLiteral(red: 0.949088037, green: 0.9409831166, blue: 0.9532163739, alpha: 1)
            }
            
            let t = teams[indexPath.section - 1]
            
            let colum =  Header.init(rawValue: indexPath.row)
            
            switch colum
            {
            
            case .rank:
                data =  "\(t.rank ?? 0)"
            case .name:
                data = t.name ?? ""
            case .w:
                data =  "\(t.matches?.w ?? 0)"
            case .l:
                data =  "\(t.matches?.l ?? 0)"
            case .mr:
                data =  "\(t.matches?.mr ?? 0 )"
            case .wTotal:
                data =  "\(t.total?.w ?? 0)"
            case .ps:
                data =  "\(t.total?.ps ?? 0)"
            case .pa:
                data =  "\(t.total?.pa ?? 0)"
            case .pr:
                data =  "\(t.total?.pr ?? 0)"
                
            case .none:
                data = ""
            }
            addLognPress(cell: cell)
        }
        cell.lblData.text = data.uppercased()
        
        return cell
    }
    
    
    private func addLognPress( cell : UICollectionViewCell){
        let tapGesture = UILongPressGestureRecognizer(target: self, action: #selector(lognPressHandler) )
        cell.addGestureRecognizer(tapGesture)
    }
    
    @objc func lognPressHandler( guesture : UILongPressGestureRecognizer)  {
        
        guard  guesture.state == .began else { return  }
        
        let point =  guesture.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: point)
        
        if let indexPath = indexPath  {
            
            let alertVC = UIAlertController(title: "Delete?", message: "Are you sure delete this recorder ?", preferredStyle: .alert)
            
            alertVC.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
                self.teams.remove(at: indexPath.section - 1)
                self.collectionView.reloadData()
            }))
            
            alertVC.addAction(UIAlertAction(title: "No", style: .cancel, handler:nil))
            
            var tempVC : UIViewController?
            if #available(iOS 13, *)
            {
                if let scene = UIApplication.shared.connectedScenes.first {
                    guard let windowScene = scene as? UIWindowScene else { return  }
                    tempVC = windowScene.windows.first?.rootViewController
                }
            }
            else
            {
                tempVC = UIApplication.shared.keyWindow?.rootViewController
            }
            if var topVC = tempVC
            {
                while let presentedViewController = topVC.presentedViewController {
                    topVC = presentedViewController
                }
                topVC.present(alertVC, animated: true, completion: nil)
            }
            
        }
        
    }
    
}

extension TableViewCell  : UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let colum =  Header.init(rawValue: indexPath.row)
        
        switch colum  {
        
        case .rank:
            return CGSize(width: 70, height: 40)
        case .name:
            return CGSize(width: 200, height: 40)
        case .w, .l, .mr, .wTotal, .ps, .pa,  .pr:
            return CGSize(width: 50, height: 40)
        case .none:
            return CGSize(width: 100, height: 40)
        }
        
        return CGSize(width: 100, height: 40)
    }
    
    
    
}


extension TableViewCell  : UICollectionViewDelegate {
    
}
