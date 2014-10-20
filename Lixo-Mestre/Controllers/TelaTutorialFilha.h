//
//  TelaTutorialFilha.h
//  LixoPapao
//
//  Created by Ezequiel Franca dos Santos on 25/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TelaTutorialFilha : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *botaoLogin;
@property (weak, nonatomic) IBOutlet UIButton *botaoCadastro;
@property (weak, nonatomic) IBOutlet UIImageView *logo;

- (IBAction)BotaoLogin:(id)sender;
- (IBAction)BotaoCadastro:(id)sender;

@property (assign, nonatomic) NSInteger index;
@property (strong, nonatomic) IBOutlet UILabel *screenNumber;

@end
