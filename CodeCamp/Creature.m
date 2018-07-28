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
const int AWAKE_LIMIT = 20;

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
NSString* LIFE = @"life";
NSString* MONEY = @"money";
NSString* DIRT = @"dirt";
NSString* AWAKE  =  @"awake";
NSString* SLEEP  =  @"sleep";
NSString* SHAMPOO = @"shampoo";
NSString* BEDTIME  = @"sleepTime";
NSString* WAKINGTIME = @"awakeTime";

NSMutableDictionary *dictCreature;
UITabBarController* mainView;
UIImageView* imageview;
Share* myShareCreature;
NSTimer *t;
NSTimer *t2;
NSDate* currentTime;
NSDateFormatter *timeFormat;
NSInteger currentTimeInteger;
NSTimeInterval nightDuration;

@implementation Creature



-(void) initCreature
{
    NSLog(@"Pet init");
    [self initNotification];
    myShareCreature = Share.sharedSingleton;
    int timeForSleep = (24 - (([myShareCreature getIntFromKey:BEDTIME]/100)-([myShareCreature getIntFromKey:WAKINGTIME]/100)));
    NSLog(@"%d",timeForSleep);
    nightDuration = timeForSleep * 3600;
    //timer that decreases the needs of the creature in the onTick Method
    //timer ticks every "time_tick_factor" and calls the method onTick:
    t = [NSTimer scheduledTimerWithTimeInterval: time_tick_factor
                                                                                                    target: self
                                                                                                       selector:@selector(onTick:)
                                                                                                    userInfo: nil repeats:YES];
    t2 = [NSTimer scheduledTimerWithTimeInterval: 5.0
                                          target: self
                                        selector:@selector(onTickEnergie:)
                                        userInfo: nil repeats:YES];
    
    currentTime = [NSDate date];
    timeFormat = [[NSDateFormatter alloc] init];
    //Set as 24H format
    [timeFormat setDateFormat:@"HHmm"];
    NSString *strCurrentTime =[timeFormat stringFromDate:currentTime];
    currentTimeInteger = [strCurrentTime integerValue];
    NSLog(@"Time on start: %ld.", currentTimeInteger);
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
 Timer method, that check tiredness of creature
 */
-(void)onTickEnergie:(NSTimer*) timer
{
    //decrease energie every 30s
    int decrease_sleep_factor = 0;
    
    //check if it is day
    if(![self checkNight])
    {
        //Energy wont drop under 0
        if([myShareCreature getIntFromKey:AWAKE] > 0)
        {
            //energy decreased faster under awake limit
            if([myShareCreature getIntFromKey:AWAKE] <= AWAKE_LIMIT)
            {
                decrease_sleep_factor = - 2;
            }
            //energy decrease normal
            else
            {
                decrease_sleep_factor = - 1;
            }
        }
    }
    [myShareCreature updateKeyBy:AWAKE :decrease_sleep_factor];
    [self checkEnergie];
}


/*
 Method check whether it is day or not
 ---> YES, it is night
 ---> NO, it is day
 */
- (BOOL) checkNight
{
    if([Creature isDuringSleepTime:[NSDate date]] == YES){
        [myShareCreature changeValueOfKey:SLEEP :@0];
        NSLog(@"Sleep");
        return YES;
    }
    NSLog(@"It is day!");
    [myShareCreature changeValueOfKey:SLEEP :@1];
    return NO;
}

/*
 NOT DONE YET!
 */
-(void) checkEnergie
{
    if([myShareCreature getIntFromKey:AWAKE] < 1){
        [myShareCreature changeValueOfKey:SLEEP :@0];
        NSLog(@"Sleep");
    }
    
    if([ myShareCreature getIntFromKey:SLEEP] == 0)
    {
        [myShareCreature updateKeyBy:HUNGER :-1];
        [myShareCreature updateKeyBy:THIRST :-1];
        
        //Gain energy by 10 points every 30 sec
        [myShareCreature updateKeyBy:AWAKE :10];
        
        NSLog(@"Gain energy");
    }
    
    //check creature tired or not
    if([myShareCreature getIntFromKey:AWAKE] <  AWAKE_LIMIT)
    {
        NSLog(@"tired");
    }
    
    //wake up if energie full
    if([ myShareCreature getIntFromKey:SLEEP] == 0 && [myShareCreature getIntFromKey:AWAKE] >= 50)
    {
        //Max awake limit not exceed
        [myShareCreature changeValueOfKey:AWAKE :@50];
        
        //Wake up the creature
        [myShareCreature changeValueOfKey:SLEEP :@1];
        
        NSLog(@"Awake");
    }
 
}

//checks if the pet is hungry,thirsty etc.
-(void) checkNeeds
{
    if([myShareCreature getIntFromKey:HUNGER] <  1){
        [myShareCreature changeValueOfKey:LIFE :@0];
    }
    
    if([myShareCreature getIntFromKey:THIRST] <  1){
        [myShareCreature changeValueOfKey:LIFE :@0];
    }

    
    
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
//subtitle:  second headline ?!? Is used as notifiactionIdentifier
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
        correction = time_tick_factor; // correction is needed if need value had to be raised to avoid Exception
    }
    
    //hoursLeftTillNeed is the approx. time until the pet is hungry,thirst etc.
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
    
    //hoursLeftTillNeed is the approx. time until the pet is hungry,thirst etc.
    hoursLeftTillNeed = (needValue / ((random_factor + 1)/2))*time_tick_factor;
    [Creature sendNotification:@"CodeCamp" forSubtitle:@"Durscht" forBody:@"ICH HAB BRAND!" forIntervall:hoursLeftTillNeed];
    NSLog(@"Current thirst: %d Pet will be thirsty in %f minutes",[myShareCreature getIntFromKey:THIRST],((hoursLeftTillNeed-correction)/60) );
    
    needValue = [myShareCreature getIntFromKey:DIRT]-20;
    correction = 0;
    if(needValue < 1 )
    {
        needValue = 1;
        correction = time_tick_factor;
    }
    
    //hoursLeftTillNeed is the approx. time until the pet is hungry,thirst etc.
    hoursLeftTillNeed = (needValue / ((random_factor + 1)/2))*time_tick_factor;
    [Creature sendNotification:@"CodeCamp" forSubtitle:DIRT forBody:@"Ich bin dreckig. FeelsBadMan" forIntervall:hoursLeftTillNeed];
    NSLog(@"Current dirt: %d Pet will be dirty in %f minutes",[myShareCreature getIntFromKey:DIRT],((hoursLeftTillNeed-correction)/60) );
    
    //random Notifications if an item in the inventory is almost empty
    int randomNotification = 0;
    if([myShareCreature getIntFromKey:FODDER] < 2)
    {
        //3600s = 1h => notification will pop between 1 and 6 hours;
        randomNotification = arc4random_uniform(3600*5) + 3600;
        [Creature sendNotification:@"CodeCamp" forSubtitle:FODDER forBody:@"Das Essen wird knapp" forIntervall:randomNotification];
    }
    
    if([myShareCreature getIntFromKey:DRINKS] < 2)
    {
        //3600s = 1h => notification will pop between 1 and 6 hours;
        randomNotification = arc4random_uniform(3600*5) + 3600;
        [Creature sendNotification:@"CodeCamp" forSubtitle:DRINKS forBody:@"Das Trinken wird knapp" forIntervall:randomNotification];
    }
    
    if([myShareCreature getIntFromKey:SHAMPOO] < 2)
    {
        //3600s = 1h => notification will pop between 1 and 6 hours;
        randomNotification = arc4random_uniform(3600*5) + 3600;
        [Creature sendNotification:@"CodeCamp" forSubtitle:SHAMPOO forBody:@"Das Shampoo wird knapp" forIntervall:randomNotification];
    }
    
}

