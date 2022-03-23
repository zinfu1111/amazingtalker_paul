//
//  CalendarViewController.swift
//  amazingtalker_paul
//
//  Created by 連振甫 on 2022/3/23.
//

import UIKit

class CalendarViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var contentView:CalendarContentCell?
    var viewModel:CalendarViewModel!
    var dayCellTabelViewModel = [CalendarTimeViewModel]()
    
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
                weakSelf.dayCellTabelViewModel = weakSelf.viewModel.generalTimeViewModel()
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
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {[weak self] in
            
            let today = Date()
            guard let weakSelf = self,let contentView = weakSelf.contentView else { return }
            
            contentView.activityIndicatorView.isHidden = true
            if weakSelf.viewModel.dates.first(where: {$0.getFormatter(format: DateTimeFormatter.YearDate) == today.getFormatter(format: DateTimeFormatter.YearDate)}) != nil {
                let index = IndexPath(row: today.weekDay().rawValue, section: 0)
                contentView.collectionView.scrollToItem(at: index, at: .right, animated: false)
            }
            
            
        }
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
        controlCell.dateRangeLabel.text = "\(viewModel.dates.first!.getFormatter(format: DateTimeFormatter.YearDate))-\(viewModel.dates.last!.getFormatter(format: DateTimeFormatter.MonthAndDay))"
        controlCell.timezoneLabel.text = "*時間以 \(TimeZone.current.identifier)時間 (\(TimeZone.current.abbreviation()!))顯示"
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
        contentCell.activityIndicatorView.isHidden = false
        contentCell.dataSource = CollectionViewDataSource(cellIdentifier: "\(CalendarDayCell.self)", items: viewModel.dates, configCell: configDayCell)
        contentCell.collectionView.dataSource = contentCell.dataSource
        contentCell.collectionView.reloadData()
        self.contentView = contentCell
        return contentCell
    }
    
    func configDayCell(dayCell:CalendarDayCell,day:Date) {
        
        let viewModels = viewModel.generalTimeViewModel().filter({$0.time.getFormatter(format: DateTimeFormatter.YearDate) == day.getFormatter(format: DateTimeFormatter.YearDate)}).sorted { $0.time.compare($1.time) == .orderedAscending }
        
        dayCell.weekDayLabel.text = day.weekDayText()
        dayCell.dayLabel.text = day.getFormatter(format: DateTimeFormatter.Day)
        
        dayCell.weekDayLabel.textColor = viewModel.isPast(day: day) ? .lightGray : .black
        dayCell.dayLabel.textColor = viewModel.isPast(day: day) ? .lightGray : .black
        
        dayCell.tableView.register(UINib(nibName: "\(CalendarTimeCell.self)", bundle: nil), forCellReuseIdentifier: "\(CalendarTimeCell.self)")
        
        dayCell.dataSource = TableViewDataSource(cellIdentifier: "\(CalendarTimeCell.self)", items: viewModels, configCell: self.configTimeCell)
        dayCell.tableView.dataSource = dayCell.dataSource
        dayCell.tableView.reloadData()
    }
    
    func configTimeCell(timeCell:CalendarTimeCell,viewModel:CalendarTimeViewModel) {
        timeCell.timeLabel.text = viewModel.time.getFormatter(format: DateTimeFormatter.HourMin)
        timeCell.timeLabel.textColor = viewModel.isAvailable ? .green : .lightGray
    }
    
}
