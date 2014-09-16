//
//  HomeViewController.m
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//


#import "BluetoothVC.h"
#import "AppDelegate.h"

@interface BluetoothVC ()

@end

@implementation BluetoothVC

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)botaoMenu:(id)sender {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
}
@end
