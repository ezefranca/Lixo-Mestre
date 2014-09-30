//
//  MenuVCamigos.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuVCamigos.h"

@interface MenuVCamigos ()

@end

@implementation MenuVCamigos

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
    self.titulo.font = [UIFont fontWithName:@"Santor" size:20];
    
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
    NSLog(@"Clicou em %ld", (long)indexPath.row);
    
    UIStoryboard *Board = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];
    MenuVCperfilAmigo * perfil = [Board instantiateViewControllerWithIdentifier:@"PerfilAmigo"];

    
    [self presentViewController:perfil animated:YES completion:nil];
    
}


@end
