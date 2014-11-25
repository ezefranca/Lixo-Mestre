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
   
    self.logInfo.text = @"";
    self.pass.text = @"";
}

- (void)handleNotification:(NSNotification *)notif{
    //NSLog(@"Notification recieved: %@", notif.name);
    //NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}

- (void)viewDidLoad{
    [super viewDidLoad];
    [self.processando startAnimating];
    self.processando.hidden = YES;
    
    [LocalData deleteFacePicture];
    //Customizacao dos TextFields
    self.logInfo.font = [UIFont fontWithName: @"Santor" size:17];
    self.logInfo.delegate = self;
    
    self.pass.font = [UIFont fontWithName: @"Santor" size:17];
    self.pass.delegate = self;
    
    //login do facebook
    _loginView = [[FBLoginView alloc] initWithReadPermissions:
                  @[@"public_profile", @"email", @"user_friends"]];
    
    _loginView.frame = CGRectMake(20, 405, 280, 53);
    _loginView.delegate = self;
    [self.view addSubview:_loginView];
    
    _statusLabel = [[UILabel alloc] init];
    _statusLabel.frame = CGRectMake(30, 50, self.view.frame.size.width, 30);
    //[self.view addSubview: _statusLabel];
    
    _profilePictureView = [[FBProfilePictureView alloc] init];
    _profilePictureView.frame = CGRectMake(30, 80, 50, 50);
    //[self.view addSubview: _profilePictureView];
    
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.frame = CGRectMake(30, 140, self.view.frame.size.width, 30);
    //[self.view addSubview: _nameLabel];
}

-(void)viewDidAppear:(BOOL)animated{
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Login




#pragma cadastro
//- (IBAction)botaoCadastro:(id)sender {
//    UIStoryboard *Board = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];
//    CadastroVC* cad = [Board instantiateViewControllerWithIdentifier:@"Cadastro"];
//    [self presentViewController:cad animated:YES completion:nil];
//}
- (IBAction)botaoLogin:(id)sender {
    self.processando.hidden = NO;
    
    //VERIFICAR SE O USUARIO EXISTE NO BANCO
    if ([webService login:self.logInfo.text :self.pass.text]) {
        
        //SETAR PREFERENCIAS DO USUARIO LOGADO
        [preferencias setObject:self.logInfo.text forKey: @"LoginApp"];
        [preferencias setObject:self.pass.text forKey: @"password"];
        [preferencias setBool: YES forKey: @"Logado"];
        [preferencias synchronize];
        //PERFON SEGUE PARA TELA INICIAL
        [self performSegueWithIdentifier: @"coco" sender:nil];
    }
    else
    {
        //SE DER ERRADOI  TA UMA MEXIDINHA
        [self shake];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nao foi possível efetuar o login." message: @"Verifique o usuário ou a senha." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        self.processando.hidden = YES;
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES] ;
    [SVProgressHUD dismiss];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return NO;
}

- (void)shake{
    [self.logInfo shake:10 withDelta:10 andSpeed:0.05 shakeDirection:ShakeDirectionHorizontal];
}

-(void)logarDoFace
{
    self.processando.hidden = NO;
    //com delay pq se nao vai pegar a imagem errada
    [self performSelector :@selector(snipaFotoDoFace) withObject: nil afterDelay:1];
    
    //CADASTRA O CARA DO FACEBOOK
    int x = [CadastroVC cadastraID: self.nameLabel.text
                          password: self.facebookUserID
                             login: self.email
                             image: _image];
    
    //VER SE RETORNA VERDADEIRO
    
    
    
    switch (x) {
        case 1:{
            [preferencias setObject: self.nameLabel.text forKey: @"Nome"];
            [preferencias setObject: self.email forKey: @"LoginApp"];
            [preferencias setObject: self.facebookUserID forKey: @"password"];
            [preferencias setBool: YES forKey: @"Logado"];
            [preferencias synchronize];
            [self performSegueWithIdentifier: @"coco" sender:nil];
            break;
        }
            
        case 2:{
            [webService nameOfUserForEmail: self.email ];
            [preferencias setObject: self.email forKey: @"LoginApp"];
            [preferencias setObject: self.facebookUserID forKey: @"password"];
            [preferencias setBool: YES forKey: @"Logado"];
            [preferencias synchronize];
            [self performSegueWithIdentifier: @"coco" sender:nil];
            
            break;
        }
            
        default:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nao foi possível efetuar o login com facebook" message:@"" delegate:self cancelButtonTitle: @"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            
            break;
        }
    }
    self.processando.hidden = YES;
    
}

- (void)snipaFotoDoFace{
    _image = nil;
    //pega a imagem de perfil do face
    for (NSObject *obj in [self.profilePictureView subviews]) {
        if ([obj isMemberOfClass:[UIImageView class]]) {
            UIImageView *objImg = (UIImageView *)obj;
            _image = objImg.image;
            break;
        }
    }
    //teste pra ver se eh a imagem certa
    UIImageView *imgv = [[UIImageView alloc] initWithImage:_image];
    //    imgv.center = self.view.center;
    //    [self.view addSubview: imgv];
    
    //SALVA A IMAGEM DO PERFIL
    [LocalData saveFacePic: imgv.image];
    
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue{
    
}

-(void)loadImageforUser: (NSString *)email{
    NSString* path = [NSString stringWithFormat: @"http://172.246.16.27/lixoPapao/perfil/%@.png",email];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [LocalData saveFacePic:img];
}


#pragma  facebook methods
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
{
    self.processando.hidden = NO;
    preferencias = [NSUserDefaults standardUserDefaults];
    self.profilePictureView.profileID = [user objectID];
    self.nameLabel.text = user.name;
    [self setFacebookUserID: [user objectID]];
    self.email =  user[@"email"];
    
    [self performSelector:@selector(logarDoFace) withObject:nil afterDelay:1]; //com delay pq se nao vai pegar a imagem errada
    
}

// Logged-in from facebook user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"You're logged in as";
}

// Logged-out from facebook user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"You're not logged in!";
    
    self.logInfo.text = @"";
    self.pass.text = @"";
    [preferencias setBool: NO forKey: @"Logado"];
}

