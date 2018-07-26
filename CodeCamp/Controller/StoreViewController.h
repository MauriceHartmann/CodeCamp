//
//  StoreViewController.h
//  CodeCamp
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface StoreViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *foodInventory;
@property (weak, nonatomic) IBOutlet UILabel *drinkInventory;
@property (weak, nonatomic) IBOutlet UILabel *moneyLabel;
@property (weak, nonatomic) IBOutlet UILabel *shampooInventory;
@property (weak, nonatomic) IBOutlet UILabel *foodPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *drinkPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *shampooPriceLabel;

@end
