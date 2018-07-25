//
//  GameOverController.m
//  CodeCamp
//
//  Created by Codecamp on 25.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GameOverController.h"
#import "AppDelegate.h"

@implementation GameOverController
- (IBAction)restartGame:(UIButton *)sender {
    [AppDelegate deleteFile];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
