//
//  TableViewDataSource.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit
import Foundation

class TableViewDataSource<CELL:UITableViewCell,T>: NSObject,UITableViewDataSource {
    
    private var cellIdentifier:String!
    
    private var items:[T]!
    
    var configCell: (CELL,T) -> () = { _,_ in }
    
    init(cellIdentifier: String, items: [T], configCell: @escaping (CELL, T) -> ()) {
        self.cellIdentifier = cellIdentifier
        self.items = items
        self.configCell = configCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CELL
        
        let item = items[indexPath.row]
        
        self.configCell(cell, item)
        
        return cell
        
    }
    
    
}
