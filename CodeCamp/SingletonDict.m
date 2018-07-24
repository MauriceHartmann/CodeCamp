//
//  SingletonDict.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SingletonDict.h"

@implementation SingletonDict
static SingletonDict *singletonObject = nil;

+ (id) sharedSampleSingletonClass
{
    if (! singletonObject) {
        
        singletonObject = [[SingletonDict alloc] init];
    }
    return singletonObject;
}

- (id)init
{
    if (! singletonObject) {
        
        singletonObject = [super init];
        // Uncomment the following line to see how many times is the init method of the class is called
        // NSLog(@"%s", __PRETTY_FUNCTION__);
    }
    return singletonObject;
}

@end
