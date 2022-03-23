//
//  CollectionViewDataSource.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit
import Foundation

class CollectionViewDataSource<CELL:UICollectionViewCell,T>: NSObject,UICollectionViewDataSource {
    
    private var cellIdentifier:String!
    
    private var items:[T]!
    
    var configCell: (CELL,T) -> () = { _,_ in }
    
    init(cellIdentifier: String, items: [T], configCell: @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configCell = configCell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = items[indexPath.row]
        
        self.configCell(cell, item)
        
        return cell
    }
    
}
