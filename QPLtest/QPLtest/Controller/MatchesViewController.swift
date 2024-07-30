//
//  MatchesViewController.swift
//  QPLtest
//
//  Created by Bender on 25.07.2024.
//

import UIKit
import SnapKit
import Alamofire

class MatchesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private let tour14TableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let tour15TableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private let tour14Label: UILabel = {
        let label = UILabel()
        label.text = "Тур 14"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    private let tour15Label: UILabel = {
        let label = UILabel()
        label.text = "Тур 15"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    var tour14Matches: [String] = []
    var tour15Matches: [MatchDetails] = []

    private var tour14TableHeightConstraint: Constraint?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Матчи"
        

        tour14TableView.delegate = self
        tour14TableView.dataSource = self
        tour14TableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchTableViewCell")
        
   
        tour15TableView.delegate = self
        tour15TableView.dataSource = self
        tour15TableView.register(UpcomingMatchesTableViewCell.self, forCellReuseIdentifier: "UpcomingMatchCell")
        
        view.addSubview(tour14Label)
        view.addSubview(tour14TableView)
        view.addSubview(tour15Label)
        view.addSubview(tour15TableView)
        
        tour14Label.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.leading.equalToSuperview().offset(16)
        }
        
        tour14TableView.snp.makeConstraints { make in
            make.top.equalTo(tour14Label.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()

            tour14TableHeightConstraint = make.height.equalTo(200).constraint
        }
        
        tour15Label.snp.makeConstraints { make in
            make.top.equalTo(tour14TableView.snp.bottom).offset(16)
            make.leading.equalToSuperview().offset(16)
        }
        
        tour15TableView.snp.makeConstraints { make in
            make.top.equalTo(tour15Label.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
        }
        
        fetchTour14Fixtures()
        fetchTour15Fixtures()
    }
    
    func fetchTour14Fixtures() {
        APIManager.shared.fetchFixtures { [weak self] resultsArray in
            guard let self = self else { return }
            self.tour14Matches = resultsArray
            DispatchQueue.main.async {
                self.tour14TableView.reloadData()
                self.updateTour14TableViewHeight()
            }
        }
    }
    
    func fetchTour15Fixtures() {
        APIManager.shared.fetchTour15Fixtures { [weak self] matchDetailsArray in
            guard let self = self else { return }
            self.tour15Matches = matchDetailsArray
            DispatchQueue.main.async {
                self.tour15TableView.reloadData()
            }
        }
    }
    
    func updateTour14TableViewHeight() {
        let rowHeight: CGFloat = 80
        let numberOfRows = CGFloat(tour14Matches.count)
        let totalHeight = rowHeight * numberOfRows
        tour14TableHeightConstraint?.update(offset: totalHeight)
        

        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tour14TableView {
            return tour14Matches.count
        } else if tableView == tour15TableView {
            return tour15Matches.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == tour14TableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as? MatchTableViewCell else {
                return UITableViewCell()
            }
            cell.matchLabel.text = tour14Matches[indexPath.row]
            return cell
        } else if tableView == tour15TableView {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "UpcomingMatchCell", for: indexPath) as? UpcomingMatchesTableViewCell else {
                return UITableViewCell()
            }
            let matchDetails = tour15Matches[indexPath.row]
            cell.configure(with: matchDetails)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
