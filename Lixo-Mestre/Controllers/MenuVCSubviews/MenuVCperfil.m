//
//  MenuVCperfil.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuVCperfil.h"

@interface MenuVCperfil ()

@end

@implementation MenuVCperfil

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
    preferencias = [NSUserDefaults standardUserDefaults];

    //Deixar imagem redonda
    CGRect x = self.foto.bounds;
    self.foto.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.foto.layer.borderWidth = 1.0f;
    self.foto.layer.borderColor = [UIColor clearColor].CGColor;
    self.foto.clipsToBounds = YES;
    
    self.titulo.font = [UIFont fontWithName: @"Santor" size:20];
    self.nome.font = [UIFont fontWithName: @"Santor" size:20];

    self.labelPapel.font = [UIFont fontWithName: @"Santor" size:17];
    self.labelVidro.font = [UIFont fontWithName: @"Santor" size:17];
    self.labelPlastico.font = [UIFont fontWithName: @"Santor" size:17];
    self.labelMetal.font = [UIFont fontWithName: @"Santor" size:17];
    
    self.progressTitulo.font = [UIFont fontWithName: @"Santor" size:30];
    
    int total = [preferencias integerForKey: @"qteMetal"]+
    [preferencias integerForKey: @"qtePapel"]+
    [preferencias integerForKey: @"qteVidro"]+
    [preferencias integerForKey: @"qtePlastico"];
    self.viewDesenho.totalLixos = total;
    self.progresso.text = [NSString stringWithFormat: @"%d Lixos reciclados",total];
    self.progresso.font = [UIFont fontWithName: @"Santor" size:17];
    

}

-(void)viewWillAppear:(BOOL)animated{
    self.foto.image = [LocalData loadFacePicture];
    self.nome.text = [preferencias objectForKey: @"Nome"];
    
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

- (IBAction)voltar:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}


//editar os com os texticulos da polyanna
- (IBAction)convidar:(id)sender{
    
    // Check if the Facebook app is installed and we can present the share dialog
    FBLinkShareParams *params = [[FBLinkShareParams alloc] init];
    params.link = [NSURL URLWithString:@"https://developers.facebook.com/docs/ios/share/"];
    
    // If the Facebook app is installed and we can present the share dialog
    if ([FBDialogs canPresentShareDialogWithParams:params]) {
        
        // Present share dialog
        [FBDialogs presentShareDialogWithLink:params.link
                                      handler:^(FBAppCall *call, NSDictionary *results, NSError *error) {
                                          if(error) {
                                              // An error occurred, we need to handle the error
                                              // See: https://developers.facebook.com/docs/ios/errors
                                              NSLog(@"Error publishing story: %@", error.description);
                                          } else {
                                              // Success
                                              NSLog(@"result %@", results);
                                          }
                                      }];
        
        // If the Facebook app is NOT installed and we can't present the share dialog
    } else {
        // FALLBACK: publish just a link using the Feed dialog
        
        // Put together the dialog parameters
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                       @"Lixo Papão", @"name",
                                       @"Build great social apps and get more installs.", @"caption",
                                       @"Allow your users to share stories on Facebook from your app using the iOS SDK.", @"description",
                                       @"https://developers.facebook.com/docs/ios/share/", @"link",
                                       @"http://puu.sh/degUe.png", @"picture",
                                       nil];
        
        // Show the feed dialog
        [FBWebDialogs presentFeedDialogModallyWithSession:nil
                                               parameters:params
                                                  handler:^(FBWebDialogResult result, NSURL *resultURL, NSError *error) {
                                                      if (error) {
                                                          // An error occurred, we need to handle the error
                                                          // See: https://developers.facebook.com/docs/ios/errors
                                                          NSLog(@"Error publishing story: %@", error.description);
                                                      } else {
                                                          if (result == FBWebDialogResultDialogNotCompleted) {
                                                              // User canceled.
                                                              NSLog(@"User cancelled.");
                                                          } else {
                                                              // Handle the publish feed callback
                                                              NSDictionary *urlParams = [self parseURLParams:[resultURL query]];
                                                              
                                                              if (![urlParams valueForKey:@"post_id"]) {
                                                                  // User canceled.
                                                                  NSLog(@"User cancelled.");
                                                                  
                                                              } else {
                                                                  // User clicked the Share button
                                                                  NSString *result = [NSString stringWithFormat: @"Posted story, id: %@", [urlParams valueForKey:@"post_id"]];
                                                                  NSLog(@"result %@", result);
                                                              }
                                                          }
                                                      }
                                                  }];
    }
}

- (NSDictionary*)parseURLParams:(NSString *)query {
    NSArray *pairs = [query componentsSeparatedByString:@"&"];
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *pair in pairs) {
        NSArray *kv = [pair componentsSeparatedByString:@"="];
        NSString *val =
        [kv[1] stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
        params[kv[0]] = val;
    }
    return params;
}

- (IBAction)unwindToPerfil:(UIStoryboardSegue *)unwindSegue{
    
}

//isso eh um metodo de view, nao de viewcontroller >.<
//so criando uma uiview custom (ViewProgresso)
//-(void)drawRect:(CGRect)rect{
//}

- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
