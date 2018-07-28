//
//  Arcade.h
//  CodeCamp
//
//  Created by Codecamp on 27.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Room.h"
#import "PageViewController.h"

@interface Arcade : Room
+(void) doAction: (Share*) myShares : (PageViewController*)pageView;

@end
