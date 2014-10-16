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
    self.logouPeloFace = false;
    [LocalData deleteFacePicture];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDWillAppearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDDidAppearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDWillDisappearNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleNotification:) name:SVProgressHUDDidDisappearNotification object:nil];
    
    [SVProgressHUD setBackgroundColor:rgb(41, 128, 185)];
    [SVProgressHUD setForegroundColor:rgb(236, 240, 241)];
    [SVProgressHUD setRingThickness:6];
    
    M13Checkbox *tint = [[M13Checkbox alloc] initWithTitle:@"Custom Tint Color"];
    tint.tintColor = [UIColor colorWithRed: 0.608 green: 0.967 blue: 0.646 alpha: 1];
    tint.frame = CGRectMake(1, self.view.frame.origin.y + self.view.frame.size.height + 8, tint.frame.size.width, tint.frame.size.height);
    [self.view addSubview:tint];
    
    //Customizacao dos TextFields
    self.logInfo.font = [UIFont fontWithName:@"Santor" size:17];
    self.logInfo.delegate = self;
    
    self.pass.font = [UIFont fontWithName:@"Santor" size:17];
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
        self.logInfo.text = [preferencias stringForKey:@"LoginApp"];
        self.pass.text = [preferencias stringForKey:@"password"];
        [self Login];
    }
    else{
        self.logInfo.text = @"";
        self.pass.text = @"";
    }
}


- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Login
- (IBAction)salvaSenha:(id)sender
{
    if(senhaSalva){
        senhaSalva = 0;
    }
    else
    {
        senhaSalva = 1;
    }
    
    [preferencias setBool:senhaSalva forKey:@"senhaSalva"];
    [preferencias synchronize];
}

- (BOOL)Login{
    
    if([webService login:self.logInfo.text :self.pass.text])
    {
        NSLog(@"%@", [webService rankingUser:@"load" : self.logInfo.text]);
        
        if(senhaSalva)
        {
            // salvando a senha se a opcao estiver habilitada
            [preferencias setObject:self.logInfo.text forKey:@"LoginApp"];
            [preferencias setObject:self.pass.text forKey:@"password"];
            [preferencias setBool:senhaSalva forKey:@"senhaSalva"];
            [preferencias synchronize];
        }

        if (![webService carregarPontosUsuario: self.logInfo.text])
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Sem internet" message:@"nao foi possivel sincronizar os dados com o servidor" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
        
        [preferencias setBool: self.logouPeloFace forKey:@"FaceLogin"];
        [preferencias synchronize];
        
        [self loadImageforUser: self.email];
        //tudo certo, vai pro resto do app
        [self performSegueWithIdentifier:@"coco" sender:nil];
        
    }
    else
    {
        [self shake];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nao foi possível efetuar o login." message:@"Verifique o usuário ou a senha." delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        return FALSE;
    }
    
    return TRUE;
}


#pragma cadastro
//- (IBAction)botaoCadastro:(id)sender {
//    UIStoryboard *Board = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];
//    CadastroVC* cad = [Board instantiateViewControllerWithIdentifier:@"Cadastro"];
//    [self presentViewController:cad animated:YES completion:nil];
//}
- (IBAction)botaoLogin:(id)sender {
    [self Login];
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

-(void)logarDoFace{
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

    [LocalData saveFacePic: imgv.image];
    
    int x = [CadastroVC cadastraID: self.nameLabel.text
                          password: self.facebookUserID
                             login: self.email
                             image: _image];

    if ( x == 2  || x == 1) {
        self.logInfo.text = self.email;
        self.pass.text = self.facebookUserID;
        [preferencias setObject: self.nameLabel.text forKey:@"Nome"];
        self.logouPeloFace = TRUE;
        [self Login];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nao foi possível efetuar o login com facebook" message:@"" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
        
    }
}

- (IBAction)unwindToLogin:(UIStoryboardSegue *)unwindSegue{
    
}

-(void)loadImageforUser: (NSString *)email{
    NSString* path = [NSString stringWithFormat:@"http://172.246.16.27/lixoPapao/perfil/%@.png",email];
    NSURL *url = [NSURL URLWithString:path];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    [LocalData saveFacePic:img];
}


#pragma  facebook methods
- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = [user objectID];
    self.nameLabel.text = user.name;
    [self setFacebookUserID: [user objectID]];
    self.email =  user[@"email"];
    
    [preferencias setObject: self.facebookUserID forKey:@"idfb"];
    
    [self performSelector:@selector(logarDoFace) withObject:nil afterDelay:0.3]; //com delay pq se nao vai pegar a imagem errada
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
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
        alertTitle = @"Session Error";
        alertMessage = @"Your current session is no longer valid. Please log in again.";
        
        // If the user has cancelled a login, we will do nothing.
        // You can also choose to show the user a message if cancelling login will result in
        // the user not being able to complete a task they had initiated in your app
        // (like accessing FB-stored information or posting to Facebook)
    } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
        NSLog(@"user cancelled login");
        
        // For simplicity, this sample handles other errors with a generic message
        // You can checkout our error handling guide for more detailed information
        // https://developers.facebook.com/docs/ios/errors
    } else {
        alertTitle  = @"Something went wrong";
        alertMessage = @"Please try again later.";
        NSLog(@"Unexpected error:%@", error);
    }
    
    if (alertMessage) {
        [[[UIAlertView alloc] initWithTitle:alertTitle
                                    message:alertMessage
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}


@end
