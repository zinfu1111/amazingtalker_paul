//
//  CalendarContentCell.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarContentCell: UITableViewCell {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    var dataSource:CollectionViewDataSource<CalendarDayCell,Date>!
    
}
