//
//  MenuVCeditarperfil.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "LocalData.h"
#import "webService.h"
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
    
    preferencias = [NSUserDefaults standardUserDefaults];
    
    self.foto.image = [LocalData loadFacePicture];
    //Deixar imagem redonda
    CGRect x = self.foto.bounds;
    self.foto.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.foto.layer.borderWidth = 1.0f;
    self.foto.layer.borderColor = [UIColor clearColor].CGColor;
    self.foto.clipsToBounds = YES;
    
    
    self.titulo.font = [UIFont fontWithName: @"Santor" size:17];
    self.nome.font = [UIFont fontWithName: @"Santor" size:17];
    self.email.font = [UIFont fontWithName: @"Santor" size:17];
    self.senha.font = [UIFont fontWithName: @"Santor" size:17];
    
    self.nome.enabled = FALSE;
    self.email.enabled = FALSE;
    self.senha.enabled = FALSE;
    
    self.editNome.selected = FALSE;
    self.editEmail.selected = FALSE;
    self.editSenha.selected = FALSE;
    
    self.nome.delegate = self;
    self.email.delegate = self;
    self.senha.delegate = self;
    
    self.botaoUnselected = [UIImage imageNamed: @"editar.png"];
    self.botaoSelected = [UIImage imageNamed: @"confirmar.png"];

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
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

- (IBAction)botaoAlbum:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController: picker animated: YES completion: NULL];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [LocalData deleteFacePicture];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.foto.image = chosenImage;

    [LocalData saveFacePic: chosenImage];
    
    [picker dismissViewControllerAnimated: YES completion: NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated: YES completion: NULL];
}


- (IBAction)editarNome:(id)sender
{
    self.nome.enabled = !self.nome.enabled;
    //self.editNome.selected = !self.editNome.selected;
    if ( self.nome.enabled ) {
        [self.editNome setBackgroundImage: self.botaoSelected forState:UIControlStateNormal];
    }
    else
    {
        [self.editNome setBackgroundImage: self.botaoUnselected forState:UIControlStateNormal];
        
        if ( [webService updateNomeUser:self.nome.text :self.senha.text : [preferencias objectForKey: @"LoginApp"] ] )
        {
            [preferencias setObject:self.nome.text forKey: @"Nome"];

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nome alterado com sucesso." message: @"" delegate:self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }

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
        
        if ( [webService updatePassUser: self.nome.text :self.senha.text : [preferencias objectForKey: @"LoginApp"] ] )
        {
            [preferencias setObject:self.nome.text forKey: @"password"];
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Senha alterada com sucesso." message: @"" delegate: self cancelButtonTitle: @"Ok" otherButtonTitles: nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
        
    }
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing: YES] ;
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.view endEditing: YES];
    return NO;
}

- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}


@end
