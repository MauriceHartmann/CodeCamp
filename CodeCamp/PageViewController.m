//
//  PageViewController.m
//  CodeCamp
//
//  Created by Codecamp on 23.07.18.
//  Copyright © 2018 Codecamp. All rights reserved.
//

#import "PageViewController.h"

@interface PageViewController ()

@end

@implementation PageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.leftSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.leftSwipe.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.view addGestureRecognizer:self.leftSwipe];
    
    self.rightSwipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipe:)];
    self.rightSwipe.direction = UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:self.rightSwipe];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)handleSwipe:(UISwipeGestureRecognizer *)sender {
    if (sender.direction == UISwipeGestureRecognizerDirectionLeft) {
        switch (self.tabBarController.selectedIndex) {
            case 0:     // Home
                self.tabBarController.selectedIndex = 1;    // to Saloon
                break;

            case 1:     // Saloon
                self.tabBarController.selectedIndex = 2;    // to Mall
                break;

            case 2:     // Mall
                self.tabBarController.selectedIndex = 2;    // stay
                break;

            default:
                self.tabBarController.selectedIndex = 0;
                break;
        }
    }
    if (sender.direction == UISwipeGestureRecognizerDirectionRight) {
        switch (self.tabBarController.selectedIndex) {
            case 0:     // Home
                self.tabBarController.selectedIndex = 0;    // stay
                break;

            case 1:     // Saloon
                self.tabBarController.selectedIndex = 0;    // to Home
                break;

            case 2:     // Mall
                self.tabBarController.selectedIndex = 1;    // to Saloon
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
