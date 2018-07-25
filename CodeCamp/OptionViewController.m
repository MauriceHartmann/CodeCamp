//
//  OptionViewController.m
//  CodeCamp
//
//  Created by Codecamp on 24.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OptionViewController.h"
#import "AppDelegate.h"
#import "Share.h"
@interface OptionViewController ()

@end

@implementation OptionViewController
Share* myShares;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    myShares = Share.sharedSingleton;
}

- (IBAction)deleteFile:(UIButton *)sender {
    NSLog(@"call");
    [AppDelegate deleteFile];
}
- (IBAction)triggerHunger:(UIButton *)sender {
    NSNumber *num = [NSNumber numberWithInt:20];
    [myShares changeValueOfKey:@"hunger":num];
}
- (IBAction)triggerThirst:(UIButton *)sender {
    NSNumber *num = [NSNumber numberWithInt:20];
    [myShares changeValueOfKey:@"thirst":num];
    
}
- (IBAction)killAnimal:(UIButton *)sender {
    NSNumber *num = [NSNumber numberWithInt:0];
    [myShares changeValueOfKey:@"thirst":num];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
