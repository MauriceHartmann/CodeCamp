//
//  Store.h
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "Room.h"
#import "PageViewController.h"

@interface Store : Room
+(void) doAction: (Share*) myShares : (PageViewController*)pageView;

@end
