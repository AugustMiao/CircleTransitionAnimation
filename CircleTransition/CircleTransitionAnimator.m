//
//  CircleTransitionAnimator.m
//  CircleTransition
//
//  Created by SONG Yu on 2/23/17.
//  Copyright © 2017 SONG Yu. All rights reserved.
//

#import "CircleTransitionAnimator.h"
#import "ViewController.h"
#import <UIKit/UIKit.h>

@interface CircleTransitionAnimator() <UIViewControllerAnimatedTransitioning>

@property(nonatomic, weak) id<UIViewControllerContextTransitioning> transitionContext;

@end

@implementation CircleTransitionAnimator

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 1.0f;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    self.transitionContext = transitionContext;
    
    ViewController *fromVC = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIButton *fromButton = fromVC.showCircleTransitionButton;
    UIView *containerView = [transitionContext containerView];
    
    [containerView addSubview:toVC.view];
    
    UIBezierPath *circleMaskPathInitial = [UIBezierPath bezierPathWithOvalInRect:fromButton.frame];
    double extremePoint_x = (fromButton.center.x - 0) > (fromVC.view.bounds.size.width - fromButton.center.x) ? fromButton.center.x : (fromVC.view.bounds.size.width - fromButton.center.x);
    double extremePoint_y = (fromButton.center.y - 0) > (fromVC.view.bounds.size.height - fromButton.center.y) ? fromButton.center.y : (fromVC.view.bounds.size.height - fromButton.center.y);
    
    CGPoint extremePoint = CGPointMake(extremePoint_x, extremePoint_y);
    double radius = sqrt((extremePoint.x * extremePoint.x) + (extremePoint.y) * (extremePoint.y));
    UIBezierPath *circleMaskPathFinal = [UIBezierPath bezierPathWithOvalInRect: CGRectInset(fromButton.frame, -radius, -radius)];  
    
    CAShapeLayer *maskLayer = [CAShapeLayer new];
    maskLayer.path = circleMaskPathFinal.CGPath;
    toVC.view.layer.mask = maskLayer;
    
    CABasicAnimation *maskLayerAnimation = [CABasicAnimation animationWithKeyPath:@"path"];
    maskLayerAnimation.fromValue = (__bridge id _Nullable)(circleMaskPathInitial.CGPath);
    maskLayerAnimation.toValue = (__bridge id _Nullable)(circleMaskPathFinal.CGPath);
    maskLayerAnimation.duration = [self transitionDuration:transitionContext];    
    maskLayerAnimation.delegate = self;
    [maskLayer addAnimation:maskLayerAnimation forKey:@"path"];
    
}

- (void)animationDidStop: (CAAnimation *)anim finished:(BOOL)flag
{
    [self.transitionContext completeTransition:![self.transitionContext transitionWasCancelled]];
    [self.transitionContext viewControllerForKey:UITransitionContextToViewControllerKey].view.layer.mask = nil;
}

@end
