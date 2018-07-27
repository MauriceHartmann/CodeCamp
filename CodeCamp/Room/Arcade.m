//
//  Arcade.m
//  CodeCamp
//
//  Created by Codecamp on 27.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Arcade.h"
#import "PageViewController.h"

@implementation Arcade

+(void) doAction : (Share *) myShares : (PageViewController *) pageView
{
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"GameScreen"];
    [pageView presentViewController:vc animated:YES completion:nil];
    
}

@end
