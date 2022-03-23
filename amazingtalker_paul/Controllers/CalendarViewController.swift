//
//  CalendarViewController.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:CalendarViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViewModel()
    }
    
    func setupViewModel() {
        viewModel = CalendarViewModel()
        viewModel.completionUpdateUI = {
            DispatchQueue.main.async {[weak self] in
                guard let weakSelf = self else { return }
                weakSelf.setupTableView()
            }
        }
        viewModel.initWeekDate()
    }
    
    func setupTableView() {
        tableView.register(UINib(nibName: "\(CalendarControlCell.self)", bundle: nil), forCellReuseIdentifier: "\(CalendarControlCell.self)")
        tableView.register(UINib(nibName: "\(CalendarContentCell.self)", bundle: nil), forCellReuseIdentifier: "\(CalendarContentCell.self)")
        tableView.dataSource = self
        tableView.reloadData()
    }

}
extension CalendarViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return configControlView(tableView, cellForRowAt: indexPath)
        case 1:
            return configContentView(tableView, cellForRowAt: indexPath)
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
}

extension CalendarViewController {
    
    func configControlView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let controlCell = tableView.dequeueReusableCell(withIdentifier: "\(CalendarControlCell.self)", for: indexPath) as! CalendarControlCell
        controlCell.dateRangeLabel.text = "\(viewModel.dates.first!.getFormatter(format: "YYYY/MM/dd"))-\(viewModel.dates.last!.getFormatter(format: "MM/dd"))"
        controlCell.timezoneLabel.text = "*時間以 \(TimeZone.current.identifier)時間 \(TimeZone.current.abbreviation()!)顯示"
        controlCell.preWeekButton.isEnabled = !viewModel.lockPreWeek
        controlCell.preWeekClousure = {[weak self] in
            guard let weakSelf = self,!weakSelf.viewModel.lockPreWeek else { return }
            weakSelf.viewModel.preWeekDates()
        }
        controlCell.nextWeekClousure = {[weak self] in
            guard let weakSelf = self else { return }
            weakSelf.viewModel.nextWeekDates()
        }
        return controlCell
    }
    
    func configContentView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentCell = tableView.dequeueReusableCell(withIdentifier: "\(CalendarContentCell.self)", for: indexPath) as! CalendarContentCell
        contentCell.collectionView.register(UINib(nibName: "\(CalendarDayCell.self)", bundle: nil), forCellWithReuseIdentifier: "\(CalendarDayCell.self)")
        contentCell.collectionView.collectionViewLayout = UICollectionViewLayout()
        contentCell.dataSource = CollectionViewDataSource(cellIdentifier: "\(CalendarDayCell.self)", items: viewModel.dates, configCell: configDayCell)
        contentCell.collectionView.dataSource = contentCell.dataSource
        contentCell.collectionView.reloadData()
        
        return contentCell
    }
    
    func configDayCell(dayCell:CalendarDayCell,day:Date) {
        dayCell.weekDayLabel.text = day.weekDayText()
        dayCell.dayLabel.text = day.getFormatter(format: "d")
        
        dayCell.weekDayLabel.textColor = viewModel.isPast(day: day) ? .lightGray : .black
        dayCell.dayLabel.textColor = viewModel.isPast(day: day) ? .lightGray : .black
        
        dayCell.tableView.register(UINib(nibName: "\(CalendarTimeCell.self)", bundle: nil), forCellReuseIdentifier: "\(CalendarTimeCell.self)")
        let viewModels = generalTimeViewModel().filter({$0.time.getFormatter(format: "YYYY/MM/dd") == day.getFormatter(format: "YYYY/MM/dd")})
        
        dayCell.dataSource = TableViewDataSource(cellIdentifier: "\(CalendarTimeCell.self)", items: viewModels, configCell: self.configTimeCell)
        dayCell.tableView.dataSource = dayCell.dataSource
        dayCell.tableView.reloadData()
    }
    
    func configTimeCell(timeCell:CalendarTimeCell,viewModel:CalendarTimeViewModel) {
        timeCell.timeLabel.text = viewModel.time.getFormatter(format: "hh:mm")
        timeCell.timeLabel.textColor = viewModel.isAvailable ? .green : .lightGray
    }
    
    ///傳入Day內的Range時間
    func generalTimeViewModel() -> [CalendarTimeViewModel] {
        print(self.viewModel.scheduleData.booked.count)
        let availableTimes = self.viewModel.scheduleData.available.map { item -> TimeRange in
            var data = item
            data.isAvailable = true
            return data
        }
        let bookedTimes = self.viewModel.scheduleData.booked.map { item -> TimeRange in
            var data = item
            data.isAvailable = false
            return data
        }
        let times = availableTimes+bookedTimes
        print("times",times.count)
        var res = [CalendarTimeViewModel]()
        
        for time in times {
            let endTime = time.end.ISOToDate()
            var currentTime = time.start.ISOToDate()
            print("start",currentTime,endTime)
            while currentTime.compare(endTime) != .orderedSame {
                print(currentTime,endTime)
                currentTime = currentTime.addMin(30)
                res.append(CalendarTimeViewModel(isAvailable: time.isAvailable!, time: currentTime))
                
            }
            
        }
        return res
    }
}
