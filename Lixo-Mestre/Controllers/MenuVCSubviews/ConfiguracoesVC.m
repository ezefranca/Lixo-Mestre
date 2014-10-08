//
//  ConfiguracoesVC.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 30/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "ConfiguracoesVC.h"

@interface ConfiguracoesVC ()

@end

@implementation ConfiguracoesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    if ( [preferencias boolForKey:@"FaceLogin"] ) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.frame = CGRectMake(20, 78, self.view.frame.size.width, 30);
        [self.view addSubview: _statusLabel];
        
        _profilePictureView = [[FBProfilePictureView alloc] init];
        _profilePictureView.frame = CGRectMake(20, 116, 50, 50);
        [self.view addSubview: _profilePictureView];
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.frame = CGRectMake(20, 174, self.view.frame.size.width, 30);
        [self.view addSubview: _nameLabel];
        
        _loginView = [[FBLoginView alloc] init];
        _loginView.frame = CGRectMake(20, 495, 280, 53);
        _loginView.delegate = self;
        [self.view addSubview:_loginView];
    }
    else{
        
        
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/



- (IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
    self.profilePictureView.profileID = [user objectID];
    self.nameLabel.text = user.name;
    [self setFacebookUserID: [user objectID]];
    
}

#pragma facebook methods

// Logged-in from facebook user experience
- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
    self.statusLabel.text = @"Você está logado como ";
    [preferencias setBool: TRUE forKey: @"FaceLogin"];
}

// Logged-out from facebook user experience
- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
    self.profilePictureView.profileID = nil;
    self.nameLabel.text = @"";
    self.statusLabel.text= @"";
    if ([preferencias boolForKey:@"FaceLogin"]) {
            [self performSegueWithIdentifier:@"unwindProLogin" sender:self];
    }
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
