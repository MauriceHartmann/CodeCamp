//
//  Saloon.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Saloon.h"
#import "Share.h"
#import "Creature.h"
#import "PageViewController.h"

@implementation Saloon

+(void) doAction: (Share*) myShares :(PageViewController*) pageView
{
    NSLog(@"In Saloon");
    
    if(![Room checkFullness:myShares :pageView])
    {
        if(![Room checkNoItemLeft:myShares :pageView])
        {
            [myShares updateKeyBy:@"thirst" :20];
            NSLog(@"Thirst gains by 20. Thirst left: %d.", [myShares getIntFromKey:@"thirst"]);
            [myShares updateKeyBy:@"drinks" :-2];
            NSLog(@"Drinks reduce by 2. Drinks left: %d.", [myShares getIntFromKey:@"drinks"]);
            [Room gainHealth:myShares];
            NSLog(@"Health: %d.", [myShares getIntFromKey:@"health"]);
            
        }else
        {
            NSLog(@"No Item left");
        }
    } else
    {NSLog(@"Not Thirsty!");}
}


@end
