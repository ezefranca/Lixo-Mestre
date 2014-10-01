//
//  MenuVCperfil.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVCeditarperfil.h"
#import "MenuVCamigos.h"
#import "ViewProgresso.h"
@interface MenuVCperfil : UIViewController{
    NSUserDefaults *preferencias;
}


@property (weak, nonatomic) IBOutlet UILabel *titulo;
@property (weak, nonatomic) IBOutlet UIImageView *foto;
@property (weak, nonatomic) IBOutlet UILabel *nome;

@property (weak, nonatomic) IBOutlet UILabel *progressTitulo;

@property (weak, nonatomic) IBOutlet ViewProgresso *viewDesenho;
@property (weak, nonatomic) IBOutlet UIImageView *papel;
@property (weak, nonatomic) IBOutlet UIImageView *vidro;
@property (weak, nonatomic) IBOutlet UIImageView *plastico;
@property (weak, nonatomic) IBOutlet UIImageView *metal;

@property (weak, nonatomic) IBOutlet UILabel *labelPapel;
@property (weak, nonatomic) IBOutlet UILabel *labelVidro;
@property (weak, nonatomic) IBOutlet UILabel *labelPlastico;
@property (weak, nonatomic) IBOutlet UILabel *labelMetal;




@property (weak, nonatomic) IBOutlet UILabel *progresso;

- (IBAction)voltar:(id)sender;

- (IBAction)editar:(id)sender;
- (IBAction)amigos:(id)sender;
- (IBAction)convidar:(id)sender;


@end
