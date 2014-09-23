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

#import "UITextField+Shake.h"
#import "SVProgressHUD.h"
#import "TabGeralVC.h"
#import "CadastroVC.h"
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

@property __block UIImage *image;
@property FBLoginView *loginView;
@property FBProfilePictureView *profilePictureView;
@property NSString *facebookUserID;

@property UILabel *nameLabel;
@property UILabel *statusLabel;

@property (weak, nonatomic) IBOutlet UIButton *buttonLogar;
@property (weak, nonatomic) IBOutlet UIButton *buttonCadastro;
@property (weak, nonatomic) IBOutlet UIButton *buttonVoltar;

@property BOOL logado;

- (IBAction)salvaSenha:(id)sender;


- (IBAction)botaoLogin:(id)sender;
- (IBAction)botaoCadastro:(id)sender;
- (IBAction)botaoVoltar:(id)sender;




@end
