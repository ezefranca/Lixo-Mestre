//
//  LoginVC.m
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import "LoginVC.h"
#define rgb(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface LoginVC ()

@end

@implementation LoginVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)viewWillAppear:(BOOL)animated{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    [SVProgressHUD setBackgroundColor:rgb(41, 128, 185)];
    [SVProgressHUD setForegroundColor:rgb(236, 240, 241)];
    [SVProgressHUD setRingThickness:6];
    
    M13Checkbox *tint = [[M13Checkbox alloc] initWithTitle:@"Custom Tint Color"];
    tint.tintColor = [UIColor colorWithRed: 0.608 green: 0.967 blue: 0.646 alpha: 1];
    tint.frame = CGRectMake(1, self.view.frame.origin.y + self.view.frame.size.height + 8, tint.frame.size.width, tint.frame.size.height);
    [self.view addSubview:tint];
    
    //Customizacao dos TextFields
    [@[_user, _pass] enumerateObjectsUsingBlock:^(UITextField* obj, NSUInteger idx, BOOL *stop) {
		[obj.layer setBorderWidth:2];
		[obj.layer setBorderColor:[UIColor colorWithRed:41.0/255.0 green:128.0/255.0 blue:185.0/255.0 alpha:1].CGColor];
		[obj setDelegate:self];
	}];
}

- (void)handleNotification:(NSNotification *)notif{
    //NSLog(@"Notification recieved: %@", notif.name);
    //NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}

- (void)viewDidLoad{
    [super viewDidLoad];
}

-(void)viewDidAppear:(BOOL)animated{
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senhaSalva"];
    // Verifiva se o opcao de senha salva esta habilitada no settings
    if(senhaSalva){
        // pegando usuario e senha salvo e preenchendo nos labels
        self.user.text = [preferencias stringForKey:@"userName"];
        self.pass.text = [preferencias stringForKey:@"password"];
        [self Login];
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Login

- (IBAction)checkSenha:(id)sender {
    if(senhaSalva){
        senhaSalva = 0;
    }
    else{
        senhaSalva = 1;
    }
    [preferencias setBool:senhaSalva forKey:@"senhaSalva"];
    [preferencias synchronize];
}


- (BOOL)Login{
    if([webService login:self.user.text :self.pass.text]){
        NSLog(@"%@", [webService rankingUser:@"load" : self.user.text]);
        if(senhaSalva){
            // salvando a senha se a opcao estiver habilitada
            [preferencias setObject:self.user.text forKey:@"userName"];
            [preferencias setObject:self.pass.text forKey:@"password"];
            [preferencias setBool:senhaSalva forKey:@"senhaSalva"];
            [preferencias synchronize];
        }
        //        int x = [webService login:self.user.text:self.pass.text];
        //
        //        if (x){
        //            if (x == 2){
        //                NSLog(@"usuario existe");
        //            }
        //            else{
        //                NSLog(@"cadastrado");
        //            }
        //        }
        //        else{
        //            NSLog(@"falha ao inseirr");
        //        }
        if ( ![webService carregarPontosUsuario: self.user.text] ) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sem internet" message:@"nao foi possivel sincronizar os dados com o servidor" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
        
        [self performSegueWithIdentifier:@"Login" sender:self];
        NSLog(@"Login");
        
    }
    else{
        [self shake];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nao foi possível efetuar o login." message:@"Verifique o usuário ou a senha." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        return FALSE;
    }
    return TRUE;
}

#pragma cadastro
- (IBAction)botaoCadastro:(id)sender {
//    CadastroVC *cad = CadastroVC.new;
  //  [self presentViewController:cad animated:YES completion:nil];
}
- (IBAction)botaoLogin:(id)sender {
    [self Login];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES]  ;
    [SVProgressHUD dismiss];
}

- (void)shake{
    [self.user shake:10 withDelta:10 andSpeed:0.05 shakeDirection:ShakeDirectionHorizontal];
}





@end
