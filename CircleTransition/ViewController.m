//
//  ViewController.m
//  CircleTransition
//
//  Created by SONG Yu on 2/23/17.
//  Copyright © 2017 SONG Yu. All rights reserved.
//

#import "ViewController.h"
#import "CircleTransitionAnimator.h"

@interface ViewController () <UIViewControllerTransitioningDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    double frame_x = arc4random() % ((int)[UIScreen mainScreen].bounds.size.width - 50);
    double frame_y = arc4random() % ((int)[UIScreen mainScreen].bounds.size.height - 50);
    // Do any additional setup after loading the view, typically from a nib.
    self.showCircleTransitionButton = [[UIButton alloc] initWithFrame:CGRectMake(frame_x, frame_y, 50, 50)];
    self.showCircleTransitionButton.layer.cornerRadius = 25.0;
    self.showCircleTransitionButton.layer.masksToBounds = YES;
    [self.showCircleTransitionButton setTitle:@"circle" forState:UIControlStateNormal];
    self.showCircleTransitionButton.backgroundColor = [UIColor colorWithRed:0.1 green:0.7 blue:1.0 alpha:1.0];
    [self.showCircleTransitionButton addTarget:self action:@selector(showCircleTransition:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:self.showCircleTransitionButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showCircleTransition: (UIButton *)sender
{
    UIViewController *effectVC = [UIViewController new];
    effectVC.view.backgroundColor = [UIColor colorWithRed:0.5 green:0.5 blue:0.8 alpha:1.0];
    effectVC.modalPresentationStyle = UIModalPresentationCustom;
    effectVC.transitioningDelegate = self;
    
    UIButton *dismissButton = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 50, 50)];
    [dismissButton setTitle:@"close" forState:UIControlStateNormal];
    [dismissButton setBackgroundColor:[UIColor yellowColor]];
    [dismissButton addTarget:self action:@selector(dismissVC) forControlEvents:UIControlEventTouchUpInside];
    [effectVC.view addSubview:dismissButton];
    
    [self presentViewController:effectVC animated:YES completion:nil];
}

- (void)dismissVC
{
    [self.presentedViewController dismissViewControllerAnimated:YES completion:NULL];
}

#pragma mark - UIViewControllerTransitioningDelegate

- (id <UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    return [CircleTransitionAnimator new];
}

@end
