//
//  ViewController.swift
//  Lemonade Stand
//
//  Created by Joao Rosa on 06/12/14.
//  Copyright (c) 2014 sonia rosa. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //IBOutlets (labels)
    @IBOutlet weak var myMoneyLabel: UILabel!
    @IBOutlet weak var myLemonLabel: UILabel!
    @IBOutlet weak var myIceCubeLabel: UILabel!
    
    @IBOutlet weak var lemonForBuyToLemonadeLabel: UILabel!
    @IBOutlet weak var iceCubeForBuyToLemonadeLabel: UILabel!
    
    @IBOutlet weak var lemonMixLabel: UILabel!
    @IBOutlet weak var iceCubeMixLabel: UILabel!
    
    @IBOutlet weak var todayWeatherImage: UIImageView!
    
    
        
    var myIngredients = Ingredient(money: 10, lemon: 1, iceCube: 1)
    var price = Price()
    
    var lemonsForBuy = 0
    var iceCubsForBuy = 0
    
    var lemonsForMix = 0
    var iceCubsForMix = 0
    
    var customers = 10
    
    var weatherArray : [[Int]] = [[-10, -9, -7, -5], [5, 8, 10, 9], [22, 25, 27, 23]]
    var weatherToday : [Int] = [0, 0, 0,0]
    
     
    
     override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        updateLabelsView()
        
        weatherForToday()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //IBActions (buy Ingredients)
    @IBAction func buyLemonForLemonadeButtonPressed(sender: UIButton) {
        
        if myIngredients.money >= price.klemon {
            self.lemonsForBuy += 1
            self.myIngredients.money -= price.klemon
            self.myIngredients.lemon += 1
            updateLabelsView()
        }
        else {
            showAlertWithText(message: "You don´t have enough money for buy Ingredientes")
        }
    }
    
    @IBAction func buyIceCubeForLemonadeButtonPressed(sender: UIButton) {
        
        if myIngredients.money >= price.kiceCube {
            self.iceCubsForBuy += 1
            self.myIngredients.money -= price.kiceCube
            self.myIngredients.iceCube += 1
            updateLabelsView()
        }
        else {
            showAlertWithText(message: "You don´t have enough money for buy Ingredientes")
        }
    }
    
    // removeBuyIngredients
    @IBAction func removeBuyLemonForLemonadeButtonPressed(sender: UIButton) {
        
        if lemonsForBuy > 0 {
            self.lemonsForBuy -= 1
            self.myIngredients.money += price.klemon
            self.myIngredients.lemon -= 1
            updateLabelsView()
        }
        else {
            showAlertWithText( message: "You don´t have enough Lemon to return")
        }
    }
    
    @IBAction func removeBuyIceCubeForLemonadeButtonPressed(sender: UIButton) {
        
        if iceCubsForBuy > 0 {
            self.iceCubsForBuy -= 1
            self.myIngredients.money += price.kiceCube
            self.myIngredients.iceCube -= 1
            updateLabelsView()
        }
        else {
            showAlertWithText( message: "You don´t have enough Icecube to return")
        }
    }
    
    //mix Ingredients in your lemonade
    @IBAction func mixLemonButtonPressed(sender: UIButton) {
        
        if myIngredients.lemon > 0 {
            self.lemonsForBuy = 0
            self.myIngredients.lemon -= 1
            self.lemonsForMix += 1
            updateLabelsView()
        }
        else {
            showAlertWithText( message: "You don't have more lemons, you need buy")
        }
    }
    
    @IBAction func mixIceCubeButtonPressed(sender: UIButton) {
        
        if myIngredients.iceCube > 0 {
            self.iceCubsForBuy = 0
            self.myIngredients.iceCube -= 1
            self.iceCubsForMix += 1
            updateLabelsView()
        }
        else {
            showAlertWithText( message: "You don't have more Icecubes, you need buy")
        }

    }
    
    //removeMixIngrekients
    @IBAction func removeMixLemonButtonPressed(sender: UIButton) {
        
        if lemonsForMix > 0 {
            self.lemonsForBuy = 0
            self.lemonsForMix -= 1
            self.myIngredients.lemon += 1
            updateLabelsView()
        }
        else {
            showAlertWithText(message: "You don´t have more Lemons to return")
        }
        
    }
    
    @IBAction func removeMixIceCubeButtonPressed(sender: UIButton) {
        
        if iceCubsForMix > 0 {
            self.iceCubsForBuy = 0
            self.iceCubsForMix -= 1
            self.myIngredients.iceCube += 1
            updateLabelsView()
        }
        else {
            showAlertWithText( message: "You don´t have more Lemons to return")
        }
        
    }
    
    
    //StartDay
    @IBAction func startDayButtonPressed(sender: UIButton) {
        
        let average = findAverage(weatherToday)
        
        self.customers = Int(arc4random_uniform(UInt32(abs(average))))
        
        if lemonsForMix == 0 || iceCubsForMix == 0 {
            showAlertWithText(message: "you need to mix : 1 lemons and 1 iceCube")
        }
        else {
            let lemonadeProportion = Double(lemonsForMix) / Double(iceCubsForMix)
            
            for i in 0...self.customers {
                
                var preference = Double(arc4random_uniform(UInt32(11))) / 10
                
                if preference < 0.4 && lemonadeProportion > 1 {
                    
                    self.myIngredients.money += 1
                    println("Paid")
                }
                else {
                    if preference > 0.6 && lemonadeProportion < 1 {
                        self.myIngredients.money += 1
                        println("Paid")
                    }
                    else if preference <= 0.6 && preference >= 0.4 && lemonadeProportion == 1 {
                        self.myIngredients.money += 1
                        println("Paid")
                    }
                    else {
                        println("else statment")
                    }
                }
                
                self.lemonsForBuy = 0
                self.iceCubsForBuy = 0
                self.lemonsForMix = 0
                self.iceCubsForMix = 0
               
                weatherForToday()
                updateLabelsView()
           }
        }
    }
    
    //Helper Function
    
    //update Your labeks
    func updateLabelsView() {
        
        self.myMoneyLabel.text = String(myIngredients.money)
        self.myLemonLabel.text = String(myIngredients.lemon)
        self.myIceCubeLabel.text = String(myIngredients.iceCube)
        
        self.lemonForBuyToLemonadeLabel.text = String(lemonsForBuy)
        self.iceCubeForBuyToLemonadeLabel.text = String(iceCubsForBuy)
        
        self.lemonMixLabel.text = String(lemonsForMix)
        self.iceCubeMixLabel.text = String(iceCubsForMix)
        
        
    }
    
    // Alerte (information for player)
    func showAlertWithText(header: String = "Warning", message: String) {
        
        var alert = UIAlertController(title: header, message: message, preferredStyle: UIAlertControllerStyle.Alert)
        alert.addAction(UIAlertAction(title: "ok", style: UIAlertActionStyle.Default, handler: nil))
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func weatherForToday() {
        
        let randomNumber = Int(arc4random_uniform(UInt32(weatherArray.count)))
        
        self.weatherToday = self.weatherArray[randomNumber]
        
       
        
        switch randomNumber {
        case 0 :
            self.todayWeatherImage.image = UIImage(named: "Cold")
        case 1 :
            self.todayWeatherImage.image = UIImage(named: "Mild")
        case 2 :
            self.todayWeatherImage.image = UIImage(named: "Warm")
        default :
            self.todayWeatherImage.image = UIImage(named: "Warm")
            
        }
                
    }
    
    func findAverage(data: [Int]) -> Int {
        
        var sum = 0
        
        for i in data {
            sum += i
        }
        
        var average: Double = Double(sum) / Double(data.count)
        var rounded: Int = Int(ceil(average))
        return rounded
    }
    
    
    
    
    
    
    
    
    
    

}

