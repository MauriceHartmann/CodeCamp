//
//  PageViewController.h
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Share.h"
#import <AudioToolbox/AudioToolbox.h>

@interface PageViewController : UIViewController  {
    SystemSoundID soundGameOver;
    SystemSoundID soundBlobIsSad;
    SystemSoundID soundBlobIsAngry;
    SystemSoundID soundBlobIsEating;
    SystemSoundID soundBlobIsDrinking;
    SystemSoundID soundBuyDrinks;
    SystemSoundID soundBuyFood;
    SystemSoundID soundClickMenu;
    SystemSoundID soundClickMinigame;
    SystemSoundID soundPageturn;
}

@property (weak, nonatomic) IBOutlet UILabel *foodLabelMall;
@property (weak, nonatomic) IBOutlet UILabel *drinkLabelMall;
@property (weak, nonatomic) IBOutlet UILabel *shampooLabelMall;
@property (weak, nonatomic) IBOutlet UIImageView *energyMall;

@property (weak, nonatomic) IBOutlet UILabel *hungerLabelHome;
@property (weak, nonatomic) IBOutlet UILabel *fodderLabelHome;
@property (weak, nonatomic) IBOutlet UIImageView *energyHome;

@property (weak, nonatomic) IBOutlet UILabel *thirstLabelPub;
@property (weak, nonatomic) IBOutlet UILabel *drinksLabelPub;
@property (weak, nonatomic) IBOutlet UIImageView *energyPub;

@property (weak, nonatomic) IBOutlet UILabel *dirtLabelShower;
@property (weak, nonatomic) IBOutlet UILabel *shampooLabelShower;
@property (weak, nonatomic) IBOutlet UIImageView *energyShower;

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipe;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@end
