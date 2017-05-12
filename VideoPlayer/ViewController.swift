//
//  ViewController.swift
//  VideoPlayer
//
//  Created by think24 on 5/12/17.
//  Copyright © 2017 Think42Labs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    @IBOutlet weak var collectionView: UICollectionView!
    
    var visibleIP : IndexPath = IndexPath.init(row: 0, section: 0)
    var aboutToBecomeInvisibleCell = -1

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    
    override func viewDidAppear(_ animated: Bool)
    {
        if let videoCell = collectionView.cellForItem(at: visibleIP) as? VideoCollectionViewCell
        {
            videoCell.startPlayback()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool)
    {
        if let videoCell = collectionView.cellForItem(at: visibleIP) as? VideoCollectionViewCell
        {
            videoCell.stopPlayback()
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: UICollectionViewDataSource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int
    {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return 7
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "videoCell", for: indexPath) as! VideoCollectionViewCell
        cell.videoUrl = "https://clips.vorwaerts-gmbh.de/big_buck_bunny.mp4"
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return CGSize(width: collectionView.frame.size.width, height: 200)
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView)
    {
         let visibleIndexPaths = collectionView.indexPathsForVisibleItems
        if visibleIndexPaths.count > 0
        {
            var indexPathVissibled : Bool = false
            for indexPath in visibleIndexPaths
            {
                if let videoCell = collectionView.cellForItem(at: indexPath) as? VideoCollectionViewCell
                {
                    if collectionView.bounds.contains(videoCell.frame) && !indexPathVissibled
                    {
                        videoCell.startPlayback()
                        self.visibleIP = indexPath
                        indexPathVissibled = true
                    }
                    else
                    {
                        aboutToBecomeInvisibleCell = indexPath.item
                        videoCell.stopPlayback()
                    }
                }
            }
        }        
    }
}

