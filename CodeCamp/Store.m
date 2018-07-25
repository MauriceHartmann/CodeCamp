//
//  Store.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "Store.h"
#import "PageViewController.h"

@implementation Store

+(void) doAction : (Share *) myShares : (PageViewController *) pageView
{
    
    table = [[UITableView alloc] init];
    tableWidth = [UIScreen mainScreen].bounds.size.width *0.9;
    tableHeight = [UIScreen mainScreen].bounds.size.height*0.8;
    tablePosX = ([UIScreen mainScreen].bounds.size.width - tableWidth) / 2;
    tablePosY = ([UIScreen mainScreen].bounds.size.height - tableHeight) / 2;
    table.frame = CGRectMake(tablePosX, tablePosY, tableWidth, tableHeight);
    [pageView.view addSubview:table];
    
}



@end
