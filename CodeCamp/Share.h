//
//  Share.h
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#ifndef Share_h
#define Share_h
#import <Foundation/Foundation.h>
@interface Share : NSObject {
    NSMutableDictionary *passedMutableDict;
}
@property NSMutableDictionary* passedMutableDict;
+ (Share *) sharedSingleton;
-(void) updateKeyBy:(NSString*) key : (int) num;
-(void) changeValueOfKey: (NSString*) key : (NSNumber*) value;
-(int) getIntFromKey:(NSString*) key;
-(NSArray*) getAllKeys;
+(NSNumber*) intToNS:(int) val;
-(void) createFromFile:(NSString*) path;
-(void) dictToTxt:(NSString*) path;
-(void) createKeyWith: (NSString*) key : (NSObject*) value;
-(void) initDict;
-(NSObject*) getObjectFromKey:(NSString*)key;
-(void)printAll;
@end
#endif /* Share_h */
