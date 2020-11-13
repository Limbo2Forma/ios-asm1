/*
  RMIT University Vietnam
  Course: COSC2659 iOS Development
  Semester: 2020C
  Assessment: Assignment 1
  Author: Vu Hai Nam
  ID: 3694383
  Created  date: 10/11/2020
  Last modified: 14/11/2020
  Acknowledgement: Lecturer Quang Tran
    Custom sort order: https://stackoverflow.com/questions/36587104/swift-equivalent-of-java-tostring/36587136
    String padding to print: https://stackoverflow.com/questions/36587104/swift-equivalent-of-java-tostring/36587136
*/

import Foundation

class Leaderboard {
    
    // default variables, init empty all teams dict and an empty all teams array
    private var teamsDict = [String: Team]()
    private var teamArr = [Team]()

    // read a string of a match from the CSV to update the teams statistic
    func readMatch(match:String) -> Void {
        
        // remove the last '\n' char and seperate the component of the string
        var matchCopy = match
        matchCopy.removeLast()
        let info = matchCopy.components(separatedBy: ",")
        
        // info[5] is the result of the match, if the lenght > 2 means the match have a result, else the match has been canceled or not happen yet
        if info[5].count > 2 {
            
            // get the stats from the match
            let homeTeam = info[3]
            let awayTeam = info[4]
            let homeScore = Int(info[5].components(separatedBy: " - ")[0])
            let awayScore = Int(info[5].components(separatedBy: " - ")[1])
            
            
            // append the stats to the team, new team will be added to the dict and the current team will have update, the key of the dict is the team name
            var homeTeamStats = Team(teamName: homeTeam)
            if let stats = teamsDict[homeTeam] {
                homeTeamStats = stats
            }
            homeTeamStats.addMatch(teamScore: homeScore!, opponentScore: awayScore!)
            teamsDict[homeTeam] = homeTeamStats

            var awayTeamStats = Team(teamName: awayTeam)
            if let stats = teamsDict[awayTeam] {
                awayTeamStats = stats
            }
            awayTeamStats.addMatch(teamScore: awayScore!, opponentScore: homeScore!)
            teamsDict[awayTeam] = awayTeamStats
        }
    }
    
    
    // sorted the dict by the order of the points of the teams and their goal diff if 2 teams have same points
    func orderPlacement() -> Void {
        // first convert to array so it can be sorted
        teamArr = Array(teamsDict.values.map{ $0 })
        
        // sort by order
        teamArr = teamArr.sorted(by: {($0.getPoint() > $1.getPoint()) || ($0.getPoint() == $1.getPoint() && $0.getGoalDiff() < $1.getGoalDiff())})
    }
    
    // printed out the leaderboard
    func printLeaderboard() -> Void {
        
        // print the base column names
        print(" Pos\tClub\t\t\tMP\tW\tD\tL\tGF\tGA\tGD\t Pts\t Last 5")
        print(String("").padding(toLength: 72, withPad: "-", startingAt: 0))
        
        // print the teams and their positions
        for (position,team) in teamArr.enumerated() {

            // padding so the 1 digit have extra space similar to 2 digit
            let posString = String(position + 1).padding(toLength: 3, withPad: " ", startingAt: 0)
            
            if position <= 3 {   // top 4 is attending C1 league, so have 🔷 in their pos
                print("🔷", posString, team)
                continue
            }
            if position == 4 {   // 5th position is attending C2 league, have 🔸 in their pos
                print("🔸", posString, team)
                continue
            }
            if position >= 17 {  // last 3 is demoted to League 2, have 🔻 in their pos
                print("🔻", posString, team)
                continue
            }
            // else print out normally
            print("  ", posString, team)
        }
    }
    
    
    // init the leaderboard with the raw data read from the CSV, then process each match to update the team statistics
    init(data: Array<String>) {
        for i in data {
            readMatch(match: i)
        }
        orderPlacement()
    }
}
