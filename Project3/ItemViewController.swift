//
//  ItemViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/24/21.
//

import UIKit

class ItemViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var id : String = ""
    let defaults = UserDefaults.standard
    var size = ""
    var displayObj : ClothingObj?
    var selectedColor : String = ""
    @IBOutlet weak var itemScrollView: UIScrollView!
    @IBOutlet weak var itemView: UIView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var colorLabel: UILabel!
    
    @IBOutlet weak var itempicOne: UIImageView!
    @IBOutlet weak var itempicTwo: UIImageView!
    @IBOutlet weak var itempicThree: UIImageView!
    @IBOutlet weak var itemColor: UILabel!
    
    @IBOutlet weak var colorOne: UIButton!
    @IBOutlet weak var colorTwo: UIButton!
    @IBOutlet weak var colorThree: UIButton!
    @IBOutlet weak var colorFour: UIButton!
    @IBOutlet weak var colorFive: UIButton!
    @IBOutlet weak var colorSix: UIButton!
    @IBOutlet weak var colorSeven: UIButton!
    @IBOutlet weak var colorEight: UIButton!
    @IBOutlet weak var colorNine: UIButton!
    @IBOutlet weak var colorTen: UIButton!
    
    @IBOutlet weak var xxs : UIButton!
    @IBOutlet weak var xs : UIButton!
    @IBOutlet weak var s : UIButton!
    @IBOutlet weak var m : UIButton!
    @IBOutlet weak var l : UIButton!
    @IBOutlet weak var xl : UIButton!
    @IBOutlet weak var xxl : UIButton!
    
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var selectASize: UIButton!
    
    @IBOutlet weak var colorCountLabel: UILabel!
    
    @IBOutlet weak var reviewTableView: UITableView!
    @IBOutlet weak var leaveReviewButton: UIButton!
    @IBOutlet weak var reviewTextField: UITextField!
    @IBOutlet weak var createReviewView: UIView!
    
    @IBOutlet weak var wishListButton: UIButton!
    var ratingScore: Float = 1.0
    var review = DatabaseHelper.inst.fetchReview()
    static var counter = 0
    var arrOfRating: [Float] = []
    var arrOfReview: [String] = []
    var arrOfName: [String] = []
    
    //Placeholder data
    var testNameArray = ["Edward", "Guillermo"]
    var testRatingArray = [4.0, 3.0]
    var testCommentArray = ["This product is good", "The quality of this item is very bad, easily tears"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        reviewTableView.separatorStyle = .none
        ItemViewController.counter = 0
        createReviewView.isHidden = true
        toggleDisabledButtonState()
        id = defaults.value(forKey: "passedID") as! String
        let displayObject = DatabaseHelper.inst.fetchClothesById(id: id)
        if ViewController.currentUserLogged == "Guest" {
            if ViewController.currentUserLogged.count == 0 {
                ViewController.GuestSearchHistory.append(displayObject)
            } else {
                if ViewController.GuestSearchHistory.contains(where: {displayObject.id == $0.id}) {
                    ViewController.GuestSearchHistory.removeAll(where: {displayObject.id == $0.id})
                    ViewController.GuestSearchHistory.insert(displayObject, at: 0)
                    print("added ", displayObject.id, " to searchHistory")
                } else {
                    ViewController.GuestSearchHistory.insert(displayObject, at: 0)
                    print("added ", displayObject.id, " to searchHistory")
                }
            }
        } else {
            DatabaseHelper.inst.addToSearchHistory(obj: displayObject, currUser: ViewController.currentUserLogged)
        }
        nameLabel.text = displayObject.name
        priceLabel.text = "$" + String(format: "%.2f",displayObject.price)
        itemScrollView.showsHorizontalScrollIndicator = false
        //descriptionText.showsVerticalScrollIndicator = false
        colorOne.layer.borderWidth = 1
        displayObj = DatabaseHelper.inst.fetchClothesById(id: id)
        nameLabel.text = displayObj?.name
        colorLabel.text = String(displayObj!.color) + " Colors"
        let displayPrice = String(displayObj!.price)
        switch displayPrice.count {
        case 3:
            priceLabel.text = "$" + displayPrice + "0"
        case 4:
            priceLabel.text = "$" + displayPrice + "0"
        case 5:
            priceLabel.text = "$" + displayPrice
        default:
            colorLabel.text = "wrong format"
            print("wrong format")
        }
        
        //set wishlist button
        if ViewController.currentUserLogged == "Guest" {
            wishListButton.isHidden = true
        } else {
            if DatabaseHelper.inst.doesExistInWishList(id: displayObj!.id, currUser: ViewController.currentUserLogged) {
                wishListButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
                print("fill")
                
            } else {
                print("unfill")
                wishListButton.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
        
        itempicOne.image = UIImage(named: id)
        colorOne.setImage(UIImage(named: id), for: .normal)
        colorTwo.setImage(UIImage(named: id + "_02"), for: .normal)
        colorThree.setImage(UIImage(named: id + "_03"), for: .normal)
        colorFour.setImage(UIImage(named: id + "_04"), for: .normal)
        colorFive.setImage(UIImage(named: id + "_05"), for: .normal)
        colorSix.setImage(UIImage(named: id + "_06"), for: .normal)
        colorSeven.setImage(UIImage(named: id + "_07"), for: .normal)
        colorEight.setImage(UIImage(named: id + "_08"), for: .normal)
        colorNine.setImage(UIImage(named: id + "_09"), for: .normal)
        colorTen.setImage(UIImage(named: id + "_010"), for: .normal)
        
        switch colorOne.imageView?.image {
        case nil:
            colorOne.isEnabled = false
        default:
            print("button 1 has image")
        }
        
        switch colorTwo.imageView?.image {
        case nil:
            colorTwo.isEnabled = false
        default:
            print("button 2 has image")
        }
        
        switch colorThree.imageView?.image {
        case nil:
            colorThree.isEnabled = false
        default:
            print("button 3 has image")
        }
        
        switch colorFour.imageView?.image {
        case nil:
            colorFour.isEnabled = false
        default:
            print("button 4 has image")
        }
        
        switch colorFive.imageView?.image {
        case nil:
            colorFive.isEnabled = false
        default:
            print("button 5 has image")
        }
        
        switch colorSix.imageView?.image {
        case nil:
            colorSix.isEnabled = false
        default:
            print("button 6 has image")
        }
        
        switch colorSeven.imageView?.image {
        case nil:
            colorSeven.isEnabled = false
        default:
            print("button 7 has image")
        }
        
        switch colorEight.imageView?.image {
        case nil:
            colorEight.isEnabled = false
        default:
            print("button 8 has image")
        }
        
        switch colorNine.imageView?.image {
        case nil:
            colorNine.isEnabled = false
        default:
            print("button 9 has image")
        }
        
        switch colorTen.imageView?.image {
        case nil:
            colorTen.isEnabled = false
        default:
            print("button 10 has image")
        }
        
        let nib = UINib(nibName: "ReviewTableViewCell", bundle: nil)
        reviewTableView.register(nib, forCellReuseIdentifier: "reviewCell")
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
    }
    
    func toggleDisabledButtonState() {
        if (ViewController.currentUserLogged == "Guest") {
            leaveReviewButton.setTitle("LOG IN TO LEAVE REVIEWS", for: .normal)
            leaveReviewButton.isEnabled = false
            leaveReviewButton.sizeToFit()
            leaveReviewButton.setTitleColor(.gray, for: .normal)
        }
        else {
            leaveReviewButton.isEnabled = true
            leaveReviewButton.setTitle("ADD REVIEW TO THIS ITEM", for: .normal)
            leaveReviewButton.sizeToFit()
            leaveReviewButton.setTitleColor(.link, for: .normal)
        }
    }
    
    @IBAction func leaveReviewButton(_ sender: Any) {
        createReviewView.isHidden = false
        createReviewView.layer.cornerRadius = 10.0
        createReviewView.layer.masksToBounds = true
        createReviewView.layer.borderWidth = 1.0
        createReviewView.layer.borderColor = UIColor.black.cgColor
    }
    
    //MARK: Table Functions
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var counter = 0
        for r in review {
            if (r.id == id) {
                counter += 1
            }
        }
        return counter //Source of Crash when table view exceeds constraints when scrolling down
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reviewCell", for: indexPath) as! ReviewTableViewCell
        //var i = 0
        /*
        while x < review[indexPath.row].name!.count {
            if (review[indexPath.row].id == id) {
                cell.nameLabel.text = "\((review[indexPath.row].name![x]))"
                cell.ratingLabel.text = "Rating: \((review[indexPath.row].rating![x]))"
                cell.reviewLabel.text = "\((review[indexPath.row].comment![x]))"
            }
            x += 1
        }
        */
        /*
        if (review[indexPath.row].id == id) {
            cell.nameLabel.text = "\((review[indexPath.row].name![x]))"
            cell.ratingLabel.text = "Rating: \((review[indexPath.row].rating![x]))"
            cell.reviewLabel.text = "\((review[indexPath.row].comment![x]))"
        }
        x += 1
        */
        //var arrOfRating: [Float] = []
        //var arrOfReview: [String] = []
        //var arrOfName: [String] = []
        //Trade Places - Uncomment later
        for y in review {
            if y.id == id {
                arrOfName.append(y.name!)
                arrOfRating.append(y.rating)
                arrOfReview.append(y.comment!)
            }
        }
        print(arrOfName)
        print(arrOfRating)
        print(arrOfReview)
        /*
        for x in review {
            print(x.id)
            print(x.comment)
            if (x.id == id) {
                print(x.id)
                print(x.comment)
                /*
                cell.nameLabel.text = review[indexPath.row].name
                cell.ratingLabel.text = "Rating: \((review[indexPath.row].rating))"
                cell.reviewLabel.text = review[indexPath.row].comment
                */
                cell.nameLabel.text = arrOfName[i]
                cell.ratingLabel.text = "Rating: \(arrOfRating[i])"
                cell.reviewLabel.text = arrOfReview[i]
            }
            i += 1
        }
        */
        //while i < arrOfName.count {
            print("Counter: \(ItemViewController.counter)")
            print(arrOfName[ItemViewController.counter])
        cell.nameLabel.text = arrOfName[ItemViewController.counter]
            print(arrOfRating[ItemViewController.counter])
            cell.ratingLabel.text = "Rating: \(arrOfRating[ItemViewController.counter])"
            print(arrOfReview[ItemViewController.counter])
            cell.reviewLabel.text = arrOfReview[ItemViewController.counter]
        ItemViewController.counter += 1
        //}
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70.0
    }
    
    //MARK:- START Create Review UIVIEW
    
    @IBAction func exitButton(_ sender: Any) {
        createReviewView.isHidden = true
    }
    
    @IBAction func setRating(_ sender: UISegmentedControl) {
        if (sender.selectedSegmentIndex == 0) {
            ratingScore = 1.0
        }
        else if (sender.selectedSegmentIndex == 1) {
            ratingScore = 2.0
        }
        else if (sender.selectedSegmentIndex == 2) {
            ratingScore = 3.0
        }
        else if (sender.selectedSegmentIndex == 3) {
            ratingScore = 4.0
        }
        else if (sender.selectedSegmentIndex == 4) {
            ratingScore = 5.0
        }
    }
    
    @IBAction func saveReviewButton(_ sender: Any) {
        print("Saved Review")
        //save data here
        DatabaseHelper.inst.saveReview(id: id, rating: ratingScore, comment: reviewTextField.text!, name: ViewController.currentUserLogged)
        createReviewView.isHidden = true
        ItemViewController.counter = 0
        self.reviewTableView.reloadData()
    }
    
    //MARK:- END Create Review UIVIEW
    

    @IBAction func colorOne(_ sender: Any) {
       
        if (itemColor.text != "COLOR 1") {
            
            colorOne.layer.borderWidth = 1
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 1"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id)
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: self.id)
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: self.id)
            }, completion: nil)
        }
        self.selectedColor = ""
    }
    
    @IBAction func colorTwo(_ sender: Any) {
        
        if (itemColor.text != "COLOR 2") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 1
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 2"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_02")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Limelight)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Limelight)3")
            }, completion: nil)
        }
        self.selectedColor = "_02"
    }
    
    @IBAction func colorThree(_ sender: Any) {
        
        if (itemColor.text != "COLOR 3") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 1
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 3"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_03")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Ivory)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Ivory)3")
            }, completion: nil)
        }
        self.selectedColor = "_03"
        
    }

    @IBAction func colorFour(_ sender: Any) {
        
        if (itemColor.text != "COLOR 4") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 1
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 4"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_04")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Black)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Black)3")
            }, completion: nil)
        }
        self.selectedColor = "_04"
        
    }
    
    @IBAction func colorFive(_ sender: Any) {
        
        if (itemColor.text != "COLOR 5") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 1
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 5"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_05")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Nightshade)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Nightshade)3")
            }, completion: nil)
        }
        self.selectedColor = "_05"
    }
    
    @IBAction func colorSix(_ sender: Any) {
        
        if (itemColor.text != "COLOR 6") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 1
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 6"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_06")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MutedOlive)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MutedOlive)3")
            }, completion: nil)
        }
        self.selectedColor = "_06"
        
    }
    
    @IBAction func colorSeven(_ sender: Any) {
        
        if (itemColor.text != "COLOR 7") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 1
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 7"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_07")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MajorRed)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MajorRed)3")
            }, completion: nil)
        }
        self.selectedColor = "_07"
        
    }
    
    @IBAction func colorEight(_ sender: Any) {
        if (itemColor.text != "COLOR 8") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 1
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 8"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_08")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MajorRed)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MajorRed)3")
            }, completion: nil)
        }
        self.selectedColor = "_08"
    }
    @IBAction func colorNine(_ sender: Any) {
        if (itemColor.text != "COLOR 9") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 1
            colorTen.layer.borderWidth = 0
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 9"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_09")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MajorRed)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MajorRed)3")
            }, completion: nil)
        }
        self.selectedColor = "_09"
    }
    @IBAction func colorTen(_ sender: Any) {
        if (itemColor.text != "COLOR 10") {
            
            colorOne.layer.borderWidth = 0
            colorTwo.layer.borderWidth = 0
            colorThree.layer.borderWidth = 0
            colorFour.layer.borderWidth = 0
            colorFive.layer.borderWidth = 0
            colorSix.layer.borderWidth = 0
            colorSeven.layer.borderWidth = 0
            colorEight.layer.borderWidth = 0
            colorNine.layer.borderWidth = 0
            colorTen.layer.borderWidth = 1
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "COLOR 10"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: self.id + "_010")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MajorRed)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MajorRed)3")
            }, completion: nil)
        }
        self.selectedColor = "_010"
    }
    @IBAction func xxs(_ sender: Any) {
        xxs.layer.borderWidth = 1
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 0
        m.layer.borderWidth = 0
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XXS TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "xxs"
    }
    @IBAction func xs(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 1
        s.layer.borderWidth = 0
        m.layer.borderWidth = 0
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XS TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "xs"
    }
    @IBAction func s(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 1
        m.layer.borderWidth = 0
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD S TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "s"
    }
    @IBAction func m(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 0
        m.layer.borderWidth = 1
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD M TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "m"
    }
    @IBAction func l(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 0
        m.layer.borderWidth = 0
        l.layer.borderWidth = 1
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD L TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "l"
    }
    @IBAction func xl(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 0
        m.layer.borderWidth = 0
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 1
        xxl.layer.borderWidth = 0
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XL TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "xl"
    }
    @IBAction func xxl(_ sender: Any) {
        xxs.layer.borderWidth = 0
        xs.layer.borderWidth = 0
        s.layer.borderWidth = 0
        m.layer.borderWidth = 0
        l.layer.borderWidth = 0
        xl.layer.borderWidth = 0
        xxl.layer.borderWidth = 1
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XXL TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
        self.size = "xxl"
    }
    @IBAction func addToBag(_ sender: Any) {
        print("create and add cart object to current user cart with size , ", self.size)
        let selectedColorImage = UIImage(named: self.displayObj!.id + self.selectedColor)!
        print("imaged named : ", self.displayObj!.id + self.selectedColor)
        let newCartObj = CartObj(name: self.displayObj!.name, price: self.displayObj!.price, id: self.displayObj!.id, image: selectedColorImage, size: self.size)
            DatabaseHelper.inst.addToCart(obj: newCartObj, currUser: ViewController.currentUserLogged)
        self.dismiss(animated: true, completion: nil)
        }
    
    @IBAction func alphalete(_ sender: Any) {
        defaults.setValue("", forKey: "passedID")
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func wishListButton(_ sender: UIButton) {
        if ViewController.currentUserLogged == "Guest" {
            print("you shouldn't be here")
        } else {
            if DatabaseHelper.inst.doesExistInWishList(id: displayObj!.id, currUser: ViewController.currentUserLogged) {
                DatabaseHelper.inst.removeFromWishList(obj: displayObj!, currUser: ViewController.currentUserLogged)
                wishListButton.setImage(UIImage(systemName: "star"), for: .normal)
                print("unfill")
                
            } else {
                DatabaseHelper.inst.addToWishList(obj: displayObj!, currUser: ViewController.currentUserLogged)
                print("fill")
                wishListButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            }
        }
    }
    
}
