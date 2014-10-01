//
//  CriaNodes.m
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 16/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "CriaNodes.h"


@implementation CriaNodes

+(SKSpriteNode *)lixeiraTipo: (NSString *)material forFrame: (CGRect)frame {
    SKSpriteNode *nodeLixeira;
    CGFloat comprimentoLixeira = 75;
    CGFloat alturaLixeira = 100;
    CGFloat posX = 60;
    
    
    if ([material isEqualToString:@"Metal"]) {
        nodeLixeira = [SKSpriteNode spriteNodeWithImageNamed:@"lixeira metal.png"];
        
        [nodeLixeira setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(comprimentoLixeira, alturaLixeira)]];
        nodeLixeira.physicsBody.categoryBitMask = lixeiraMetal;
        nodeLixeira.position = CGPointMake(posX, frame.size.height*(4/5.0) );
    }
    if ([material isEqualToString:@"Papel"]) {
        nodeLixeira = [SKSpriteNode spriteNodeWithImageNamed:@"lixeira papel.png"];
        [nodeLixeira setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(comprimentoLixeira, alturaLixeira)]];
        nodeLixeira.physicsBody.categoryBitMask = lixeiraPapel;
        nodeLixeira.position = CGPointMake(posX, frame.size.height*(3/5.0) );
    }
    if ([material isEqualToString:@"Vidro"]) {
        nodeLixeira = [SKSpriteNode spriteNodeWithImageNamed:@"lixeira vidro.png"];
        [nodeLixeira setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(comprimentoLixeira, alturaLixeira)]];
        nodeLixeira.physicsBody.categoryBitMask = lixeiraVidro;
        nodeLixeira.position = CGPointMake(posX, frame.size.height*(2/5.0) );
    }
    if ([material isEqualToString:@"Plastico"]) {
        nodeLixeira = [SKSpriteNode spriteNodeWithImageNamed:@"lixeira plastico.png"];
        [nodeLixeira setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(comprimentoLixeira, alturaLixeira)]];
        nodeLixeira.physicsBody.categoryBitMask = lixeiraPlastico;
        nodeLixeira.position = CGPointMake(posX, frame.size.height*(1/5.0) );
    }
    
    [nodeLixeira setSize: CGSizeMake(comprimentoLixeira, alturaLixeira)];
    nodeLixeira.physicsBody.collisionBitMask = lixoMetal | lixoPapel | lixoVidro | lixoPlastico;
    nodeLixeira.physicsBody.contactTestBitMask = lixoMetal | lixoPapel | lixoVidro | lixoPlastico;
    nodeLixeira.physicsBody.dynamic = YES;
    nodeLixeira.physicsBody.affectedByGravity = NO;
    nodeLixeira.physicsBody.collisionBitMask = 0; //detecta a colisao mas nao deveria deixar atravesar
    
    return nodeLixeira;
}


+(SKSpriteNode *)lixoAleatorioNoFrame: (CGRect)frame{
    SKSpriteNode *nodeLixoNovo;
    CGSize nodeSize= CGSizeMake(40, 50);
    
    switch (arc4random()%4) { //sorteia o tipo de lixo gerado
        case 0:
            nodeLixoNovo =  [SKSpriteNode spriteNodeWithImageNamed:@"metal2.png"];
            [nodeLixoNovo setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: nodeSize ]];
            nodeLixoNovo.physicsBody.categoryBitMask = lixoMetal;
            //sortearia denovo uma imagem aleatoria deste tipo de lixo;
            break;
        case 1:
            nodeLixoNovo =  [SKSpriteNode spriteNodeWithImageNamed:@"papel2.png"];
            [nodeLixoNovo setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: nodeSize ]];
            nodeLixoNovo.physicsBody.categoryBitMask = lixoPapel;
            break;
        case 2:
            nodeLixoNovo =  [SKSpriteNode spriteNodeWithImageNamed:@"vidro2.png"];
            [nodeLixoNovo setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: nodeSize ]];
            nodeLixoNovo.physicsBody.categoryBitMask = lixoVidro;
            break;
        case 3:
            nodeLixoNovo =  [SKSpriteNode spriteNodeWithImageNamed:@"plastico2.png"];
            [nodeLixoNovo setPhysicsBody: [SKPhysicsBody bodyWithRectangleOfSize: CGSizeMake(40, 66) ]];
            nodeLixoNovo.physicsBody.categoryBitMask = lixoPlastico;
            break;
    }
    
    [nodeLixoNovo setSize:nodeSize];
    nodeLixoNovo.position = CGPointMake( (frame.size.width/2 + 75), (frame.size.height + nodeLixoNovo.frame.size.height/2));
    
    nodeLixoNovo.physicsBody.dynamic = YES;
    nodeLixoNovo.physicsBody.affectedByGravity = NO;
    nodeLixoNovo.physicsBody.collisionBitMask = lixeiraMetal | lixeiraPapel | lixeiraVidro | lixeiraPlastico;
    nodeLixoNovo.physicsBody.contactTestBitMask = lixeiraMetal | lixeiraPapel | lixeiraVidro | lixeiraPlastico;
    
    return nodeLixoNovo;
}

@end
