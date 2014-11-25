//
//  MinigamesVC.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 26/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MinigamesVC.h"
#import "JogoViewController.h"
#import "webService.h"

@interface MinigamesVC ()

@end

@implementation MinigamesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.label.font = [UIFont fontWithName: @"Santor" size:17];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)botaoMenu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
}


- (IBAction)jogo1:(id)sender{
    JogoViewController *jogo = JogoViewController.new;
    [self navegacaoManeira:jogo];
}


- (IBAction)bloqueado:(id)sender{
    int num = (int)[sender tag];
    NSString *string;
    
    switch (num) {
        case 2:
            string = @"recicle 5 papeis para desbloquear!";
            break;
        case 3:
            string = @"recicle 5 metais para desbloquear!";
            break;
        case 4:
            string = @"recicle 5 vidros papeis para desbloquear!";
            break;
        case 5:
            string = @"recicle 5 plasticos para desbloquear!";
            break;
        case 6:
            string = @"conecte-se com 3 lixeiras diferentes para desbloquear!";
            break;
        case 7:
            string = @"avalie 20 fotos para desbloquear!";
            break;
        case 8:
            string = @"faca x para desbloquear!";
            break;
        case 9:
            string = @"faca x para desbloquear!";
            break;
        default:
            string = @"faca x para desbloquear!";
            break;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Jogo bloqueado!" message: string delegate:self cancelButtonTitle: @"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}

- (void)navegacaoManeira:(UIViewController*)tela{
    [tela setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController: tela animated: YES completion: nil];
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

-(BOOL)shouldAutorotate{
    return NO;
}

@end
