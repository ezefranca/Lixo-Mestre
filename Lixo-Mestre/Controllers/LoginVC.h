//
//  LoginVC.h
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UITextField+Shake.h"
#import "SVProgressHUD.h"
//#import "MainContainerViewController.h"
#import "CadastroVC.h"
#import "webService.h"
#import "M13Checkbox.h"
#import <FacebookSDK/FacebookSDK.h>
#import "LocalData.h"


@interface LoginVC : UIViewController <UITextFieldDelegate, FBLoginViewDelegate>{
    NSUserDefaults *preferencias;
    //BOOL senhaSalva;
}

@property (weak, nonatomic) IBOutlet UITextField *logInfo;
@property (weak, nonatomic) IBOutlet UITextField *pass;
@property (weak, nonatomic) IBOutlet M13Checkbox *checkSenha;
@property (weak, nonatomic) IBOutlet UIButton *buttomLogar;

@property FBLoginView *loginView;
@property FBProfilePictureView *profilePictureView;
@property __block UIImage *image;

@property NSString *facebookUserID;

@property UILabel *nameLabel;
@property UILabel *statusLabel;
@property NSString *email;



- (IBAction)botaoLogin:(id)sender;


@end
