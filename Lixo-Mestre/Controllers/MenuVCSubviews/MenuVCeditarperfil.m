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
    
    self.nome.enabled = FALSE;
    self.email.enabled = FALSE;
    self.senha.enabled = FALSE;
    
    self.editNome.selected = FALSE;
    self.editEmail.selected = FALSE;
    self.editSenha.selected = FALSE;
    
    self.nome.delegate = self;
    self.email.delegate = self;
    self.senha.delegate = self;
    
    self.botaoUnselected = [UIImage imageNamed:@"editar.png"];
    self.botaoSelected = [UIImage imageNamed:@"editar-perfil.png"];

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

- (IBAction)editarNome:(id)sender
{
    self.nome.enabled = !self.nome.enabled;
    //self.editNome.selected = !self.editNome.selected;
    if ( self.nome.enabled ) {
        [self.editNome setBackgroundImage: self.botaoSelected forState:UIControlStateNormal];
    }
    else{
        [self.editNome setBackgroundImage: self.botaoUnselected forState:UIControlStateNormal];

    }
}

- (IBAction)editarEmail:(id)sender
{
    self.email.enabled = !self.email.enabled;
    //self.editEmail.selected = !self.editEmail.selected;
    if ( self.email.enabled ) {
        [self.editEmail setBackgroundImage: self.botaoSelected forState:UIControlStateNormal];
    }
    else{
        [self.editEmail setBackgroundImage: self.botaoUnselected forState:UIControlStateNormal];
        
    }
}

- (IBAction)editarSenha:(id)sender
{
    self.senha.enabled = !self.senha.enabled;
    //self.editSenha.selected = !self.editSenha.selected;
    if ( self.senha.enabled ) {
        [self.editSenha setBackgroundImage: self.botaoSelected forState:UIControlStateNormal];
    }
    else{
        [self.editSenha setBackgroundImage: self.botaoUnselected forState:UIControlStateNormal];
        
    }
}

- (IBAction)confirmar:(id)sender {
//    [preferencias setObject: self.nome.text forKey:@""];
//    [preferencias setObject: self.email.text forKey:@""];
//    [ preferencias setObject: self.senha.text forKey:@""];
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES] ;

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing:YES];
    return NO;
}

@end
