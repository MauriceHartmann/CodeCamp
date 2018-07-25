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
    // Handle Swipes
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
    
    //creature Setup
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

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
            /*
                0 -> Home
                1 -> Saloon
                2 -> Mall
                3 -> Options
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 1;
                break;

            case 1:
                self.tabBarController.selectedIndex = 2;
                break;

            case 2:
                self.tabBarController.selectedIndex = 2;
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
            /*
                0 -> Home
                1 -> Saloon
                2 -> Mall
                3 -> Options
             */
        switch (self.tabBarController.selectedIndex) {
            case 0:
                self.tabBarController.selectedIndex = 0;
                break;

            case 1:
                self.tabBarController.selectedIndex = 0;
                break;

            case 2:
                self.tabBarController.selectedIndex = 1;
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
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
