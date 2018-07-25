//
//  PageViewController.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "PageViewController.h"
#import "AppDelegate.h"
#import "Share.h"
@interface PageViewController ()

@end

UIImageView * petView;

@implementation PageViewController
Share* mySharesView;
CGFloat height;
CGFloat width;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    width = [UIScreen mainScreen].bounds.size.width;
    height = [UIScreen mainScreen].bounds.size.height;
    petView= [[UIImageView alloc] init];
    UIImage *myimg = [UIImage imageNamed:@"blob"];
    petView.image=myimg;
    petView.frame = CGRectMake(width/2, height/2, 150, 150);
    [self.view addSubview:petView];
    
    
    mySharesView = Share.sharedSingleton;
    NSLog(@"LADEN");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
