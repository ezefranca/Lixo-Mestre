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

//coisas do menu
@property UIImageView *imgView;
@property UIButton *voltar;

@property UILabel *titulo;
@property UILabel *instrucao1;
@property UILabel *instrucao2;
@property UILabel *instrucao3;
@property UILabel *lembrar;

@property UIButton *hintVidro;
@property UIButton *hintPapel;
@property UIButton *hintPlastico;
@property UIButton *hintMetal;

@property UIButton *play;

@property UILabel *record;
@property int valorPontuacao; //guarda o valor real da pontuacao
//------



//coisas usadas no jogo em si
@property  NSString *usuario;

@property UIButton *botaoVoltar;

@property int qteMetal;
@property int qtePapel;
@property int qteVidro;
@property int qtePlastico;

@property int maiorPontuacao;
//------


+(JogoViewController *)sharedJogoViewController;
-(void)jogoTerminou;
-(void)abreJoguinhoManeiro;
-(void)voltarMenu;

@end
