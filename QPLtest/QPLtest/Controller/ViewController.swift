//
//  ViewController.swift
//  QPLtest
//
//  Created by Bender on 23.07.2024.
//

import UIKit
import SnapKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let resultTableView = UITableView()
    private let standingsTableView = UITableView()
    private let moreButton = UIButton()
    private let standingsTitleLabel = UILabel()
    
    private var matchResults: [String] = []
    private var standings: [Standing] = []
    private var rounds: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        title = "Главная"
        
        setupUI()
        fetchFixtures()
        fetchStandings()
        
//        fetchAllRounds()
    }
    
//    private func fetchAllRounds() {
//        APIManager.shared.fetchAllRounds { [weak self] rounds in
//            guard let self = self else { return }
//            self.rounds = rounds
//            print("Available rounds: \(rounds)")
//        }
//    }
    
    private func setupUI() {
        
        let logoImageView: UIImageView = {
            let imageView = UIImageView()
            imageView.image = UIImage(named: "Image")
            imageView.contentMode = .scaleAspectFit
            return imageView
        }()
        
        view.addSubview(logoImageView)
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(16)
            make.centerX.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(40)
        }
        
        let matchesLabel = UILabel()
        matchesLabel.text = "Матчи"
        matchesLabel.font = UIFont.systemFont(ofSize: 34)
        matchesLabel.textColor = .black
        matchesLabel.textAlignment = .left
        
        view.addSubview(matchesLabel)
        matchesLabel.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        
        let dateLabel = UILabel()
        dateLabel.text = "14 тур"
        dateLabel.font = UIFont.systemFont(ofSize: 18)
        dateLabel.textColor = .black
        dateLabel.textAlignment = .left
        
        view.addSubview(dateLabel)
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(matchesLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.width.equalTo(200)
            make.height.equalTo(30)
        }
        
        moreButton.setTitle("Больше", for: .normal)
            moreButton.setTitleColor(.blue, for: .normal)
            moreButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
            moreButton.addTarget(self, action: #selector(moreButtonTapped), for: .touchUpInside)
            
            view.addSubview(moreButton)
            moreButton.snp.makeConstraints { make in
                make.centerY.equalTo(dateLabel)
                make.trailing.equalToSuperview().inset(16)
                make.width.equalTo(80)
                make.height.equalTo(30) 
            }
        
        resultTableView.delegate = self
        resultTableView.dataSource = self
        resultTableView.register(MatchTableViewCell.self, forCellReuseIdentifier: "MatchTableViewCell")
        resultTableView.separatorStyle = .none
        
        view.addSubview(resultTableView)
        resultTableView.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.height.equalTo(320)
        }
        
        // Setup standings title label
        standingsTitleLabel.text = "Турнирная таблица"
        standingsTitleLabel.font = UIFont.systemFont(ofSize: 20)
        standingsTitleLabel.textColor = .black
        standingsTitleLabel.textAlignment = .left
        
        view.addSubview(standingsTitleLabel)
        standingsTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(resultTableView.snp.bottom).offset(16)
            make.leading.equalToSuperview().inset(16)
            make.width.equalToSuperview().inset(32)
            make.height.equalTo(30)
        }
        
        // Setup for standings table
        standingsTableView.delegate = self
        standingsTableView.dataSource = self
        standingsTableView.register(StandingsTableViewCell.self, forCellReuseIdentifier: "StandingsTableViewCell")
        standingsTableView.separatorStyle = .none
        
        view.addSubview(standingsTableView)
        standingsTableView.snp.makeConstraints { make in
            make.top.equalTo(standingsTitleLabel.snp.bottom).offset(8)
            make.leading.equalToSuperview().inset(16)
            make.trailing.equalToSuperview().inset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(16)
        }
    }

    @objc private func moreButtonTapped() {
     
        if let tabBarController = self.tabBarController {
            tabBarController.selectedIndex = 1
        }
    }

    private func fetchFixtures() {
        APIManager.shared.fetchFixtures { [weak self] resultsArray in
            guard let self = self else { return }
            self.matchResults = Array(resultsArray.prefix(4))
            self.resultTableView.reloadData()
        }
    }

    private func fetchStandings() {
        APIManager.shared.onStandingsFetched = { [weak self] standingsArray in
            guard let self = self else { return }
            self.standings = standingsArray
            self.standingsTableView.reloadData()
        }
        APIManager.shared.fetchStandings()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == resultTableView {
            return matchResults.count
        } else if tableView == standingsTableView {
            return standings.count
        }
        return 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == resultTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "MatchTableViewCell", for: indexPath) as! MatchTableViewCell
            cell.matchLabel.text = matchResults[indexPath.row]
            return cell
        } else if tableView == standingsTableView {
            let cell = tableView.dequeueReusableCell(withIdentifier: "StandingsTableViewCell", for: indexPath) as! StandingsTableViewCell
            let standing = standings[indexPath.row]
            cell.configure(with: standing)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if tableView == standingsTableView {
            let headerView = UIView()
            headerView.backgroundColor = .systemGray4
            headerView.layer.cornerRadius = 10
            headerView.layer.masksToBounds = true
            
            let rankLabel = UILabel()
            rankLabel.text = "№"
            rankLabel.font = UIFont.boldSystemFont(ofSize: 14)
            rankLabel.textAlignment = .left
            
            let teamNameLabel = UILabel()
            teamNameLabel.text = "Клуб"
            teamNameLabel.font = UIFont.boldSystemFont(ofSize: 14)
            teamNameLabel.textAlignment = .left
            
            let playedLabel = UILabel()
            playedLabel.text = "И"
            playedLabel.font = UIFont.boldSystemFont(ofSize: 14)
            playedLabel.textAlignment = .left
            
            let winLabel = UILabel()
            winLabel.text = "В"
            winLabel.font = UIFont.boldSystemFont(ofSize: 14)
            winLabel.textAlignment = .left
            
            let drawLabel = UILabel()
            drawLabel.text = "Н"
            drawLabel.font = UIFont.boldSystemFont(ofSize: 14)
            drawLabel.textAlignment = .left
            
            let loseLabel = UILabel()
            loseLabel.text = "П"
            loseLabel.font = UIFont.boldSystemFont(ofSize: 14)
            loseLabel.textAlignment = .left
            
            let goalsForLabel = UILabel()
            goalsForLabel.text = "Г"
            goalsForLabel.font = UIFont.boldSystemFont(ofSize: 14)
            goalsForLabel.textAlignment = .left
            
            let goalsAgainstLabel = UILabel()
            goalsAgainstLabel.text = "Пр"
            goalsAgainstLabel.font = UIFont.boldSystemFont(ofSize: 14)
            goalsAgainstLabel.textAlignment = .left
            
            let goalsDiffLabel = UILabel()
            goalsDiffLabel.text = "РГ"
            goalsDiffLabel.font = UIFont.boldSystemFont(ofSize: 14)
            goalsDiffLabel.textAlignment = .left
            
            let pointsLabel = UILabel()
            pointsLabel.text = "О"
            pointsLabel.font = UIFont.boldSystemFont(ofSize: 14)
            pointsLabel.textAlignment = .left
            
            let stackView = UIStackView(arrangedSubviews: [rankLabel, teamNameLabel, playedLabel, winLabel, drawLabel, loseLabel, goalsForLabel, goalsAgainstLabel, goalsDiffLabel, pointsLabel])
            stackView.axis = .horizontal
            stackView.spacing = 8
            stackView.distribution = .fill
            
            headerView.addSubview(stackView)
            stackView.snp.makeConstraints { make in
                make.edges.equalToSuperview().inset(8)
            }
            
            // Set width for each label
            rankLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            teamNameLabel.snp.makeConstraints { make in
                make.width.equalTo(220)
            }
            playedLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            winLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            drawLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            loseLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            goalsForLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            goalsAgainstLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            goalsDiffLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            pointsLabel.snp.makeConstraints { make in
                make.width.equalTo(20)
            }
            
            return headerView
        }
        return nil
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if tableView == standingsTableView {
            return 40
        }
        return 0
    }
}
