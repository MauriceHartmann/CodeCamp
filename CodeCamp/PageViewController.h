//
//  PageViewController.h
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Share.h"

@interface PageViewController : UIViewController

@property (nonatomic, strong) UISwipeGestureRecognizer *leftSwipe;
@property (nonatomic, strong) UISwipeGestureRecognizer *rightSwipe;

@property (nonatomic, strong) UITapGestureRecognizer *tapGR;

+ (void) callOutARoom: (NSUInteger) tabId;

@end
