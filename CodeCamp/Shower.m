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
    
    [myShares changeValueOfKey:DIRT :@100];
}

@end
