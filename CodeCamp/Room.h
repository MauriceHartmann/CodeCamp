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

@interface Room : NSObject
{
    Share * myShareInRoom;
}

+(void) doAction;
@end
