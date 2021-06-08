//
//  ViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/22/21.
//

import UIKit
import SideMenu
import DropDown
import ImageSlideshow
import AVFoundation
import CardSlider


class ViewController: UIViewController, ImageSlideshowDelegate {
    static var GuestCart : [CartObj] = []
    static var GuestSearchHistory : [ClothingObj] = []
    let dropDown = DropDown()
    
    var menu : SideMenuNavigationController?
    
    var player : AVPlayer!
    var avPlayerLayer : AVPlayerLayer!
    static var didComeBack = false
    static var search = true
    var query = ""
    var defaults = UserDefaults.standard
    
    @IBOutlet weak var topLayerView: UIView!
    @IBOutlet weak var topMenuView: UIView!
    @IBOutlet weak var wholeView: UIView!
    @IBOutlet var backgroundView: UIView!
    @IBOutlet weak var mustHaveView: UIView!
    @IBOutlet weak var shopOutfitsView: UIView!
    @IBOutlet weak var mustHaveLabel: UILabel!
    @IBOutlet weak var shopOutfitsLabel: UILabel!
    @IBOutlet weak var newletterLabel: UILabel!
    @IBOutlet weak var emailTextFieldView: UITextField!
    
    @IBOutlet weak var searchButton: UIButton!
    @IBOutlet weak var sideMenuButton: UIButton!
    @IBOutlet weak var storeName: UIButton!
    @IBOutlet weak var cartButton: UIButton!
    @IBOutlet weak var womenPlayer: UIView!
    @IBOutlet weak var mustHaveScrollView: UIScrollView!
    @IBOutlet weak var shopOutfitsScrollView: UIScrollView!
    @IBOutlet weak var instagramButton: UIButton!
    @IBOutlet weak var twitterButton: UIButton!
    @IBOutlet weak var facebookButton: UIButton!
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    @IBOutlet weak var slideshow: ImageSlideshow!
    
    var webPage = ""
    static var currentUserLogged = "Guest"

