//
//  VideoPlayerCell.swift
//  ios-video-testing
//
//  Created by Adi Mizrahi on 02/11/2023.
//

import Foundation
import UIKit
import Cloudinary
import AVKit

class VideoPlayerCell: UITableViewCell {
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lbDuration: UILabel!
    var player: CLDVideoPlayer!
    var isVisible: Bool = false

    override func prepareForReuse() {
        lbDuration.text = ""
        vwMain.layer.sublayers?.forEach { $0.removeFromSuperlayer() }
    }

    func initPlayer(url: String) {
        player = CLDVideoPlayer(url: URL(string: url)!)
        player.currentItem!.addObserver(self, forKeyPath: "status", options: NSKeyValueObservingOptions(), context: nil)
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.vwMain.bounds
        playerLayer.videoGravity = .resizeAspectFill
        vwMain.layer.addSublayer(playerLayer)
        player.isMuted = true
        player.play()
    }

    func setDuration() {
        Task {
            await self.getDuration()
        }
    }

    func getDuration() async {
//        if let duration = player.currentItem?.asset.duration { SYNC
        do {
            if let duration = try await player.currentItem?.asset.load(.duration) { // ASYNC
                let seconds = CMTimeGetSeconds(duration)
                lbDuration.text = "\(Int(floor(seconds / 60))):" + "\(Int(floor(seconds.truncatingRemainder(dividingBy: 60))))"
            }
        } catch {
            lbDuration.text = ""
        }
    }

}
