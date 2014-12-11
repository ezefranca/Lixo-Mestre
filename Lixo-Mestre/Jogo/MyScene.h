//
//  MyScene.h
//  jogo-lixo
//

//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "MascarasColisao.h"
#import "JogoViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface MyScene : SKScene <SKPhysicsContactDelegate>{
    NSUserDefaults *preferencias;
}


@property SKSpriteNode * bg;

@property NSMutableArray *coracoes;
@property SKSpriteNode *lixeiraMetal;
@property SKSpriteNode *lixeiraPapel;
@property SKSpriteNode *lixeiraVidro ;
@property SKSpriteNode *lixeiraPlastico;

@property SKSpriteNode *botaoSair; //pseudo-botao para sair do jogo

@property NSMutableArray *lixos;
@property SKSpriteNode *lixoSelecionado;

@property SKLabelNode *labelPontuacao; //para exibir o valor da pontuacao
@property int valorPontuacao; //guarda o valor real da pontuacao

@property BOOL lixoSendoSegurado;
@property int vidas;

@property AVAudioPlayer *buzzerWrong;
@property AVAudioPlayer *buzzerCorrect;

@end
