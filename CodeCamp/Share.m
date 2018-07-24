//
//  Share.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Share.h"

//Create a Singleton to make the Dictionary accessible to all classes

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
//Only the functions below must be used to ensure Thread Safety when acessing the Dictionary

-(void) createKeyWith: (NSString*) key : (NSObject*) value{
    @synchronized(passedMutableDict){
        [passedMutableDict setObject:value forKey:key];
    }
}

-(void) changeValueOfKey: (NSString*) key : (NSNumber*) value{
    @synchronized(passedMutableDict){
        [passedMutableDict setValue:value forKey:key];
    }
}

-(void) updateKeyBy:(NSString*) key : (int) num{
    @synchronized(passedMutableDict){
        NSNumber *nsNum = [passedMutableDict valueForKey:key];
        int temp = [nsNum intValue];
        temp += num;
        if(temp < 0){
            temp = 0;
        }
        nsNum = [Share intToNS:temp];
        [passedMutableDict setValue:nsNum forKey:key];
    }
}

-(int) getIntFromKey:(NSString*) key{
    @synchronized(passedMutableDict){
        NSNumber *nsNum = [passedMutableDict valueForKey:key];
        return [nsNum intValue];
    }
    
}

-(NSArray*)getAllKeys{
    return [passedMutableDict allValues];
}

+ (NSNumber*)intToNS:(int) val{ // HelpMethod
    NSNumber *t = [NSNumber numberWithInt:(val)];
    return t;
}

-(void) createFromFile:(NSString*) path{
    passedMutableDict = [NSMutableDictionary dictionaryWithContentsOfFile:path];
    
}

-(void) dictToTxt:(NSString*) path{
    [passedMutableDict writeToFile:path atomically:YES];
}

-(void) initDict{
    if(passedMutableDict == nil)
    passedMutableDict = [NSMutableDictionary dictionary];
}
@end


