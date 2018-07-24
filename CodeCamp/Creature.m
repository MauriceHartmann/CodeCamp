//
//  Creature.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Creature.h"
#import "Share.h"

//If values fall below the specified Limits the pet is considered hungry, thirsty etc.
const int THIRST_LIMIT = 20;
const int HUNGER_LIMIT = 20;

//Max value for the needs.
const int MAX_VALUE_LIMIT = 100;

//random_factor is the max Number -1 of Supply the pet loses per time_tick_factor
//example: random_factor = 9 => 1-10 Supply loss per tick
//time_tick_factor is the time the pet loses supply in seconds

int random_factor = 9;
double time_tick_factor = 2.0;

//Name of the keys in the dictionary
NSString* HUNGER =  @"hunger";
NSString* THIRST =  @"thirst";
NSString* FODDER =  @"fodder";
NSString* DRINKS =  @"drinks";

NSMutableDictionary *dictCreature;
UITabBarController* mainView;
UIImageView* imageview;
Share* myShareCreature;
NSTimer *t;

@implementation Creature

-(void) initCreature
{
    [self initNotification];
    myShareCreature = Share.sharedSingleton;
    t = [NSTimer scheduledTimerWithTimeInterval: time_tick_factor
                                                                                                    target: self
                                                                                                       selector:@selector(onTick:)
                                                                                                    userInfo: nil repeats:YES];
}

-(void)onTick:(NSTimer*)timer
{
    [myShareCreature updateKeyBy:HUNGER :(arc4random_uniform(random_factor) + 1)*(-1) ];
    [self checkNeeds];
    NSLog(@"hunger: %d" ,[myShareCreature getIntFromKey:HUNGER]);
}

//checks if the pet is hungry,thirsty etc.
-(void) checkNeeds
{
    
    if([myShareCreature getIntFromKey:HUNGER] <  HUNGER_LIMIT)
    {
        NSLog(@"Hungry");
        int value = 100 - [myShareCreature getIntFromKey:HUNGER];
        [myShareCreature updateKeyBy:HUNGER :value ];
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

- (void) sendNotification:(NSString*) title forSubtitle:(NSString*) subtitle forBody:(NSString*) body forIntervall: (NSInteger) intervall
{
    if(isGrantedNotificationAccess)
    {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        
        UNMutableNotificationContent *content = [[UNMutableNotificationContent alloc] init];
        
        content.title = title;
        content.subtitle = subtitle;
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
    double hoursLeftTillNeed = (([myShareCreature getIntFromKey:HUNGER]-20) / ((random_factor + 1)/2))*2;
    [self sendNotification:@"CodeCamp" forSubtitle:@"Hunger" forBody:@"Hab Hunger!" forIntervall:hoursLeftTillNeed];
    
    hoursLeftTillNeed = (([myShareCreature getIntFromKey:THIRST]-20) / ((random_factor + 1)/2))*2;
    [self sendNotification:@"CodeCamp" forSubtitle:@"Durscht" forBody:@"ICH HAB BRAND!" forIntervall:hoursLeftTillNeed];
    
    
}


@end
