//
//  Kitchen.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Kitchen.h"

@implementation Kitchen
int MAX_THIRST = 100;

+(void) doAction: (Share*) myShares :(PageViewController *) pageView
{
    NSLog(@"In Kitchen");
    
    if(![Room checkFullness:myShares :pageView])
    {
        if(![Room checkNoItemLeft:myShares :pageView])
        {
            [myShares updateKeyBy:@"hunger" :20];
            [myShares updateKeyBy:DIRT :-2];
            NSLog(@"Hunger gain by 20. Hunger left: %d.", [myShares getIntFromKey:@"hunger"]);
            [myShares updateKeyBy:@"fodder" :-2];
            NSLog(@"Fodder reduce by 2. Fodder left: %d.", [myShares getIntFromKey:@"fodder"]);
            [Room gainHealth:myShares];
            NSLog(@"Health: %d.", [myShares getIntFromKey:@"health"]);
        }else
        {
            NSLog(@"No Item left");
        }
    } else
    {NSLog(@"Not Hungry");}
    
}
@end
