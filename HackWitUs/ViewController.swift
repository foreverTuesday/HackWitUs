//
//  ViewController.swift
//  HackWitUs
//
//  Created by Mikaela Scheff on 3/25/17.
//  Copyright © 2017 Mikaela Scheff. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var activePlayer = 2
    var gameState = [[0,0,0],[0,0,0],[0,0,0]]
    
    let blueColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
    var xImage = "nTERbpyyc.png"
    var oImage = "Font_O.svg.png"

    
    
    @IBAction func action(_ sender: AnyObject) {
        if (gameState[(sender.tag-1)/3][(sender.tag-1)%3]==0){ //if the place you've tried to play is empty
            if(activePlayer==1){         //switch the active player
                activePlayer=2
            }
            else{
                activePlayer=1
            }
            if (activePlayer == 1){ //play X's shape on their turn
                sender.setImage(UIImage(named:xImage), for: UIControlState())
                gameState[(sender.tag-1)/3][(sender.tag-1)%3]=1
            }
            else{ //play O's shape on their turn
                sender.setImage(UIImage(named:oImage), for: UIControlState())
                gameState[(sender.tag-1)/3][(sender.tag-1)%3]=2
            }
            //print(gameState)
        
            if(!(checkWin(num: activePlayer)==0)){
                winAlert(text: "Player \(activePlayer) has won")
            }
            else if(checkTie()==true){
                winAlert(text: "There was a tie")
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleChange.isHidden = true
        // Do any additional setup after loading the view, typically from a nib.
        }
    
 /*   override func viewDidLoad() {
        // Do any additional setup after loading the view, typically from a nib.
        let blueColor = UIColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0)
        view.backgroundColor = blueColor
    }*/

//reset button
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func checkWin(num: Int) -> Int { //check for a winner using the currently player number
        var winState = 0
        for x in 0...2{
                
            if (!((gameState[x][1])==0) && gameState[x][0]==gameState[x][1] && gameState[x][1]==gameState[x][2]){
                //row
                winState = num
            }
            if (!((gameState[1][x])==0) && gameState[0][x]==gameState[1][x] && gameState[1][x]==gameState[2][x]){
                //column
                winState = num
            }
        }
        if (!((gameState[1][1])==0) && ((gameState[0][0]==gameState[1][1] && gameState[1][1]==gameState[2][2]) || (gameState[0][2]==gameState[1][1] && gameState[1][1]==gameState[2][0]))){
            //diagonal
            winState = num
        }
        return winState
    }
    
    func checkTie() -> Bool{
        var check = 0
        for x in 0...2{
            for i in 0...2{
                if(!(gameState[x][i]==0)){
                    check = check + 1
                }
            }
        }
        if(check==9){
            return true
        }
        return false
    }
    
    
//show alert if someone has won
    func winAlert(text: String){
        let alertView: UIAlertView = UIAlertView(title: text, message: "", delegate: self, cancelButtonTitle: "OK")
       // alertView.alertViewStyle = .default
        alertView.show()
    }
//reset the game when "OK" is clicked
    func alertView(_ alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        default:
            resetGame()
        }
    }
    
    func resetGame(){
        gameState = [[0,0,0],[0,0,0],[0,0,0]]
        activePlayer = 2
        
        for i in 1...9{
            let button = view.viewWithTag(i) as! UIButton
            button.setImage(nil, for: UIControlState())
        }
    }
    
    
    //COLOR SWITCHING

//blue button
    @IBOutlet weak var changeButton: UIButton!
    @IBAction func changeColor(_ sender: AnyObject) {
        let blueColor = UIColor(red: 102/255.0, green: 204/255.0, blue: 255/255.0, alpha: 1.0)
        view.backgroundColor = blueColor
        xImage = "bluex.png"
        oImage = "blueo.png"
        boardImage.image = UIImage(named: "blueboard.png")
        hideButtons()
    }
    
//purple button
    @IBOutlet weak var changePurple: UIButton!
    @IBAction func purpleButton(_ sender: AnyObject) {
        let purpleColor = UIColor(red: 255/255.0, green: 166/255.0, blue: 255/255.0, alpha: 1.0)
        view.backgroundColor = purpleColor
        xImage = "purplex.png"
        oImage = "purpleo.png"
        boardImage.image = UIImage(named: "purpleboard.png")
        hideButtons()
    }

//green button
    @IBOutlet weak var changeGreen: UIButton!
    @IBAction func greenButton(_ sender: AnyObject) {
        let greenColor = UIColor(red: 142/255.0, green: 255/255.0, blue: 142/255.0, alpha: 1.0)
        view.backgroundColor = greenColor
        xImage = "greenx.png"
        oImage = "greeno.png"
        boardImage.image = UIImage(named: "greenboard.png")
        hideButtons()
    }
 
//change the color
    @IBOutlet weak var toggleChange: UIButton!
    @IBAction func switchColor(_ sender: AnyObject) {
        showButtons()
    }
    
    
//hide buttons and label
    func hideButtons(){
        changeButton.isHidden = true
        changePurple.isHidden = true
        changeGreen.isHidden = true
        chooseLabel.isHidden = true
        
        toggleChange.isHidden = false
    }
    
//show buttons and label
    func showButtons(){
        changeButton.isHidden = false
        changePurple.isHidden = false
        changeGreen.isHidden = false
        chooseLabel.isHidden = false
        
        toggleChange.isHidden = true
    }
    
//"Choose your color" label
    @IBOutlet weak var chooseLabel: UILabel!
    
    
//board image
    @IBOutlet weak var boardImage: UIImageView!
   
    
/*    func winAlert(xtitle: String, xmessage: String){
        let alert = UIAlertView(title: xtitle, message: xmessage, preferredStyle: UIAlertViewStyle.alert)
        alert.addAction(UIAlertAction(title: "This is a title", style: UIAlertActionStyle.default, handler: { (action) in alert.dismiss(animated: true, completion: nil)
        }))
        self.present(alert, animated: true,completion: nil)
        
    }
    
     func stateNum(num: Int) -> Int {
     return(gameState[num/3][(num1%3)])
     }
    

     0 = [0][0]
     1 = [0][1]
     2 = [0][2]
     3 = [1][0]
     4 = [1][1]
     5 = [1][2]
     6 = [2][0]
     7 = [2][1]
     8 = [2][2]
     
     
     BLUE
        bg: 66CCFF
            102/204/255
        img: 0080FF
            0/128/255
     
     PURPLE
        bg: E1A6FF
            255/166/255
        img: 8000FF
            128/0/255
     
     GREEN
        bg: 8EFF8E
            142/255/142
        img: 008040
            0/128/64
 */

    


}
