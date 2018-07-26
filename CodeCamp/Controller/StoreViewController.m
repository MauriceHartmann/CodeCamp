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
    
    _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
    
    _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
    
    _shampooInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:SHAMPOO]];
    
    _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    
    _foodPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", foodPrice];
    
    _drinkPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", drinkPrice];
    
    _shampooPriceLabel.text = [NSString stringWithFormat:@"Cost: %i", shampooPrice];
}

- (IBAction)retrunAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyDrinkAction:(id)sender {
    if([mySharesInventory getIntFromKey:MONEY] >= drinkPrice)
       {
           [mySharesInventory updateKeyBy:DRINKS :1];
           [mySharesInventory updateKeyBy:MONEY :-drinkPrice];
           _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
           _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
       }
}
- (IBAction)buyShampooAction:(id)sender {
    if([mySharesInventory getIntFromKey:MONEY] >= shampooPrice)
    {
        [mySharesInventory updateKeyBy:SHAMPOO :1];
        [mySharesInventory updateKeyBy:MONEY :-shampooPrice];
        _shampooInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:SHAMPOO]];
        _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    }
}


- (IBAction)buyFoodAction:(id)sender
{
    if([mySharesInventory getIntFromKey:MONEY] >= foodPrice)
    {
        [mySharesInventory updateKeyBy:FODDER :1];
        [mySharesInventory updateKeyBy:MONEY :-foodPrice];
        _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
        _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    }
}

@end
