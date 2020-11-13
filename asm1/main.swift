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
*/

import Foundation

func main() -> Void {
    
    // url to download the CSV
    let url = URL(string: "https://fixturedownload.com/download/epl-2020-GMTStandardTime.csv")!
    
    // downloading the CSV to the user Documents folder, then process to read the file from the Folder
    let data = ReadCSV().getCSVData(url: url)
    
    // Create and print out the leaderboard from the raw data read from the CSV
    let leaderboard = Leaderboard(data: data)
    leaderboard.printLeaderboard()
}

main()
