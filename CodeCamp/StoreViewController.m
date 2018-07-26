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
    
    _moneyLabel.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS] + 1000];
}

- (IBAction)retrunAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)buyDrinkAction:(id)sender {
    [mySharesInventory updateKeyBy:DRINKS :1];
    _drinkInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:DRINKS]];
}


- (IBAction)buyFoodAction:(id)sender
{
    [mySharesInventory updateKeyBy:FODDER :1];
    _foodInventory.text = [NSString stringWithFormat:@"%i", [mySharesInventory getIntFromKey:FODDER]];
}

@end
