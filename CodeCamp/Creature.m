//
//  Creature.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Creature.h"
#import "Share.h"

NSMutableDictionary *dictCreature;
UITabBarController* mainView;
UIImageView* imageview;
NSTimer *t;

//If values fall below the specified Limits the pet is considered hungry, thirsty etc.
const int THIRST_LIMIT = 20;
const int HUNGER_LIMIT = 20;
int hunger = 100;


//Max value for the needs.
const int MAX_VALUE_LIMIT = 100;

@implementation Creature

-(void) initCreature
{
    dictCreature = Share.sharedSingleton.passedMutableDict;
    t = [NSTimer scheduledTimerWithTimeInterval: 2.0
                                                                                                    target: self
                                                                                                       selector:@selector(onTick:)
                                                                                                    userInfo: nil repeats:YES];
}

-(void)onTick:(NSTimer*)timer
{
    hunger = hunger - arc4random_uniform(9) - 1;
    [self checkNeeds];
    NSLog(@"hunger: %@" ,[NSNumber numberWithInt:(hunger)]);
}

//checks if the pet is hungry,thirsty etc.
-(void) checkNeeds
{
    if(hunger <= HUNGER_LIMIT)
    {
        NSLog(@"Hungry");
        [t invalidate];
        
    }
    
}

@end
