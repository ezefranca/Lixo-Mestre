//
//  MinigamesVC.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 26/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface MinigamesVC : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *label;


@property (weak, nonatomic) IBOutlet UIButton *game1;
@property (weak, nonatomic) IBOutlet UIButton *game2;
@property (weak, nonatomic) IBOutlet UIButton *game3;
@property (weak, nonatomic) IBOutlet UIButton *game4;
@property (weak, nonatomic) IBOutlet UIButton *game5;
@property (weak, nonatomic) IBOutlet UIButton *game6;
@property (weak, nonatomic) IBOutlet UIButton *game7;
@property (weak, nonatomic) IBOutlet UIButton *game8;
@property (weak, nonatomic) IBOutlet UIButton *game9;


- (IBAction)botaoMenu:(id)sender;
- (IBAction)jogo1:(id)sender;
- (IBAction)bloqueado:(id)sender;


@end
