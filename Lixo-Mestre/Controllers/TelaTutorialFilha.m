//
//  TelaTutorialFilha.m
//  LixoPapao
//
//  Created by Ezequiel Franca dos Santos on 25/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "TelaTutorialFilha.h"
#import "LoginVC.h"
#import "CadastroVC.h"

@interface TelaTutorialFilha ()

@end

@implementation TelaTutorialFilha

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {
        // Custom initialization
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.botaoCadastro.hidden=TRUE;
    self.botaoLogin.hidden=TRUE;
    self.botaoLogin.enabled = FALSE;
    self.botaoCadastro.enabled = FALSE;
    self.logo.hidden = TRUE;
    
    if(self.index == 0){
        self.logo.hidden = FALSE;
    }
    
    // Do any additional setup after loading the view from its nib.
    
    if(self.index == 4){
        self.botaoLogin.enabled = TRUE;
        self.botaoCadastro.enabled = TRUE;
        self.botaoCadastro.hidden=FALSE;
        self.botaoLogin.hidden=FALSE;
        self.logo.hidden = FALSE;
    }
    
    self.screenNumber.text = [NSString stringWithFormat:@"Tela #%ld", (long)self.index];
    
    if(self.index > 4)
    self.index = 4;
    if(self.index < 0)
    self.index = 0;
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
}

- (IBAction)BotaoLogin:(id)sender {
    LoginVC *l = LoginVC.new;
    self.view.window.rootViewController = l;
    self.view.window.backgroundColor = [UIColor whiteColor];
    [self.view.window makeKeyAndVisible];
}

#pragma cadastro
- (IBAction)BotaoCadastro:(id)sender {
    
    CadastroVC *cad = CadastroVC.new;
    self.view.window.rootViewController = cad;
    self.view.window.backgroundColor = [UIColor whiteColor];
    [self.view.window makeKeyAndVisible];
    
}

@end
