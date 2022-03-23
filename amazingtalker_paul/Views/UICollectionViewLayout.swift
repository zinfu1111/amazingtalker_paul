//
//  UICollectionViewLayout.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class UICollectionViewLayout: UICollectionViewFlowLayout {

    override init (){
        super.init()
        self.scrollDirection = .horizontal
        self.minimumLineSpacing = 0
        self.minimumInteritemSpacing = 0
        self.itemSize = CGSize(width: 100, height: 300)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
}
