//
//  CadastroVC.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 18/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "CadastroVC.h"
#import "webService.h"
#import "LoginVC.h"

@interface CadastroVC ()

@end

@implementation CadastroVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

+(BOOL)cadastraID:(NSString *)user password:(NSString *)pass nick:(NSString *)nickName image:(UIImage *)imagemDoPerfil{
    int x = [webService newUser:user :pass :nickName];
    if (x) {
        if (x != 2 ) {
            [webService uploadImage: imagemDoPerfil: user];
        }
        
        return YES;
    }
    return NO;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titulo.font = [UIFont fontWithName:@"Santor" size:20];
    
    self.labelNome.delegate = self;
    self.labelUser.delegate = self;
    self.labelPass.delegate = self;
    self.labelPass2.delegate = self;
    
    
    //Deixar imagem redonda
    CGRect x = self.profileImage.bounds;
    self.profileImage.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.profileImage.layer.borderWidth = 1.0f;
    self.profileImage.layer.borderColor = [UIColor clearColor].CGColor;
    self.profileImage.clipsToBounds = YES;
    self.profileImage.image = nil;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancelar:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)botaoCamera:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

- (IBAction)botaoAlbum:(UIButton *)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.profileImage.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)botaoCadastrar:(id)sender{
    if ([[self.labelPass text] isEqualToString: [self.labelPass2 text]]) {
        
        int x = [webService newUser:self.labelUser.text :self.labelPass.text :self.labelNome.text];
        //nao manda a foto agr
        //[webService uploadImage:self.profileImage.image:self.labelUser.text];
        if(x == 0){//erro
            NSLog(@"Algum erro");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"culpa do servidor do viera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            
        }
        if (x == 1) {//bls cadastrou
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Cadastro completo!" message:@"ainda eh por culpa do servidor do viera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            [self dismissViewControllerAnimated:YES completion:nil];
        }
        if(x == 2){//ja existe
            NSLog(@"Erro");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"culpa do servidor do viera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
        }
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"as senhas nao sao iguais" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
