//
//  WelcomeViewController.swift
//  Project3
//
//  Created by Bruno Gomez on 5/27/21.
//

import UIKit

class WelcomeViewController: UIViewController {
    var Men : [ClothingObj] = []
    var Women : [ClothingObj] = []
    var Unisex : [ClothingObj] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if DatabaseHelper.inst.clothesExist() { //clothes exist
            let vc = self.storyboard?.instantiateViewController(identifier: "Main") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
        } else { //clothes dont exist
            let contents = openCSV(fileName: "clothes", fileType: "csv")
            parseCSV(contents: contents!)
            compareData()
            
            DatabaseHelper.inst.addClothes(Men: Men, Women: Women, Unisex: Unisex)
            
            let vc = self.storyboard?.instantiateViewController(identifier: "Main") as! ViewController
            vc.modalPresentationStyle = .fullScreen
            vc.modalTransitionStyle = .crossDissolve
            self.present(vc, animated: true, completion: nil)
            
        }
        // Do any additional setup after loading the view.
    }
    
    func openCSV(fileName:String, fileType: String)-> String!{
        guard let filepath = Bundle.main.path(forResource: fileName, ofType: fileType)
            else {
                return nil
        }
        do {
            let contents = try String(contentsOfFile: filepath, encoding: .utf8)
            //print(contents)
            return contents
        } catch {
            print("File Read Error for file \(filepath)")
            return nil
        }
    }

    func parseCSV(contents : String){
        var rows = contents.components(separatedBy: "\n")
        rows.removeFirst()
        rows.removeLast()
        var clothName = ""
        var clothType = ""
        var clothTypes = [String]()
        var clothPrice : Float
        var clothGender = ""
        var clothGenders = [String]()
        var clothId = ""
        var clothColorCount = 0
        var clothImage : UIImage
        var createdObject : ClothingObj
        //Men
        for row in rows {
            let eachRow = row.components(separatedBy: ",,,")[0]
            let eachObj = eachRow.split(separator: ",")
            if eachObj.count == 4 {
                clothName = String(eachObj[0])
                clothPrice = Float(String(eachObj[2]).replacingOccurrences(of: "$", with: ""))!
                clothTypes.append(clothType)
                clothId = String(eachObj[1])
                if Men.contains(where: {$0.id == clothId}) {
                    let indexNumber = Men.firstIndex(where: {$0.id == clothId})!
                    Men[indexNumber].type.append(clothType)
                    print("edited object id : ", Men[indexNumber].id, " ", Men[indexNumber].type)
                } else {
                    clothGender = "Men"
                    clothGenders.append(clothGender)
                    clothColorCount = Int(String(eachObj[3]))!
                    clothImage = UIImage(named: clothId)!
                    createdObject = ClothingObj(name: clothName, price: clothPrice, gender: clothGenders, type: clothTypes, id: clothId, image: clothImage, color: Int64(clothColorCount))
                    // create Object
                    Men.append(createdObject)
                    print("Added Men : ", createdObject.name, " ", createdObject.type, " ", createdObject.gender, " ", createdObject.price, " " , createdObject.id, " ", createdObject.color)
                }
                clothTypes.removeAll()
                clothGenders.removeAll()
            } else if eachObj.count == 1 {
                clothType = String(eachObj[0])
                print("category : ", clothType)
            }
            //print("Category : ", eachRow)
            }
        print("\n")
        
        //Women
        for row in rows {
            let eachRow = row.components(separatedBy: ",,,")[1]
            let eachObj = eachRow.split(separator: ",")
            if eachObj.count == 4 {
                clothName = String(eachObj[0])
                clothPrice = Float(String(eachObj[2]).replacingOccurrences(of: "$", with: ""))!
                clothTypes.append(clothType)
                clothId = String(eachObj[1])
                if Women.contains(where: {$0.id == clothId}) {
                    let indexNumber = Women.firstIndex(where: {$0.id == clothId})!
                    Women[indexNumber].type.append(clothType)
                    print("edited object id : ", Women[indexNumber].id, " ", Women[indexNumber].type)
                } else {
                    clothGender = "Women"
                    clothGenders.append(clothGender)
                    clothColorCount = Int(String(eachObj[3].replacingOccurrences(of: "\r", with: "")))!
                    clothImage = UIImage(named: clothId)!
                    createdObject = ClothingObj(name: clothName, price: clothPrice, gender: clothGenders, type: clothTypes, id: clothId, image: clothImage, color: Int64(clothColorCount))
                    // create Object
                    Women.append(createdObject)
                    print("Added Women : ", createdObject.name, " ", createdObject.type, " ", createdObject.gender, " ", createdObject.price, " " , createdObject.id, " ", createdObject.color)
                }
                clothTypes.removeAll()
                clothGenders.removeAll()
            } else if eachObj.count == 1 {
                clothType = String(eachObj[0].replacingOccurrences(of: "\r", with: ""))
            }
            //print("Category : ", eachRow)
            }
        print("Men : ", Men.count, "\nWomen : ", Women.count)
        
    }
    
    func compareData() {
        print("comparing")
        for mObj in Men {
            for wObj in Women {
                if mObj.id == wObj.id {
                    let newObj = mObj
                    newObj.gender = ["Men", "Women", "Unisex"]
                    print("removed from men where id = ", newObj.id)
                    Men.removeAll(where: {$0.id == newObj.id})
                    print("removed from women where id = ", newObj.id)
                    Women.removeAll(where: {$0.id == newObj.id})
                    print("Added to Unisex : ", newObj.id, "with genders : ", newObj.gender)
                    Unisex.append(newObj)
                    print("Men count : ", Men.count, " Women count : ", Women.count)
                    print("Unisex count : ", Unisex.count)
                }
            }
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
