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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mySharesInventory = Share.sharedSingleton;
    
    _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
    
    _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
    
    _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
}

- (IBAction)retrunAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyDrinkAction:(id)sender {
    if([mySharesInventory getIntFromKey:MONEY] >= 10)
       {
           [mySharesInventory updateKeyBy:DRINKS :1];
           [mySharesInventory updateKeyBy:MONEY :-10];
           _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
           _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
       }
}


- (IBAction)buyFoodAction:(id)sender
{
    if([mySharesInventory getIntFromKey:MONEY] >= 10)
    {
        [mySharesInventory updateKeyBy:FODDER :1];
        [mySharesInventory updateKeyBy:MONEY :-10];
        _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
        _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:MONEY]];
    }
}

@end
