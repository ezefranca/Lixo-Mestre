//
//  MenuVCeditarperfil.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuVCeditarperfil.h"

@interface MenuVCeditarperfil ()

@end

@implementation MenuVCeditarperfil

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
    
//    self.nome.text = [preferencias objectForKey:@""];
//    self.email.text = [preferencias objectForKey:@""];
//    self.senha.text = [preferencias objectForKey:@""];
    
    self.titulo.font = [UIFont fontWithName:@"Santor" size:17];
    self.nome.font = [UIFont fontWithName:@"Santor" size:17];
    self.email.font = [UIFont fontWithName:@"Santor" size:17];
    self.senha.font = [UIFont fontWithName:@"Santor" size:17];
    
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



- (IBAction)confirmar:(id)sender {
//    [preferencias setObject: self.nome.text forKey:@""];
//    [preferencias setObject: self.email.text forKey:@""];
//    [ preferencias setObject: self.senha.text forKey:@""];
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return NO;
}

@end
