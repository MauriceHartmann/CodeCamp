//
//  Room.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Room.h"
#import "Creature.h"
#import "PageViewController.h"

@implementation Room


+(void) doAction{
    
}

/*
 Check if creature still has item to use
 ----> true, if creature has less than 1 item
 */
+(BOOL) checkNoItemLeft: (Share *) myShareInRoom :(PageViewController*) pageView
{
    BOOL check = NO;
    
    switch (pageView.tabBarController.selectedIndex) {
        case 0:
            check = ([myShareInRoom getIntFromKey:@"fodder"] <= 1);
            break;
            
        case 1:
            check = ([myShareInRoom getIntFromKey:@"drinks"] <= 1);
            break;
        
        case 4:
            check = ([myShareInRoom getIntFromKey:@"shampoo"] <= 1);
            break;
    }
    
    return check;
}


/*
 Check if creature already full or not
  ----> true, if hunger / thirst of creature more than 80
 */

+(BOOL) checkFullness: (Share *) myShareInRoom :(PageViewController*) pageView
{
    BOOL check = NO;
    
    switch (pageView.tabBarController.selectedIndex) {
        case 0:
            if([myShareInRoom getIntFromKey:HUNGER] >= 80){
                check = true;
            }
            break;
            
        case 1:
            if([myShareInRoom getIntFromKey:THIRST] >= 80){
                check = true;
            };
            break;
            
        case 4:
            if([myShareInRoom getIntFromKey:DIRT] == 100){
                check = true;
            };
            
    }
    
    return check;
}

/*
 
 */
+(void) gainHealth:(Share*) myShareInRoom
{
    if([myShareInRoom getIntFromKey:@"health"] >= 80)
    {
        int difference = 100 - [myShareInRoom getIntFromKey:@"health"];
        [myShareInRoom updateKeyBy:@"health" :difference];
    } else {
        [myShareInRoom updateKeyBy:@"health" :20];
    }
        
}
@end
