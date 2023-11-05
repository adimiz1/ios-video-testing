//
//  VideoTableController.swift
//  ios-video-testing
//
//  Created by Adi Mizrahi on 02/11/2023.
//

import Foundation
import UIKit

class VideoTableController: NSObject, UITableViewDataSource, UITableViewDelegate {


    var videoLinksData: [String]!

    override init() {
        super.init()
        videoLinksData = self.parsePlist() ?? [String]()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videoLinksData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "VideoPlayerCell") as! VideoPlayerCell
        cell.initPlayer(url: videoLinksData[indexPath.row])
        cell.setDuration()
        if tableView.isCellVisible(section: indexPath.section, row: indexPath.row) {
            cell.isVisible = true
        } else {
            cell.isVisible = false
        }
        return cell
    }

    func parsePlist() -> [String]? {
        if let path = Bundle.main.path(forResource: "video_links", ofType: "plist") {
            let videoDictonary = NSDictionary(contentsOfFile: path)
            if let videoLinks = videoDictonary?.allValues as? [String] {
                return videoLinks
            }

        }
        return nil
    }
}

extension UITableView {
    /// Check if cell at the specific section and row is visible
    /// - Parameters:
    /// - section: an Int reprenseting a UITableView section
    /// - row: and Int representing a UITableView row
    /// - Returns: True if cell at section and row is visible, False otherwise
    func isCellVisible(section:Int, row: Int) -> Bool {
        guard let indexes = self.indexPathsForVisibleRows else {
            return false
        }
        return indexes.contains {$0.section == section && $0.row == row }
    }
}
