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

+(void) doAction: (Share*) myShares
{
    NSLog(@"In Kitchen");
    
    //Fodder reduces 2
        if([myShares getIntFromKey:@"fodder"] > 0)
        {
            [myShares updateKeyBy:@"fodder" :-2];
           
            //Hunger gain 20 Point
            if([myShares getIntFromKey:@"hunger"] < 100)
            {
                if([myShares getIntFromKey:@"hunger"] >= 80)
                {
                    int difference = 100 - [myShares getIntFromKey:@"hunger"];
                    [myShares updateKeyBy:@"hunger" :difference];
                }
                else
                {
                    [myShares updateKeyBy:@"hunger" :20];
                }
            }
        }   
}
@end
