//
//  Room.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Room.h"
#import "PageViewController.h"

@implementation Room


+(void) doAction{
    
}

+(BOOL) checkNoItemLeft: (Share *) myShareInRoom :(PageViewController*) pageView
{
    BOOL check = NO;
    
    switch (pageView.tabBarController.selectedIndex) {
        case 0:
            check = ([myShareInRoom getIntFromKey:@"fodder"] == 0);
            break;
            
        case 1:
            check = ([myShareInRoom getIntFromKey:@"drinks"] == 0);
            break;
    }
    
    return check;
}

+(BOOL) checkFullness: (Share *) myShareInRoom :(PageViewController*) pageView
{
    BOOL check = NO;
    
    switch (pageView.tabBarController.selectedIndex) {
        case 0:
            check = ([myShareInRoom getIntFromKey:@"hungry"] >= 80);
            break;
            
        case 1:
            check = ([myShareInRoom getIntFromKey:@"thirsty"] >= 80);
            break;
    }
    
    return check;
}
@end
