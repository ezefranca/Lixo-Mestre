//
//  RankingVC2.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 26/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "RankingVC2.h"
#import "JogoViewController.h"
#import "webService.h"

@interface RankingVC2 ()

@end

@implementation RankingVC2

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
    
    //NSString *nomeAmigo = [[NSString alloc]init];
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
//    if (!FBSession.activeSession.isOpen) {
//        // if the session is closed, then we open it here, and establish a handler for state changes
//        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Nao há Ranking disponivel."
//                                                            message:@"Só é possivel ver o Ranking Logado com o Facebook"
//                                                           delegate:nil
//                                                  cancelButtonTitle:@"OK"
//                                                  otherButtonTitles:nil];
//        [alertView show];
//    }
//    
//    if (self.friendPickerController == nil) {
//        // Create friend picker, and get data loaded into it.
//        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
//        self.friendPickerController.title = @"Ranking";
//        self.friendPickerController.delegate = self;
//    }
//    
//    [self.friendPickerController loadData];
//    [self.friendPickerController clearSelection];
//    
//    self.friendPickerController.view.frame = CGRectMake(0, 68, 320, 450);
//    
//    [self.view addSubview: self.friendPickerController.view];
    
    [self performSelector:@selector(testes:) withObject:nil];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)testes:(id)sender {
    
    //NSString *nomeAmigo = [[NSString alloc]init];
    
    // FBSample logic
    // if the session is open, then load the data for our view controller
    if (!FBSession.activeSession.isOpen) {
        // if the session is closed, then we open it here, and establish a handler for state changes
        [FBSession openActiveSessionWithReadPermissions: @[@"public_profile", @"email", @"user_friends"]
                                           allowLoginUI: YES
                                      completionHandler: ^(FBSession *session,
                                                           FBSessionState state,
                                                           NSError *error) {
                                          if (error) {
                                              UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                                                                  message:error.localizedDescription
                                                                                                 delegate:nil
                                                                                        cancelButtonTitle:@"OK"
                                                                                        otherButtonTitles:nil];
                                              [alertView show];
                                          } else if (session.isOpen) {
                                              [self testes:sender];
                                          }
                                      }];
        return;
    }
    
    if (self.friendPickerController == nil) {
        // Create friend picker, and get data loaded into it.
        self.friendPickerController = [[FBFriendPickerViewController alloc] init];
        self.friendPickerController.title = @"Selecionar Amigo";
        self.friendPickerController.delegate = self;
    }
    
    [self.friendPickerController loadData];
    [self.friendPickerController clearSelection];
    
    self.friendPickerController.view.frame = CGRectMake(0, 68, 320, 450);
    
    [self.view addSubview: self.friendPickerController.view];
    
    //[self presentViewController:self.friendPickerController animated:YES completion:nil];
}

- (void)facebookViewControllerDoneWasPressed:(id)sender {
    NSMutableString *text = [[NSMutableString alloc] init];
    
    // we pick up the users from the selection, and create a string that we use to update the text view
    // at the bottom of the display; note that self.selection is a property inherited from our base class
    for (id<FBGraphUser> user in self.friendPickerController.selection) {
        if ([text length]) {
            [text appendString:@", "];
        }
        [text appendString:user.name];
    }
    
    [self fillTextBoxAndDismiss:text.length > 0 ? text : @"<None>"];
}

- (void)facebookViewControllerCancelWasPressed:(id)sender {
    [self fillTextBoxAndDismiss:@"<Cancelled>"];
}

- (void)fillTextBoxAndDismiss:(NSString *)text {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

-(void)friendPickerViewControllerSelectionDidChange:(FBFriendPickerViewController *)friendPicker{
    NSArray *friends = friendPicker.selection;
    NSLog(@"%@", friends);
    
}


- (IBAction)botaoMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
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

- (void)navegacaoManeira:(UIViewController*)tela{
    [tela setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:tela animated:YES completion:nil];
}

#pragma table view methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"Clicou em %ld", (long)indexPath.row);
    
    switch (indexPath.row) {
        case 0:{
            
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        default:{
            break;
        }
    }
    
    
}

@end
