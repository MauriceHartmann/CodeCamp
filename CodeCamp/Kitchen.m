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
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh.mm.ss"];
    NSDate *dateNow = [myShares getObjectFromKey:@"time"];
    
    NSLog(@"Time: %@.", [timeFormat stringFromDate:dateNow]);
    
    if([Room checkFullness:myShares :pageView])
    {
        if(![Room checkNoItemLeft:myShares :pageView])
        {
            [myShares updateKeyBy:@"hunger" :20];
            NSLog(@"Hunger gain by 20. Hunger left: %d.", [myShares getIntFromKey:@"hunger"]);
            [myShares updateKeyBy:@"fodder" :-2];
            NSLog(@"Fodder reduce by 2. Fodder left: %d.", [myShares getIntFromKey:@"fodder"]);
        }else
        {
            NSLog(@"No Item left");
        }
    } else
    {NSLog(@"Not Hungry");}
    
}
@end
