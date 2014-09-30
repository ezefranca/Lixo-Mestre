//
//  RankingVC2.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 26/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "AppDelegate.h"

@interface RankingVC2 : UIViewController <UITableViewDelegate, UITableViewDataSource, FBLoginViewDelegate, FBViewControllerDelegate>



@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)testes:(id)sender;

- (IBAction)botaoMenu:(id)sender;


@property (retain, nonatomic) FBFriendPickerViewController *friendPickerController;
@end
