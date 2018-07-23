//
//  Share.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Share.h"

@implementation Share
@synthesize passedMutableDict;

static Share *sharedSingleton = nil;
+ (Share *) sharedSingleton {
    @synchronized(self) {
        if (sharedSingleton == nil){
            sharedSingleton = [[self alloc] init];
        }
    }
    return sharedSingleton;
}
@end
