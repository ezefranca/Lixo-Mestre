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
#import "LocalData.h"

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

+(int)cadastraID:(NSString *)user password:(NSString *)pass login:(NSString *)email image:(UIImage *)imagemDoPerfil{
    int x = [webService newUser:user :pass :email];
    if (x) {
        if ( x != 2 ) {
            [webService uploadImage: [LocalData loadFacePicture] :email];
        }
    }
    return x;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titulo.font = [UIFont fontWithName:@"Santor" size:20];
    
    self.labelNome.delegate = self;
    self.labelEmail.delegate = self;
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
        if ( [self NSStringIsValidEmail: self.labelEmail.text]) {

            int x = [webService newUser:self.labelNome.text :self.labelPass.text :self.labelEmail.text];
            //nao manda a foto agr
            //[webService uploadImage:self.profileImage.image:self.labelUser.text];
            if(x == 0){//erro
                NSLog(@"Algum erro");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"culpa do servidor do viera" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
                
            }
            if (x == 1) {//bls cadastrou
                [self dismissViewControllerAnimated:YES completion:nil];
            }
            if(x == 2){//ja existe
                NSLog(@"Erro");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"o email ja esta sendo usado" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
                alert.alertViewStyle = UIAlertViewStyleDefault;
                [alert show];
            }
        }
        else{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"O cadastro falhou!" message:@"email invalido" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
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

-(BOOL) NSStringIsValidEmail:(NSString *)checkString{
    BOOL stricterFilter = NO; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [self.view endEditing:YES];
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

@end
