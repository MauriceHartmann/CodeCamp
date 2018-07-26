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

+(void) doAction: (Share*) myShares
{
    
    
    NSLog(@"In Saloon");
    
    //drinks reduces 2
    if([myShares getIntFromKey:@"drinks"] > 0)
    {
        [myShares updateKeyBy:@"drinks" :-2];
        
        //Thirst gain 20 Point
        if([myShares getIntFromKey:@"thirst"] < 100)
        {
            if([myShares getIntFromKey:@"thirst"] >= 80)
            {
                int difference = 100 - [myShares getIntFromKey:@"thirst"];
                [myShares updateKeyBy:@"thirst" :difference];
            }
            else
            {
                [myShares updateKeyBy:@"thirst" :20];
            }
        }
    }    
    
}


@end
