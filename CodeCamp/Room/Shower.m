//
//  Shower.m
//  CodeCamp
//
//  Created by Codecamp on 26.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Shower.h"
#import "Creature.h"
#import "Share.h"

@implementation Shower

+(void) doAction: (Share *) myShares :(PageViewController*) pageView
{
    if(![Room checkFullness:myShares :pageView])
    {
        if(![Room checkNoItemLeft:myShares :pageView])
        {
            [myShares changeValueOfKey:DIRT :@100];
            [myShares updateKeyBy:SHAMPOO :-1];
        }else
        {
            NSLog(@"No Shampoo left");
        }
    } else
    {NSLog(@"Not Dirty!");}
}

@end
