//
//  PinboardPinsViewController.swift
//  PinboardPins
//
//  Created by javedmultani16 on 17/05/19.
//  Copyright © 2019 javedmultani16. All rights reserved.
//

import UIKit
import SwiftyEasyCache


class PinboardPinsViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    var cache = CacheManager(cacheCountLimit: 500, cacheSizeLimit: 500)
    var refresher:UIRefreshControl = UIRefreshControl()
    var pindata = [PinData]()
    var isLoadingMore = false

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red:0.95, green:0.96, blue:0.97, alpha:1.0)
        self.navigationController?.navigationBar.isHidden = false
        self.navigationController?.navigationBar.barTintColor =  APP_THEME_COLOR
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor : UIColor.white]
        addPullToRefresh()
        configureViews()
        loadPinterestData()
    }
    //setup the view
    func configureViews() {
        activityIndicator.startAnimating()
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        self.title = "Pinterest Feed"
        collectionView.backgroundColor = UIColor.clear
        if let layout = collectionView?.collectionViewLayout as? PinterestLayout {
            layout.delegate = self
        }
        collectionView!.contentInset = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)
        collectionView.delegate = self
        collectionView.dataSource = self
        self.collectionView.register(UINib(nibName: XIBIdentifiers.PinsCollectionViewCell, bundle: nil), forCellWithReuseIdentifier: XIBIdentifiers.PinsCollectionViewCell)
        self.collectionView.register(UINib(nibName: XIBIdentifiers.LoadMoreCell, bundle: nil), forCellWithReuseIdentifier: XIBIdentifiers.LoadMoreCell)
    }
    //use this method for add pull to refresh
    func addPullToRefresh() {
        self.collectionView!.isHidden = true
        self.collectionView!.alwaysBounceVertical = true
        self.refresher.attributedTitle = NSAttributedString(string: "Pull to refresh")
        self.refresher.tintColor = UIColor.white
        self.refresher.addTarget(self, action: #selector(loadData), for: .valueChanged)
        self.collectionView!.addSubview(refresher)
    }
    
    @objc func loadData() {
        
        activityIndicator.startAnimating()

        loadPinterestData()
        
        stopRefresher()
    }

    
    func loadPinterestData() {

        PinData.fetchPinData({ (result, errorFlag) in // for error I just took a flag later can add NSError for more detailed error
            print(self.isLoadingMore)
            print(self.pindata.count)
            
            if !errorFlag {
                if self.isLoadingMore {
                    self.isLoadingMore = false

                    for item in result {
                        self.pindata.append(item)
                    }
                
                } else {
                    
                    self.pindata = result
                }
                DispatchQueue.main.async {
                    self.collectionView!.isHidden = false
                    self.activityIndicator.stopAnimating()
                    self.collectionView.reloadData()
                    print(self.pindata.count)

                }
            } else {
                displayAlertWarning(message: "Please Pull to refresh")
            }

        })
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        //RestApiManager.cancelAllTask()
    }
    
    
    func stopRefresher() {
        self.refresher.endRefreshing()
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == SegueConstants.ProfileSegue {
            let pindata = sender as! PinData
            let destination             = segue.destination as! ProfileViewController
            destination.pindata         = pindata
        }
    }
}

extension PinboardPinsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {

        return 1
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pindata.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        cell.alpha = 0
        UIView.animate(withDuration: 0.7, animations: { cell.alpha = 1})
    }


    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == pindata.count - 1 || pindata.count == 0 {
            let loadCell = collectionView.dequeueReusableCell(withReuseIdentifier: XIBIdentifiers.LoadMoreCell, for: indexPath) as! LoadMoreCell
            loadCell.loadingView.alpha = 0
            loadCell.activityIndicator.stopAnimating()
            loadCell.loadButton.isHidden = false
            
            loadCell.preservesSuperviewLayoutMargins = false
            loadCell.layoutMargins = UIEdgeInsets.zero
            
            return loadCell
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: XIBIdentifiers.PinsCollectionViewCell, for: indexPath) as! PinsCollectionViewCell
        
        let fetchedData = pindata[indexPath.item]
    
//        cell.layer.borderColor = UIColor.gray as! CGColor
//        cell.layer.borderWidth = 1.5
        cell.setCellContent(fetchedData)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let dataToPass = pindata[indexPath.item]

        collectionView.deselectItem(at: indexPath, animated: false)
        
        if indexPath.item == pindata.count - 1 {
            let cell = collectionView.cellForItem(at: indexPath) as! LoadMoreCell
            cell.loadButton.isHidden = true
            UIView.animate(withDuration: 0.3, animations: {
                cell.loadingView.alpha = 1
                cell.activityIndicator.startAnimating()
            }, completion: { (finished) in
                    self.isLoadingMore = true
                    self.loadPinterestData()
            })
        }
        else {
            performSegue(withIdentifier: SegueConstants.ProfileSegue, sender: dataToPass)
        }
    }
    
}


extension PinboardPinsViewController : PinterestLayoutDelegate {

    func collectionView(_ collectionView:UICollectionView, heightForPhotoAtIndexPath indexPath:IndexPath , withWidth width:CGFloat) -> CGFloat {
        let photo = pindata[indexPath.row]
        return photo.imageHeight!
    }
    

    func collectionView(_ collectionView: UICollectionView, heightForAnnotationAtIndexPath indexPath: IndexPath, withWidth width: CGFloat) -> CGFloat {
        return 60
    }
}

