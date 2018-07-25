//
//  Creature.h
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <UserNotifications/UserNotifications.h>

//If values fall below the specified Limits the pet is considered hungry, thirsty etc.
extern const int THIRST_LIMIT;
extern const int HUNGER_LIMIT;

//Max value for the needs.
extern const int MAX_VALUE_LIMIT;

//Name of the keys in the dictionary
extern NSString* HUNGER;
extern NSString* THIRST;
extern NSString* FODDER;
extern NSString* DRINKS;

//(random_factor + 1) is the max Number of Supply the pet loses per time_tick_factor
//example: random_factor = 9 => 1-10 Supply loss per tick
//time_tick_factor is the time the pet loses supply in seconds (900s = 15 min)

extern int random_factor;
extern double time_tick_factor;

@interface Creature : NSObject


-(void) initCreature;
-(void) checkNeeds;
-(void) sendNotification:(NSString*) title forSubtitle:(NSString*) subtitle forBody:(NSString*) body forIntervall: (NSInteger) intervall;
-(void) prepareBackgroundNotification;
@end
