//
//  MainContainerViewController.m
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>   // for the drop shadow

#import "MainContainerViewController.h"
#import "MenuViewController.h"
#import "BluetoothVC.h"
#import "TabGeralVC.h"
#import "LoginVC.h"
#import "AppDelegate.h"

// how far to slide right to show the menu
#define kSlideRightPoints 250.0

@interface MainContainerViewController (){
    NSUserDefaults *preferencias;
    MenuViewController *_menuViewController;
    TabGeralVC *_tabGeralViewController;
    LoginVC *_loginViewController;
    UIPanGestureRecognizer *_panGestureRecognizer;  // for pulling the menu open or closed
    BOOL _menuShowing;
    CGRect _frontViewClosedFrame;   // used for sliding it
}
@end

@implementation MainContainerViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    _menuShowing = NO;
    
    // Add our sub view controllers
    UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];
    _menuViewController = [storyBoard instantiateViewControllerWithIdentifier:@"Menu"];
    
    [self addChildViewController:_menuViewController];
    [_menuViewController didMoveToParentViewController:self];
    //_menuViewController.view.frame = self.view.bounds;
    [self.view addSubview:_menuViewController.view];

    _tabGeralViewController = [storyBoard instantiateViewControllerWithIdentifier:@"TabGeral"];
    _tabGeralViewController.view.frame = self.view.bounds;
    _frontViewClosedFrame = _tabGeralViewController.view.frame;
    [self addChildViewController:_tabGeralViewController];
    [self.view addSubview:_tabGeralViewController.view];
    [_tabGeralViewController didMoveToParentViewController:self];
    
//    _loginViewController = [storyBoard instantiateViewControllerWithIdentifier:@"Login"];
//    _loginViewController.view.frame = self.view.bounds;
//    _frontViewClosedFrame = _loginViewController.view.frame;
//    [self addChildViewController:_loginViewController];
//    [self.view addSubview:_loginViewController.view];
//    [_loginViewController didMoveToParentViewController:self];
    
    _panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handlePanGestures:)];
    _panGestureRecognizer.minimumNumberOfTouches = 1;   // one finger only
    _panGestureRecognizer.maximumNumberOfTouches = 1;
    [_tabGeralViewController.view addGestureRecognizer:_panGestureRecognizer];
    
    // add a drop shadow on the left of the home view
    _tabGeralViewController.view.layer.masksToBounds = NO;
    _tabGeralViewController.view.layer.shadowOffset = CGSizeMake(-2, 0);
    _tabGeralViewController.view.layer.shadowRadius = 2;
    _tabGeralViewController.view.layer.shadowOpacity = 0.5;

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showMenuView:) name:kShowMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(hideMenuView:) name:kHideMenuNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHideMenuView:) name:kShowHideMenuNotification object:nil];
}

- (void)viewDidUnload{
    [super viewDidUnload];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
// slide the front view to the side so the menu view is visible
- (void)showMenuView:(NSNotification *)notification{
    CGRect destination = _frontViewClosedFrame;
    
    CGRect frame = self.view.bounds;
    frame.origin.y += 44;// space for the menu button

    _menuShowing = YES;
    destination.origin.x += kSlideRightPoints;
    
    [UIView animateWithDuration:0.30 animations:^{
        _tabGeralViewController.view.frame = destination;
    } completion:nil];
}

- (void)hideMenuView:(NSNotification *)notification{
    CGRect destination = _frontViewClosedFrame;
    
    _menuShowing = NO;
    destination.origin.x = 0;
    
    [UIView animateWithDuration:0.30 animations:^{
        _tabGeralViewController.view.frame = destination;
        
    } completion:nil];
}

- (void)showHideMenuView:(NSNotification *)notification{
    if(!_menuShowing)
        [self showMenuView:nil];
    else
        [self hideMenuView:nil];
}

- (void) handlePanGestures:(UIPanGestureRecognizer*)paramSender{
    static float initialXOffset = 0;
    if(paramSender.state == UIGestureRecognizerStateBegan)
        initialXOffset = [paramSender locationInView:paramSender.view].x;
    
    if (paramSender.state != UIGestureRecognizerStateEnded && paramSender.state != UIGestureRecognizerStateFailed)
    {
        CGPoint location = [paramSender locationInView:paramSender.view.superview];
        CGRect newFrame = _frontViewClosedFrame;
        newFrame.origin.x = location.x - initialXOffset;
        if(newFrame.origin.x < 0)
            newFrame.origin.x = 0;
        _tabGeralViewController.view.frame = newFrame;
    }
    
    if(paramSender.state == UIGestureRecognizerStateEnded)
    {
        if(_tabGeralViewController.view.frame.origin.x > 160)
        {
            [self showMenuView:nil];
        }
        else
        {
            [self hideMenuView:nil];
        }
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
