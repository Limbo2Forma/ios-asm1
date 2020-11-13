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
    Printable object as string: https://stackoverflow.com/questions/36587104/swift-equivalent-of-java-tostring/36587136
    String padding to print: https://stackoverflow.com/questions/36587104/swift-equivalent-of-java-tostring/36587136
*/

import Foundation

// use CustomStringConvertible to print out the class description as a string in print() function, the detail is below
class Team: CustomStringConvertible {
    
    // default variables
    private var name = ""
    private var win = 0
    private var draw = 0
    private var lost = 0
    private var goalFor = 0
    private var goalAgainst = 0
    private var last5:[String] = []
    
    // get the calculated stats such as goalDiff is goalFor - goalAgainst
    func getGoalDiff() -> Int { return goalFor - goalAgainst }
    func getPoint() -> Int { return win * 3 + draw }
    func getMatchPlayed() -> Int { return win + lost + draw }
    
    // printed out the last 5 match as a string
    func printLast5() -> String {
        var str = ""
        for i in last5 {
            str = str + i + " "
        }
        return str
    }
    
    // init with the team name
    init(teamName: String) {
        name = teamName
    }
    
    // add the result of the match to update the current stats of the team
    func addMatch(teamScore: Int, opponentScore: Int) -> Void {
        
        // update the goalFor and goalAgainst
        goalFor = goalFor + teamScore
        goalAgainst = goalAgainst + opponentScore
        
        // update the win/draw/loss, also updating the last 5 matches result
        if (teamScore > opponentScore) {
            win = win + 1
            addLast5(result: "✔️")
        }
        if (teamScore == opponentScore) {
            draw = draw + 1
            addLast5(result: "➖")
        }
        if (teamScore < opponentScore) {
            lost = lost + 1
            addLast5(result: "❌")
        }
    }
    
    // add new result to the last 5 matches results, using a queue structure to remove the oldest result and append the new result
    func addLast5(result: String) -> Void {
        if last5.count  == 5 {
            last5.removeFirst()
        }
        last5.append(result)
    }
    
    // a function to represent the Team statistic as a string to use in the print() function
    public var description: String {
        
        // padding the team name with " " to give an even length for tabbing the result
        let namePadded = name.padding(toLength: 14, withPad: " ", startingAt: 0)
        
        return namePadded + "\t" + String(getMatchPlayed()) + "\t" + String(win) + "\t" + String(draw) + "\t" + String(lost) + "\t" + String(goalFor) + "\t" + String(goalAgainst) + "\t" + String(getGoalDiff()) + "\t " + String(getPoint()) + "\t " + printLast5()
    
    }
}
