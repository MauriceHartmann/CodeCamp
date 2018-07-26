//
//  Room.h
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Creature.h"
#import "Share.h"
#import "PageViewController.h"

@interface Room : NSObject



+(void) doAction;

+(BOOL) checkNoItemLeft: (Share *) myShareInRoom :(PageViewController*) pageView;
+(BOOL) checkFullness: (Share *) myShareInRoom :(PageViewController*) pageView;

@end
