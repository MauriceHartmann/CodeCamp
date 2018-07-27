//
//  StoreViewController.m
//  CodeCamp
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "StoreViewController.h"
#import "Share.h"
#import "Creature.h"

@implementation StoreViewController

Share* mySharesInventory;
int foodPrice = 10;
int drinkPrice = 10;
int shampooPrice = 25;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mySharesInventory = Share.sharedSingleton;
    
    //Loads all the data from myShare and creates the Labels
    
    _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
    
    _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
    
    _shampooInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:SHAMPOO]];
    
    _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    
    _foodPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", foodPrice];
    
    _drinkPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", drinkPrice];
    
    _shampooPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", shampooPrice];
}

//return to Mall Screen
- (IBAction)retrunAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

//ButtonAction to buy Drink
- (IBAction)buyDrinkAction:(id)sender {
    
    //checks if the player has enough money
    if([mySharesInventory getIntFromKey:MONEY] >= drinkPrice)
       {
           //add drink and remove money
           [mySharesInventory updateKeyBy:DRINKS :1];
           [mySharesInventory updateKeyBy:MONEY :-drinkPrice];
           
           //update labels
           _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
           _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
       }
}
- (IBAction)buyShampooAction:(id)sender {
    
     //checks if the player has enough money
    if([mySharesInventory getIntFromKey:MONEY] >= shampooPrice)
    {
        //add shampoo and remove the money
        [mySharesInventory updateKeyBy:SHAMPOO :1];
        [mySharesInventory updateKeyBy:MONEY :-shampooPrice];
        
        //update labels
        _shampooInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:SHAMPOO]];
        _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    }
}


- (IBAction)buyFoodAction:(id)sender
{
    
     //checks if the player has enough money
    if([mySharesInventory getIntFromKey:MONEY] >= foodPrice)
    {
        //add food and remove money
        [mySharesInventory updateKeyBy:FODDER :1];
        [mySharesInventory updateKeyBy:MONEY :-foodPrice];
        
        //update labels
        _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
        _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    }
}

@end
