import Foundation

// MARK: - StandingsResponse
struct StandingsResponse: Codable {
    let get: String
    let parameters: StandingsParameters
    let errors: [String]
    let results: Int
    let paging: StandingsPaging
    let response: [LeagueStandings]
}

// MARK: - Standing
struct Standing: Codable {
    let rank: Int
    let team: Team
    let points: Int
    let all: TeamStats // Added for played, win, draw, lose
    let goalsDiff: Int
}

// MARK: - StandingsParameters
struct StandingsParameters: Codable {
    let league: String
    let season: String
}

// MARK: - StandingsPaging
struct StandingsPaging: Codable {
    let current, total: Int
}

// MARK: - LeagueStandings
struct LeagueStandings: Codable {
    let league: StandingsLeague
}

// MARK: - StandingsLeague
struct StandingsLeague: Codable {
    let id: Int
    let name: String
    let country: String
    let logo: String
    let flag: String
    let season: Int
    let standings: [[Standing]] // Changed from TeamStanding to Standing
}

// MARK: - Team
struct Team: Codable {
    let id: Int
    let name: String
    let logo: String
}

// MARK: - TeamStats
struct TeamStats: Codable {
    let played: Int
    let win: Int
    let draw: Int
    let lose: Int
    let goals: TeamGoals
}

// MARK: - TeamGoals
struct TeamGoals: Codable {
    let `for`: Int
    let against: Int
}
