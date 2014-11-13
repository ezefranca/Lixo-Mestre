//
//  MenuMG1.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 13/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface MenuMG1 : SKScene

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

@end
