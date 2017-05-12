//
//  VideoCollectionViewCell.swift
//  VideoPlayer
//
//  Created by think24 on 5/12/17.
//  Copyright © 2017 Think42Labs. All rights reserved.
//

import UIKit
import AVKit
import AVFoundation

class VideoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet weak var videoView: UIView!
    var videoPlayer : AVPlayerViewController?
    var avPlayerController : AVPlayerViewController?
    var paused: Bool = false
    var videoUrl: String? = nil {
        didSet {
            /*
             If needed, configure player item here before associating it with a player.
             (example: adding outputs, setting text style rules, selecting media options)
             */
            
            self.setupMoviePlayer()
        }
    }
    
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    func setupMoviePlayer()
    {
        self.avPlayerController = AVPlayerViewController()
        let avPlayer = AVPlayer.init(playerItem: AVPlayerItem(url: URL(string: videoUrl!)!))
        avPlayer.volume = 3
        avPlayer.actionAtItemEnd = .none
        avPlayerController?.player = avPlayer
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(self.playerItemDidReachEnd(notification:)),
                                               name: NSNotification.Name.AVPlayerItemDidPlayToEndTime,
                                               object: avPlayer.currentItem)
        avPlayerController?.view.frame = self.videoView.bounds
        self.avPlayerController?.videoGravity = AVLayerVideoGravityResizeAspect
        self.backgroundColor = .clear
        
        for view in self.videoView.subviews
        {
            view.removeFromSuperview()
        }
        self.videoView.insertSubview(avPlayerController!.view, at: 0)
    }
    
    func stopPlayback()
    {
        self.avPlayerController?.player?.pause()
    }
    
    func startPlayback(){
        self.avPlayerController?.player?.play()
    }
    
    // A notification is fired and seeker is sent to the beginning to loop the video again
    func playerItemDidReachEnd(notification: Notification) {
        let p: AVPlayerItem = notification.object as! AVPlayerItem
        p.seek(to: kCMTimeZero)
    }
}
