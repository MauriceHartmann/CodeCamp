//
//  Creature.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Creature.h"
#import "Share.h"
#import <SpriteKit/SpriteKit.h>

//If values fall below the specified Limits the pet is considered hungry, thirsty etc.
const int THIRST_LIMIT = 20;
const int HUNGER_LIMIT = 20;
const int DIRT_LIMIT = 20;
const int HEALTH_LIMIT = 20;

//Max value for the needs.
const int MAX_VALUE_LIMIT = 100;

//(random_factor + 1) is the max Number of Supply the pet loses per time_tick_factor
//example: random_factor = 9 => 1-10 Supply loss per tick
//time_tick_factor is the time the pet loses supply in seconds (900s = 15 min)

int random_factor = 1;
double time_tick_factor = 5.0;

//Name of the keys in the dictionary
NSString* HUNGER =  @"hunger";
NSString* THIRST =  @"thirst";
NSString* FODDER =  @"fodder";
NSString* DRINKS =  @"drinks";
NSString* LIFE   =  @"life";
NSString* MONEY  =  @"money";
NSString* DIRT   =  @"dirt";
NSString* SLEEP  =  @"sleep";
NSString* HEALTH =  @"health";

NSMutableDictionary *dictCreature;
UITabBarController* mainView;
UIImageView* imageview;
Share* myShareCreature;
NSTimer *t;
NSTimer *t2;
NSDate* currentTime;
NSDateFormatter *timeFormat;
NSInteger *currentTimeInteger;

@implementation Creature



-(void) initCreature
{
    NSLog(@"Pet init");
    [self initNotification];
    myShareCreature = Share.sharedSingleton;
    
    //timer that decreases the needs of the creature in the onTick Method
    //timer ticks every "time_tick_factor" and calls the method onTick:
    t = [NSTimer scheduledTimerWithTimeInterval: time_tick_factor
                                                                                                    target: self
                                                                                                       selector:@selector(onTick:)
                                                                                                    userInfo: nil repeats:YES];
 
    currentTime = [NSDate date];
    timeFormat = [[NSDateFormatter alloc] init];
    //Set as 24H format
    [timeFormat setDateFormat:@"HHmm"];
    NSString *strCurrentTime =[timeFormat stringFromDate:currentTime];
    currentTimeInteger = [strCurrentTime integerValue];
}

//timer method that ticks every Intervall of the timer
-(void)onTick:(NSTimer*)timer
{
    if([myShareCreature getIntFromKey:SLEEP] != 0)
    {
        //decrease hunger and checks if the creature is hungry
        int decrease_factor = (arc4random_uniform(random_factor) + 1)*(-1);
        if([myShareCreature getIntFromKey:HUNGER] - decrease_factor < 0){
            [myShareCreature updateKeyBy:HUNGER : decrease_factor +  [myShareCreature getIntFromKey:HUNGER] - decrease_factor];
        }
        else
        {
            [myShareCreature updateKeyBy:HUNGER :decrease_factor];
        }
        [self checkNeeds];
        //NSLog(@"hunger: %d" ,[myShareCreature getIntFromKey:HUNGER]);
        
        //decrease thirst and checks if the creature is thirsty
        
         decrease_factor = (arc4random_uniform(random_factor) + 1)*(-1);
         if([myShareCreature getIntFromKey:THIRST] - decrease_factor < 0){
         [myShareCreature updateKeyBy:THIRST : decrease_factor +  [myShareCreature getIntFromKey:THIRST] - decrease_factor];
         }
         else
         {
         [myShareCreature updateKeyBy:THIRST :decrease_factor];
         }
         [self checkNeeds];
        // NSLog(@"thirst: %d" ,[myShareCreature getIntFromKey:THIRST]);
        
        
       // decrease dirt and checks if the creature is dirty
        
        decrease_factor = (arc4random_uniform(random_factor) + 1)*(-1);
        if([myShareCreature getIntFromKey:DIRT] - decrease_factor < 0){
            [myShareCreature updateKeyBy:DIRT : decrease_factor +  [myShareCreature getIntFromKey:DIRT] - decrease_factor];
        }
        else
        {
            [myShareCreature updateKeyBy:DIRT :decrease_factor];
        }
        [self checkNeeds];
        //NSLog(@"DIRT: %d" ,[myShareCreature getIntFromKey:DIRT]);
    }
}




