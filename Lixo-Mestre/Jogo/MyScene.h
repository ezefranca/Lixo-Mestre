//
//  MyScene.h
//  jogo-lixo
//

//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MascarasColisao.h"
#import "JogoViewController.h"

@interface MyScene : SKScene <SKPhysicsContactDelegate>

@property SKSpriteNode * bg;

@property SKSpriteNode *lixeiraMetal;
@property SKSpriteNode *lixeiraPapel;
@property SKSpriteNode *lixeiraVidro ;
@property SKSpriteNode *lixeiraPlastico;

@property NSMutableArray *lixos;
@property SKSpriteNode *lixoSelecionado;

@property SKLabelNode *labelPontuacao; //para exibir o valor da pontuacao
@property int valorPontuacao; //guarda o valor real da pontuacao

@property BOOL lixoSendoSegurado;

@property SKSpriteNode *botaoSair; //pseudo-botao para sair do jogo


@property int vidas;


@end
