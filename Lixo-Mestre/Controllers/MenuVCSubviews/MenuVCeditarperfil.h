//
//  MenuVCeditarperfil.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MenuVCeditarperfil : UIViewController<UITextFieldDelegate>{
    NSUserDefaults *preferencias;
}



@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIImageView *foto;


@property (weak, nonatomic) IBOutlet UITextField *nome;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UITextField *senha;

- (IBAction)voltar:(id)sender;





- (IBAction)confirmar:(id)sender;

@end
