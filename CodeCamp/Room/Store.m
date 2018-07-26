//
//  Store.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Store.h"
#import "PageViewController.h"

UILabel *foodInventory;
UILabel *drinkInventory;
Share * storeShare;
@implementation Store

+(void) doAction : (Share *) myShares : (PageViewController *) pageView
{
    storeShare = myShares;
    NSString * storyboardName = @"Main";
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:storyboardName bundle: nil];
    UIViewController * vc = [storyboard instantiateViewControllerWithIdentifier:@"Shop"];
    [pageView presentViewController:vc animated:YES completion:nil];
    
}

@end
