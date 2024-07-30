//  APICaller.swift
//  QPLtest
//
//  Created by Bender on 27.07.2024.
//

import Foundation
import Alamofire

public class APIManager {
    
    static let shared = APIManager()
    
    let apiKey = "49d8968789b8627dd5c9b0802cffb6cd"
    // 6f0781516a2b3615b34ec0e27250a7d2
    //"3b0e025af6c9a5f6f95bede464735fa8"
    // b81927c99314ea00e9c89020ab9f3f14]        ]
    // 49d8968789b8627dd5c9b0802cffb6cd

    let fixturesURLString = "https://v3.football.api-sports.io/fixtures?league=389&season=2024&date=2024-07-28"
    let fixtures15URLString = "https://v3.football.api-sports.io/fixtures?league=389&season=2024&date=2024-08-03"

    let standingsURLString = "https://v3.football.api-sports.io/standings?league=389&season=2024"
    
    let baseURL = "https://v3.football.api-sports.io"
    
    var onFixturesFetched: (([String]) -> Void)?
    var onStandingsFetched: (([Standing]) -> Void)?
    
    

        func fetchAllRounds(completion: @escaping ([String]) -> Void) {
            let currentRoundURLString = "\(baseURL)/rounds?league=389&season=2024"
            let headers: HTTPHeaders = [
                "x-rapidapi-key": apiKey,
                "x-rapidapi-host": "v3.football.api-sports.io"
            ]
            
            AF.request(currentRoundURLString, headers: headers).responseData { response in
                switch response.result {
                case .success(let data):
                    do {
                        let decoder = JSONDecoder()
                        let roundsModel = try decoder.decode(RoundsModel.self, from: data)
                        
                        let roundNames = roundsModel.response.map { $0.name }
                        
                        DispatchQueue.main.async {
                            completion(roundNames)
                        }
                    } catch {
                        print("JSON decoding error: \(error)")
                        DispatchQueue.main.async {
                            completion([])
                        }
                    }
                case .failure(let error):
                    print("Request error: \(error)")
                    DispatchQueue.main.async {
                        completion([])
                    }
                }
            }
        }

    func fetchTour15Fixtures(completion: @escaping ([MatchDetails]) -> Void) {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "v3.football.api-sports.io"
        ]
        
        AF.request(fixtures15URLString, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let fixturesModel = try decoder.decode(FixturesModel.self, from: data)
                    
                    var resultsArray: [MatchDetails] = []
                    
                    for fixtureResponse in fixturesModel.response {
                        let homeTeam: String
                        let awayTeam: String
                        
            
                        homeTeam = self.extractTeamName(from: fixtureResponse.teams.home)
                        awayTeam = self.extractTeamName(from: fixtureResponse.teams.away)
                        
            
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "MMMM d HH:mm"
                        let matchDate = dateFormatter.string(from: fixtureResponse.fixture.date)
                        
                        let matchResult = "\(homeTeam) vs \(awayTeam)"
                        
                        let matchDetails = MatchDetails(result: matchResult, date: matchDate)
                        resultsArray.append(matchDetails)
                    }
                    
                    DispatchQueue.main.async {
                        completion(resultsArray)
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }


    private func extractTeamName(from teamUnion: AwayUnion) -> String {
        switch teamUnion {
        case .awayClass(let team):
            return team.name.rawValue
        case .integer:
            return "Unknown"
        case .null:
            return "Unknown"
        }
    }


    
    
    func fetchFixtures(completion: @escaping ([String]) -> Void) {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "v3.football.api-sports.io"
        ]
        
        AF.request(fixturesURLString, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    decoder.dateDecodingStrategy = .iso8601
                    let fixturesModel = try decoder.decode(FixturesModel.self, from: data)
                    
                    var resultsArray: [String] = []
                    
                    for fixtureResponse in fixturesModel.response {
                        let homeTeam: String
                        let awayTeam: String
                        
                        if case .awayClass(let homeTeamClass) = fixtureResponse.teams.home {
                            homeTeam = homeTeamClass.name.rawValue
                        } else {
                            homeTeam = "Unknown"
                        }
                        
                        if case .awayClass(let awayTeamClass) = fixtureResponse.teams.away {
                            awayTeam = awayTeamClass.name.rawValue
                        } else {
                            awayTeam = "Unknown"
                        }
                        
                        let homeScore: String
                        let awayScore: String
                        
                        switch fixtureResponse.score.fulltime.home {
                        case .integer(let score):
                            homeScore = String(score)
                        case .awayClass(_), .null:
                            homeScore = "0"
                        }
                        
                        switch fixtureResponse.score.fulltime.away {
                        case .integer(let score):
                            awayScore = String(score)
                        case .awayClass(_), .null:
                            awayScore = "0"
                        }
                        
                        let matchResult = "\(homeTeam) \(homeScore):\(awayScore) \(awayTeam)"
                        resultsArray.append(matchResult)
                    }
                    
                    DispatchQueue.main.async {
                        completion(resultsArray)
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }
    
    
    func fetchStandings() {
        let headers: HTTPHeaders = [
            "x-rapidapi-key": apiKey,
            "x-rapidapi-host": "v3.football.api-sports.io"
        ]
        
        AF.request(standingsURLString, headers: headers).responseData { response in
            switch response.result {
            case .success(let data):
                do {
                    let decoder = JSONDecoder()
                    let standingsModel = try decoder.decode(StandingsResponse.self, from: data)
                    
                    // Flatten standings into a single array
                    let standings = standingsModel.response.flatMap { $0.league.standings.flatMap { $0 } }
                    
                    DispatchQueue.main.async {
                        self.onStandingsFetched?(standings)
                    }
                } catch {
                    print("JSON decoding error: \(error)")
                }
            case .failure(let error):
                print("Request error: \(error)")
            }
        }
    }


    }
