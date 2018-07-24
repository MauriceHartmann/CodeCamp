//
//  NotificationHandler.h
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <UserNotifications/UserNotifications.h>

@interface NotificationHandler : NSObject

- (void) initNotification;

- (void) sendNotification:(NSString*) title forSubtitle:(NSString*) subtitle forBody:(NSString*) body forIntervall: (NSInteger) intervall;

@end

