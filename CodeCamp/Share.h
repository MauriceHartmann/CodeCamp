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
@end
#endif /* Share_h */
