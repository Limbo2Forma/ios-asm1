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
    Download from Url: https://stackoverflow.com/questions/37978773/swift-how-to-download-synchronously
    Read from Directory: https://www.hackingwithswift.com/example-code/system/how-to-read-the-contents-of-a-directory-using-filemanager
*/

import Foundation

class ReadCSV {
    
    // download the CSV from the url then store to the path
    // the download is sync, the download must be complete to process to next steps of the app
    // exit the program if the download is error
    func downloadFromUrl(url: URL, path: URL) -> Void {
        if let downloadedData = NSData(contentsOf: url) {
            if downloadedData.write(to: path, atomically: true) {
                print("updated data\n")
            } else {
                print("error update data\n")
                exit(1)
            }
        } else {
            print("cant download\n")
            exit(1)
        }
    }

    // read the CSV and return a raw array of string with each row of the CSV is an element
    func getCSVData(url: URL) -> Array<String> {
        
        // get the path to the user Documents folder
        let docDir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let path = docDir.appendingPathComponent(url.lastPathComponent)
        
        // start download
        downloadFromUrl(url: url, path: path)
        
        do {
            let content = try String(contentsOf: path)
            var parsedCSV: [String] = content.components(
                separatedBy: "\n"
            )
            
            // remove the exceed '\n' and the first column name row
            parsedCSV.removeFirst()
            parsedCSV.removeLast()
            return parsedCSV
        }
        catch {
            print(error)
            return []
        }
    }
}
