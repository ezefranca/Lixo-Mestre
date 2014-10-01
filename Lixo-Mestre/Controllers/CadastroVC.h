//
//  CadastroVC.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 18/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface CadastroVC : UIViewController <UITextFieldDelegate,UIImagePickerControllerDelegate, UINavigationControllerDelegate>{
    
}
@property (weak, nonatomic) IBOutlet UILabel *titulo;


@property (weak, nonatomic) IBOutlet UITextField *labelNome;
@property (weak, nonatomic) IBOutlet UITextField *labelUser;
@property (weak, nonatomic) IBOutlet UITextField *labelPass;
@property (weak, nonatomic) IBOutlet UITextField *labelPass2;


@property (weak, nonatomic) IBOutlet UIImageView *profileImage;

@property (weak, nonatomic) IBOutlet UIButton *cancelar;
+(BOOL)cadastraID:(NSString *)user password:(NSString *)pass nick:(NSString *)nickName image:(UIImage *)imagemDoPerfil;


- (IBAction)botaoCamera:(id)sender;
- (IBAction)botaoAlbum:(id)sender;
- (IBAction)botaoCadastrar:(id)sender;


@end