    let localSource = [BundleImageSource(imageString: "Home1"),
                       BundleImageSource(imageString: "Home2"),
                       BundleImageSource(imageString: "Home3"),
                       BundleImageSource(imageString: "Home4")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mustHaveScrollView.showsHorizontalScrollIndicator = false
        shopOutfitsScrollView.showsHorizontalScrollIndicator = false
        
        guard let path = Bundle.main.path(forResource: "Women", ofType:"MOV") else {
            debugPrint("Logo-Animation4.mp4 not found")
            return
        }
        player = AVPlayer(url: URL(fileURLWithPath: path))
        avPlayerLayer = AVPlayerLayer(player: player)
        avPlayerLayer.videoGravity = AVLayerVideoGravity.resize
        player.isMuted = true

        womenPlayer.layer.addSublayer(avPlayerLayer)
        player.play(); player.actionAtItemEnd = .none
                
                NotificationCenter.default.addObserver(self,
                selector: #selector(self.Repeater(snitch:)),
                name: .AVPlayerItemDidPlayToEndTime,
                object: player.currentItem)
        
                       //slideshow.pageIndicatorPosition = .init(horizontal: .center, vertical: .under)
                       slideshow.contentScaleMode = UIViewContentMode.scaleAspectFill

                       let pageControl = UIPageControl()
                       pageControl.currentPageIndicatorTintColor = UIColor.white
                       pageControl.pageIndicatorTintColor = UIColor.lightGray
                       slideshow.pageIndicator = pageControl

                       slideshow.activityIndicator = DefaultActivityIndicator()
                       slideshow.delegate = self

                       slideshow.setImageInputs(localSource)

                       let recognizer = UITapGestureRecognizer(target: self, action: #selector(didTap))
                       slideshow.addGestureRecognizer(recognizer)
        
        menu = SideMenuNavigationController(rootViewController: SideMenuTableViewController())
        menu?.leftSide = false
        menu?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.default.rightMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
    }
    
    @objc func Repeater(snitch: Notification) {
            let X: AVPlayerItem = snitch.object as! AVPlayerItem
            X.seek(to: .zero) { _ in }
        }
    
    override func viewDidLayoutSubviews() {
        avPlayerLayer.frame = womenPlayer.layer.bounds
    }
    
    @objc func didTap() {
                   let fullScreenController = slideshow.presentFullScreenController(from: self)
                   fullScreenController.slideshow.activityIndicator = DefaultActivityIndicator(style: .medium, color: nil)
               }
    
    @IBAction func sideMenuButton(_ sender: Any) {
        present(menu!, animated: true)
    }
    
    
    @IBAction func cartButton(_ sender: UIButton) {
        
    }
    
    @IBAction func darkModeSwitch(_ sender: Any) {
        
        if darkModeSwitch.isOn == false {
            
            UIView.animate(withDuration: 0.2, animations: {
                self.wholeView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.backgroundView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.mustHaveView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.shopOutfitsView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.topMenuView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.topLayerView.backgroundColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.emailTextFieldView.attributedPlaceholder = NSAttributedString(string:"Your Email Address", attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray6])
                self.emailTextFieldView.textColor = UIColor.systemGray6
                self.emailTextFieldView.backgroundColor = UIColor(red: 50/255, green: 51/255, blue: 55/255, alpha: 1)
                self.mustHaveLabel.textColor = UIColor.systemGray6
                self.shopOutfitsLabel.textColor = UIColor.systemGray6
                self.newletterLabel.textColor = UIColor.systemGray6
                self.storeName.setTitleColor(UIColor.systemGray6, for: .normal)
                self.searchButton.tintColor = UIColor.systemGray6
                self.sideMenuButton.tintColor = UIColor.systemGray6
                self.cartButton.tintColor = UIColor.systemGray6
            }, completion: nil)
            
        } else {
            UIView.animate(withDuration: 0.2, animations: {
                self.wholeView.backgroundColor = UIColor.systemGray6
                self.backgroundView.backgroundColor = UIColor.systemGray6
                self.mustHaveView.backgroundColor = UIColor.systemGray6
                self.shopOutfitsView.backgroundColor = UIColor.systemGray6
                self.topMenuView.backgroundColor = UIColor.systemGray6
                self.topLayerView.backgroundColor = UIColor.systemGray6
                self.emailTextFieldView.attributedPlaceholder = NSAttributedString(string:"Your Email Address", attributes: [NSAttributedString.Key.foregroundColor:UIColor.systemGray])
                self.emailTextFieldView.textColor = UIColor.label
                self.emailTextFieldView.backgroundColor = UIColor.systemGray6
                self.mustHaveLabel.textColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.shopOutfitsLabel.textColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.newletterLabel.textColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.storeName.setTitleColor(UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1), for: .normal)
                self.searchButton.tintColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.sideMenuButton.tintColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
                self.cartButton.tintColor = UIColor(red: 38/255, green: 39/255, blue: 43/255, alpha: 1)
            }, completion: nil)
        }
        
    }
    @IBAction func instagramButton(_ sender: Any) {
        webPage = "https://www.instagram.com/alphalete/?hl=en"
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBAction func twitterButton(_ sender: Any) {
        webPage = "https://twitter.com/Alphalete?ref_src=twsrc%5Egoogle%7Ctwcamp%5Eserp%7Ctwgr%5Eauthor"
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBAction func facebookButton(_ sender: Any) {
        webPage = "https://www.facebook.com/alphaleteathletics/"
        performSegue(withIdentifier: "segue", sender: self)
    }
    @IBAction func youtubeButton(_ sender: Any) {
        webPage = "https://www.youtube.com/channel/UCkSZPoazdQbLaljwqQo1c_g"
        performSegue(withIdentifier: "segue", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "segue" {
            let vc = segue.destination as! WebViewController
            vc.webPage = self.webPage
        }
        if segue.identifier == "collection" {
            let vc = segue.destination as! CollectionViewController
            vc.passedQuery = self.query
        }
    }
    
    @IBAction func shopFilterButton(_ sender: UIButton) {
        switch sender.tag {
        case 1:
            self.query = "Men"
        case 2:
            self.query = "Women"
        case 3:
            self.query = "Bottoms"
        case 4:
            self.query = "Accessories"
        default:
            print("NO")
        }
        
        ViewController.search = false
        performSegue(withIdentifier: "collection", sender: self)
        
    }
    
    @IBAction func coreShort(_ sender: Any) {
        let vc = ItemViewController()
        defaults.setValue("105", forKey: "passedID")
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .crossDissolve
        present(vc, animated: true)
    }
    
    
}