/*
 Method check whether it is day or not
 ---> YES, it is night
 ---> NO, it is day
 */
- (BOOL) checkNight
{
    currentTime = [NSDate date];
    NSString *strCurrentTime =[timeFormat stringFromDate:currentTime];
    currentTimeInteger = [strCurrentTime integerValue];
//    NSLog(@"Current time: %@.", strCurrentTime);
    
    //Check current time between sleeptime (21:00) to 23:59
    if(currentTimeInteger > [myShareCreature getIntFromKey:@"sleepTime"] && currentTimeInteger <= [myShareCreature getIntFromKey:@"midnight"])
    {
        [myShareCreature changeValueOfKey:SLEEP :@0];
        NSLog(@"Sleep");
        return YES;
    }
    
    //Check current time between 00:00 to wake up time (07:30)
    if(currentTimeInteger > 0 && currentTimeInteger <= [myShareCreature getIntFromKey:@"awakeTime"])
    {
        [myShareCreature changeValueOfKey:SLEEP :@0];
        NSLog(@"Sleep");
        return YES;
    }
    
    NSLog(@"It is day!");
    [myShareCreature changeValueOfKey:SLEEP :@1];
    return NO;
}

//checks if the pet is hungry,thirsty etc.
-(void) checkNeeds
{
    
    //Hunger never under 0
    if([myShareCreature getIntFromKey:HUNGER] <= 0)
    {
        [myShareCreature updateKeyBy:HUNGER :0];
    }
    
    //Check current hunger and reduce the health
    if([myShareCreature getIntFromKey:HUNGER] >= 5 && [myShareCreature getIntFromKey:HUNGER] <80)
    {
        [myShareCreature updateKeyBy:HEALTH : -1];
    } else {
        //Current hunger < 5
        //Reduce health by 2
        [myShareCreature updateKeyBy:HEALTH : -2];
    }
    
    //Thirst never under 0
    if([myShareCreature getIntFromKey:THIRST] <= 0)
    {
        [myShareCreature updateKeyBy:THIRST :0];
    }
    
    if([myShareCreature getIntFromKey:THIRST] >= 5 && [myShareCreature getIntFromKey:THIRST] <80)
    {
        [myShareCreature updateKeyBy:HEALTH : -1];
    } else {
        //Current thirst < 5
        //Reduce health by 2
         [myShareCreature updateKeyBy:HEALTH : -2];
    }
    
    //Health never under 0
    if([myShareCreature getIntFromKey:HEALTH] <= 0)
    {
        [myShareCreature updateKeyBy:HEALTH :0];
    }
    
    //Creature dead when hungry, thirst and health equal 0
    if ([myShareCreature getIntFromKey:HEALTH] < 0 &&
            [myShareCreature getIntFromKey:THIRST] < 0 &&
            [myShareCreature getIntFromKey:HUNGER] < 0 ) {
        [myShareCreature changeValueOfKey:@"life" :@0];
        NSLog(@"Dead");
    }
    
//    if([myShareCreature getIntFromKey:HUNGER] <  1){
//        [myShareCreature changeValueOfKey:@"life" :@0];
//    }
//
//    if([myShareCreature getIntFromKey:THIRST] <  1){
//        [myShareCreature changeValueOfKey:@"life" :@0];
//    }

    
    
    //checks hunger
    if([myShareCreature getIntFromKey:HUNGER] <  HUNGER_LIMIT)
    {
        NSLog(@"hungry");
    }
    
    //checks thirst
    if([myShareCreature getIntFromKey:THIRST] <  THIRST_LIMIT)
    {
        NSLog(@"thirsty");
    }
  
    //Check health
    if([myShareCreature getIntFromKey:HEALTH] <  HEALTH_LIMIT)
    {
        NSLog(@"dying");
    }
}


