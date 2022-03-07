//
//  UpcomingViewController.swift
//  iosTestApp1
//
//  Created by sangdon kim on 2022/03/07.
//

import UIKit

class UpcomingViewController: UIViewController {

    private let upcomingTable: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Upcoming"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationItem.largeTitleDisplayMode = .always
        
        view.addSubview(upcomingTable)
        upcomingTable.delegate = self
        upcomingTable.dataSource = self
    }

}

extension UpcomingViewController: UITableViewDelegate, UITableViewDataSource {
    
}
