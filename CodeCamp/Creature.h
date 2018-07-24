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



@interface Creature : NSObject
-(void) initCreature;
-(void) checkNeeds;
- (void) sendNotification:(NSString*) title forSubtitle:(NSString*) subtitle forBody:(NSString*) body forIntervall: (NSInteger) intervall;
@end
