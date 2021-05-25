//
//  ItemViewController.swift
//  Project3
//
//  Created by Tommy Phan on 5/24/21.
//

import UIKit

class ItemViewController: UIViewController {

    @IBOutlet weak var itemScrollView: UIScrollView!
    
    @IBOutlet weak var itempicOne: UIImageView!
    @IBOutlet weak var itempicTwo: UIImageView!
    @IBOutlet weak var itempicThree: UIImageView!
    @IBOutlet weak var itemColor: UILabel!
    
    @IBOutlet weak var newLabel: UILabel!
    @IBOutlet weak var selectASize: UIButton!
    @IBOutlet weak var descriptionText: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        itemScrollView.showsHorizontalScrollIndicator = false
        descriptionText.showsVerticalScrollIndicator = false
        
    }

    @IBAction func colorOne(_ sender: Any) {
       
        if (itemColor.text != "HALOGEN BLUE") {
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "HALOGEN BLUE"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(HalogenBlue)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(HalogenBlue)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(HalogenBlue)3")
            }, completion: nil)
        }
    }
    
    @IBAction func colorTwo(_ sender: Any) {
        
        if (itemColor.text != "LIMELIGHT") {
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "LIMELIGHT"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(Limelight)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Limelight)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Limelight)3")
            }, completion: nil)
        }
        
    }
    
    @IBAction func colorThree(_ sender: Any) {
        
        if (itemColor.text != "IVORY") {
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "IVORY"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(Ivory)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Ivory)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Ivory)3")
            }, completion: nil)
        }
        
    }

    @IBAction func colorFour(_ sender: Any) {
        
        if (itemColor.text != "BLACK") {
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "BLACK"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(Black)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Black)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Black)3")
            }, completion: nil)
        }
        
    }
    
    @IBAction func colorFive(_ sender: Any) {
        
        if (itemColor.text != "NIGHTSHADE") {
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "NIGHTSHADE"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(Nightshade)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(Nightshade)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(Nightshade)3")
            }, completion: nil)
        }
        
    }
    
    @IBAction func colorSix(_ sender: Any) {
        
        if (itemColor.text != "MUTED OLIVE") {
            
            if (newLabel.isHidden != false){
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = false
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "MUTED OLIVE"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(MutedOlive)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MutedOlive)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MutedOlive)3")
            }, completion: nil)
        }
        
    }
    
    @IBAction func colorSeven(_ sender: Any) {
        
        if (itemColor.text != "MAJOR RED") {
            
            if (newLabel.isHidden != true) {
            UIView.transition(with: newLabel, duration: 0.2, options: .transitionFlipFromBottom, animations: {
                self.newLabel.isHidden = true
            }, completion: nil)
            }
            
        UIView.transition(with: itemColor, duration: 0.2, options: .transitionFlipFromBottom, animations: {
            self.itemColor.text = "MAJOR RED"
        }, completion: nil)
            
            UIView.transition(with: itempicOne, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicOne.image = UIImage(named: "IdentityLoungeShort(MajorRed)")
            }, completion: nil)
            
            UIView.transition(with: itempicTwo, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicTwo.image = UIImage(named: "IdentityLoungeShort(MajorRed)2")
            }, completion: nil)
            
            UIView.transition(with: itempicThree, duration: 0.2, options: .transitionCrossDissolve, animations: {
                self.itempicThree.image = UIImage(named: "IdentityLoungeShort(MajorRed)3")
            }, completion: nil)
        }
        
    }
    
    @IBAction func xxs(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XXS TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func xs(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XS TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func s(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD S TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func m(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD M TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func l(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD L TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func xl(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XL TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    @IBAction func xxl(_ sender: Any) {
        selectASize.isEnabled = true
        selectASize.setTitle("ADD XXL TO BAG +", for: .normal)
        selectASize.setTitleColor(UIColor.white, for: .normal)
    }
    
}
