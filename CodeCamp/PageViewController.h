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
}

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *upSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *downSwipe;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

@end