/*
 How it works:
 
 NotificationHandler* notifications;
 @implementation exampleClass
 - (void)initExampleClass {
 notifications = [[NotificationHandler alloc]init];
 [notifications initNotification];
 }
 - void send{
 [notifications sendNotification:@"This " forSubtitle:@"is a" forBody:@"test" forIntervall:5];
 }
 
 */

bool isGrantedNotificationAccess;

// needs do be initilized to send Notifications to the users
// initilazies/enables the Push Notifiactions
- (void) initNotification {
    
    isGrantedNotificationAccess = false;
    
    UNUserNotificationCenter *center =  [UNUserNotificationCenter currentNotificationCenter];
    
    UNAuthorizationOptions options = UNAuthorizationOptionAlert + UNAuthorizationOptionAlert;
    
    [center requestAuthorizationWithOptions:options completionHandler:^(BOOL granted, NSError * _Nullable error) {
        isGrantedNotificationAccess = granted;
    }];
}
//allows you to send a push notification
//title:     headline for the notification
//subtitle:  second headline ?!?
//body:      smaller Text part for informations
//intervall: amount of seconds until the notifications pops up

+ (void) sendNotification:(NSString*) title forSubtitle:(NSString*) subtitle forBody:(NSString*) body forIntervall: (NSInteger) intervall
{
    if(isGrantedNotificationAccess)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        
        content.title = title;
        content.subtitle = @"";
        content.body = body;
        content.sound = [UNNotificationSound defaultSound];
        
        UNTimeIntervalNotificationTrigger *trigger = [UNTimeIntervalNotificationTrigger triggerWithTimeInterval:intervall repeats:NO];
        
        //setting up the request for notification
        UNNotificationRequest *request = [UNNotificationRequest requestWithIdentifier:subtitle content:content trigger:trigger];
        
        [center addNotificationRequest:request withCompletionHandler:nil];
        
    }
}

//prepares the notifications when the app is in background
-(void) prepareBackgroundNotification
{
    int correction = 0;
    int needValue = [myShareCreature getIntFromKey:HUNGER]-20;
    if(needValue < 1 )
    {
        needValue = 1;
        correction = time_tick_factor;
    }
    double hoursLeftTillNeed = ((needValue / ((random_factor + 1)/2)))*time_tick_factor;
    [Creature sendNotification:@"CodeCamp" forSubtitle:@"Hunger" forBody:@"Hab Hunger!" forIntervall:hoursLeftTillNeed];
    NSLog(@"Current Hunger: %d Pet will be hungry in %f minutes",[myShareCreature getIntFromKey:HUNGER],((hoursLeftTillNeed-correction)/60) );
    
    
    needValue = [myShareCreature getIntFromKey:THIRST]-20;
    correction = 0;
    if(needValue < 1 )
    {
        needValue = 1;
        correction = time_tick_factor;
    }
    hoursLeftTillNeed = (needValue / ((random_factor + 1)/2))*time_tick_factor;
    [Creature sendNotification:@"CodeCamp" forSubtitle:@"Durscht" forBody:@"ICH HAB BRAND!" forIntervall:hoursLeftTillNeed];
    NSLog(@"Current thirst: %d Pet will be thirsty in %f minutes",[myShareCreature getIntFromKey:THIRST],((hoursLeftTillNeed-correction)/60) );
    
}

+(void) updateAfterReturn{
    NSTimeInterval interval = [(NSDate*)[myShareCreature getObjectFromKey:@"time"] timeIntervalSinceNow];
    NSLog(@"Interval: %f" ,interval);
    while(interval<(-(time_tick_factor-1))){
        interval += time_tick_factor;
        
        [myShareCreature updateKeyBy:@"hunger" :(-1)];
        [myShareCreature updateKeyBy:@"thirst" :(-1)];
        NSLog(@"reappear");
        NSLog(@"Rhunger: %d" ,[myShareCreature getIntFromKey:HUNGER]);
        
    }
    
}


@end
