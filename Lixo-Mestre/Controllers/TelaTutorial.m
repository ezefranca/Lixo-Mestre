//
//  Tela.m
//  telas_3
//
//  Created by GABRIEL VIEIRA on 15/05/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "TelaTutorial.h"
#import "TelaTutorialFilha.h"
#import "AppDelegate.h"

#define rgb(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface TelaTutorial ()

@end

@implementation TelaTutorial

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    self.pageController.dataSource = self;
    [[self.pageController view] setFrame:[[self view] bounds]];
    
    TelaTutorialFilha *initialViewController = [self viewControllerAtIndex:0];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageController];
    [[self view] addSubview:[self.pageController view]];
    [self.pageController didMoveToParentViewController:self];
    
    //MUdar a cor das bolinhas
    for (UIView *subview in self.pageController.view.subviews) {
        if ([subview isKindOfClass:[UIPageControl class]]) {
            UIPageControl *pageControl = (UIPageControl *)subview;
            pageControl.pageIndicatorTintColor = rgb(236, 240, 241);
            
            pageControl.currentPageIndicatorTintColor = [UIColor blackColor];            pageControl.backgroundColor = rgb(41, 128, 185);
            
        }
    }
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (TelaTutorialFilha *)viewControllerAtIndex:(NSUInteger)index {
    
    TelaTutorialFilha *childViewController = [[TelaTutorialFilha alloc] initWithNibName:@"TelaTutorialFilha" bundle:nil];
    childViewController.index = index;
    
    return childViewController;
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TelaTutorialFilha *)viewController index];
    
    if (index == 0) {
        return nil;
    }
    
    // Decrease the index by 1 to return
    index--;
    
    return [self viewControllerAtIndex:index];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSUInteger index = [(TelaTutorialFilha *)viewController index];
    
    index++;
    
    if (index == 5) {
        return nil;
    }
    
    return [self viewControllerAtIndex:index];
    
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
    // The number of items reflected in the page indicator.
    return 5;
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
    // The selected item reflected in the page indicator.
    return 0;
}

@end
