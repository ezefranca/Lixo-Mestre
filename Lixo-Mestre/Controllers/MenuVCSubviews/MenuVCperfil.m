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

    //self.foto.image = [preferencias objectForKey:@""];
    //self.nome.text = [preferencias objectForKey:@""];
    //self.progresso.text = [preferencias objectForKey:@""];
    
    self.titulo.font = [UIFont fontWithName:@"Santor" size:20];
    self.nome.font = [UIFont fontWithName:@"Santor" size:17];

    self.progressTitulo.font = [UIFont fontWithName:@"Santor" size:20];
    self.progresso.font = [UIFont fontWithName:@"Santor" size:17];
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

- (IBAction)editar:(id)sender {
    UIStoryboard *Board = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];
    MenuVCeditarperfil * perfil = [Board instantiateViewControllerWithIdentifier:@"MenuEditar"];
    [self presentViewController:perfil animated:YES completion:nil];}

- (IBAction)amigos:(id)sender {
}

- (IBAction)convidar:(id)sender {
}
@end
