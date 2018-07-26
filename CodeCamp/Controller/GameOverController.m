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
CGFloat gOheight;
CGFloat gOwidth;
int gOpetViewWidth;
int gOpetViewHeight;
UIImageView * gOpetView;

-(void) viewDidLoad{
    
    gOwidth = [UIScreen mainScreen].bounds.size.width;
    gOheight = [UIScreen mainScreen].bounds.size.height;
    gOpetViewWidth = gOwidth * 0.5;
    gOpetViewHeight = gOheight * 0.2;
    
    gOpetView= [[UIImageView alloc] init];
    UIImage *myimg = [UIImage imageNamed:@"LeDeadBlob"];
    gOpetView.image=myimg;
    gOpetView.frame = CGRectMake(gOwidth/2 - gOpetViewWidth /2, gOheight/3 + gOpetViewHeight/2 + 50, gOpetViewWidth, gOpetViewHeight);
    [self.view addSubview:gOpetView];
    
}

- (IBAction)restartGame:(UIButton *)sender {
    [AppDelegate deleteFile];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