// Handle possible errors that can occur during facebook login
- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
    NSString *alertMessage, *alertTitle;
    
    // If the user should perform an action outside of you app to recover,
    // the SDK will provide a message for the user, you just need to surface it.
    // This conveniently handles cases like Facebook password change or unverified Facebook accounts.
    if ([FBErrorUtility shouldNotifyUserForError:error]) {
        alertTitle = @"Facebook error";
        alertMessage = [FBErrorUtility userMessageForError:error];
        
        // This code will handle session closures that happen outside of the app
        // You can take a look at our error handling guide to know more about it
        // https://developers.facebook.com/docs/ios/errors
    }else{
        if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
            alertTitle = @"Session Error";
            alertMessage = @"Your current session is no longer valid. Please log in again.";
            
            // If the user has cancelled a login, we will do nothing.
            // You can also choose to show the user a message if cancelling login will result in
            // the user not being able to complete a task they had initiated in your app
            // (like accessing FB-stored information or posting to Facebook)
        } else{
                if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                    NSLog(@"user cancelled login");
                    
                    // For simplicity, this sample handles other errors with a generic message
                    // You can checkout our error handling guide for more detailed information
                // https://developers.facebook.com/docs/ios/errors
                } else {
                    alertTitle  = @"Something went wrong";
                    alertMessage = @"Please try again later.";
                    NSLog(@"Unexpected error:%@", error);
                }
        }
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle: alertTitle
                                    message: alertMessage
                                   delegate: nil
                          cancelButtonTitle: @"OK"
                          otherButtonTitles: nil] show];
    }
}

-(BOOL)shouldAutorotate{
    return NO;
}

@end
