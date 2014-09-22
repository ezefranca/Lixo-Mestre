//
//  JogoViewController.h
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 16/06/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface JogoViewController : UIViewController{
    NSUserDefaults *preferencias;
}

@property  NSString *usuario;

@property UIButton *botaoDerp;
@property UIButton *botaoVoltar;

@property int qteMetal;
@property int qtePapel;
@property int qteVidro;
@property int qtePlastico;

@property int maiorPontuacao;

+(JogoViewController *)sharedJogoViewController;
-(void)jogoTerminou;
-(void)abreJoguinhoManeiro;
-(void)voltarMenu;

@end