+(BOOL) isDuringSleepTime:(NSDate*) date{ //returns YES if nighttime
    NSString *z = [timeFormat stringFromDate:date];
    NSInteger timeInt = [z integerValue];
    //Check current time between sleeptime (21:00) to 23:59
    if(timeInt > [myShareCreature getIntFromKey:@"sleepTime"] && timeInt <= [myShareCreature getIntFromKey:@"midnight"])
    {
        return YES;
    }
    
    //Check current time between 00:00 to wake up time (07:00)
    if(timeInt >= 0 && currentTimeInteger <= [myShareCreature getIntFromKey:@"awakeTime"])
    {
        return YES;
    }
    return NO;
}


+(void) updateAfterReturn{
    NSTimeInterval interval;
    NSDate *last = (NSDate*)[myShareCreature getObjectFromKey:@"time"];
    if([Creature isDuringSleepTime :last]&&[Creature isDuringSleepTime:[NSDate date]]){ //Asleep lasttime & still asleep now
        NSLog(@"Returning");
        return; //Dont substract anything
    }else if(![Creature isDuringSleepTime :last]&&![Creature isDuringSleepTime:[NSDate date]]){
        interval = [last timeIntervalSinceNow] + ([Creature dateDifference:[NSDate date] :last]*nightDuration);
        NSLog(@"both awake + nightDur %f",nightDuration/3600);
    }else if([Creature isDuringSleepTime :last]&&![Creature isDuringSleepTime:[NSDate date]]){ // last value was during sleeptime; currently awake
        interval = [[Creature intToDate:[myShareCreature getIntFromKey:@"awakeTime"]] timeIntervalSinceDate: [NSDate date]]; // only substract from awake time to current time
        NSLog(@"last time was sleeptime");
    }else if(![Creature isDuringSleepTime :last]&&[Creature isDuringSleepTime:[NSDate date]]){ // last value was during daytime; currently asleep
        interval = [[Creature intToDate:[myShareCreature getIntFromKey:@"sleepTime"]] timeIntervalSinceDate: last]; // only substract from last Time to Sleep Time
        NSLog(@"last time was awaketime");
    }else{ //Error
        interval = [last timeIntervalSinceNow];
        NSLog(@"timeError");
    }
    //Correct Values based on Interval
    NSLog(@"Interval in Minuten: %f" ,interval/60);
    NSLog(@"Interval in Stunden: %f" ,interval/3600);
    while(interval<(-(time_tick_factor-1))){
        interval += time_tick_factor;
        
        [myShareCreature updateKeyBy:@"hunger" :(-1)];
        [myShareCreature updateKeyBy:@"thirst" :(-1)];
        NSLog(@"reappear");
        NSLog(@"Rhunger: %d" ,[myShareCreature getIntFromKey:HUNGER]);
        
    }
    
}

+(NSDate*) intToDate:(int) time{ // creates Date out of time (Day is always today)
    NSDateComponents *comps = [[NSCalendar currentCalendar] components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear fromDate:[NSDate date]];
    [comps setHour:(time/100)];
    NSLog(@"%@",[[NSCalendar currentCalendar] dateFromComponents:comps]);
    return [[NSCalendar currentCalendar] dateFromComponents:comps];
}

+(int)dateDifference:(NSDate*) from :(NSDate*) to{ // Calculate if days/moths or years have passed
    NSTimeInterval passed = [to timeIntervalSinceDate:from];
    if (passed<-86400||passed>86400){
        [myShareCreature changeValueOfKey:LIFE :0];
        return 1;
    }
    NSDateComponents *component1 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:to];
    NSDateComponents *component2 = [[NSCalendar currentCalendar] components:NSCalendarUnitDay fromDate:from];
    if(component1.day == component2.day){
        NSLog(@"DAY is the same!");
        return 0; //Date didn´t change
    }else{
        return 1; //Date changed
    }
};



@end
