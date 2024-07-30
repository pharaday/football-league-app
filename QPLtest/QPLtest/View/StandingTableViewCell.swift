//
//  StandingsTableViewCell.swift
//  QPLtest
//
//  Created by Bender on 29.07.2024.
//

import UIKit
import SnapKit

class StandingsTableViewCell: UITableViewCell {

    private let rankLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let playedLabel = UILabel()
    private let winLabel = UILabel()
    private let drawLabel = UILabel()
    private let loseLabel = UILabel()
    private let goalsForLabel = UILabel()
    private let goalsAgainstLabel = UILabel()
    private let goalsDiffLabel = UILabel()
    private let pointsLabel = UILabel()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI() {
        // Create a stack view with fixed widths for each label
        let stackView = UIStackView(arrangedSubviews: [rankLabel, teamNameLabel, playedLabel, winLabel, drawLabel, loseLabel, goalsForLabel, goalsAgainstLabel, goalsDiffLabel, pointsLabel])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .fill
        
        contentView.addSubview(stackView)
        

        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
        

        let labels = [rankLabel, teamNameLabel, playedLabel, winLabel, drawLabel, loseLabel, goalsForLabel, goalsAgainstLabel, goalsDiffLabel, pointsLabel]
        labels.forEach { label in
            label.font = UIFont.systemFont(ofSize: 14)
            label.textAlignment = .left
        }
        

        rankLabel.snp.makeConstraints { make in
            make.width.equalTo(15)
        }
        teamNameLabel.snp.makeConstraints { make in
            make.width.equalTo(30)
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
    }

    func configure(with standing: Standing) {
        rankLabel.text = "\(standing.rank)"
        teamNameLabel.text = standing.team.name
        playedLabel.text = "\(standing.all.played)"
        winLabel.text = "\(standing.all.win)"
        drawLabel.text = "\(standing.all.draw)"
        loseLabel.text = "\(standing.all.lose)"
        goalsForLabel.text = "\(standing.all.goals.for)"
        goalsAgainstLabel.text = "\(standing.all.goals.against)"
        goalsDiffLabel.text = "\(standing.goalsDiff)"
        pointsLabel.text = "\(standing.points)"
    }
}
