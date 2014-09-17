//
//  LoginVC.h
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginVC.h"
#import "webService.h"
//#import "MenuVC.h"
//#import "GerenciadorVC.h"
//#import "JogoViewController.h"
//#import "TelaBluetooth.h"
#import "UITextField+Shake.h"
#import "SVProgressHUD.h"
//#import "CadastroVC.h"
#import "TinderVC.h"
#import "M13Checkbox.h"
#import <FacebookSDK/FacebookSDK.h>

@interface LoginVC : UIViewController<UITextFieldDelegate, FBLoginViewDelegate>{
    NSUserDefaults *preferencias;
    BOOL senhaSalva;
}

@property (weak, nonatomic) IBOutlet UITextField *user;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet M13Checkbox *checkSenha;

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (weak, nonatomic) IBOutlet FBProfilePictureView *profilePictureView;

@property NSString *facebookUserID;

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;

- (IBAction)salvaSenha:(id)sender;


- (IBAction)botaoLogin:(id)sender;
- (IBAction)botaoCadastro:(id)sender;

@end
