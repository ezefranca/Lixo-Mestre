//
//  MyScene.m
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 14/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "MyScene.h"
#import "CriaNodes.h"


@implementation MyScene

-(id)initWithSize:(CGSize)size {    
    if (self = [super initWithSize:size]) {
        [self setBg: [SKSpriteNode spriteNodeWithImageNamed:@"fundo joguinho.png"]];
        CGPoint bgponto = CGPointMake(self.size.width/2, self.size.height/2);
        self.bg.position = bgponto;
        [self addChild: self.bg];
        
        self.vidas = 3;
        
        //self.backgroundColor = [SKColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
        self.physicsWorld.contactDelegate = self; // TORNA A COLISAO POSIVEL!!! TINHA ESQUECIDO ISSO >.<
        
        self.valorPontuacao = 0;
        self.labelPontuacao = [SKLabelNode labelNodeWithFontNamed:@"Verdana"];
        self.labelPontuacao.text = [NSString stringWithFormat:@"%d", self.valorPontuacao];
        self.labelPontuacao.fontColor = [UIColor blackColor];
        self.labelPontuacao.position = CGPointMake(self.frame.size.width/2,
                                                self.frame.size.height - self.labelPontuacao.frame.size.height - 20) ;
        [self addChild: [self labelPontuacao]];
        
        self.lixeiraMetal = [CriaNodes lixeiraTipo:@"Metal" forFrame: self.frame];
        self.lixeiraPapel = [CriaNodes lixeiraTipo:@"Papel" forFrame: self.frame];
        self.lixeiraVidro = [CriaNodes lixeiraTipo:@"Vidro" forFrame: self.frame];
        self.lixeiraPlastico = [CriaNodes lixeiraTipo:@"Plastico" forFrame: self.frame];

        [self addChild: self.lixeiraMetal];
        [self addChild: self.lixeiraPapel];
        [self addChild: self.lixeiraVidro];
        [self addChild: self.lixeiraPlastico];
        
        self.lixos = [[NSMutableArray alloc] init];

        self.lixoSendoSegurado = false;
        
        [self performSelector:@selector(animaLixos) withObject:nil afterDelay:0.5];
        //[self animaLixosTeste: [NSNumber numberWithInt:2]];
        
        
        self.botaoSair = [SKSpriteNode spriteNodeWithImageNamed:@"icone voltar.png"];
        self.botaoSair.size = CGSizeMake(30, 30);
        self.botaoSair.position = CGPointMake(self.frame.size.width/2, [self botaoSair].frame.size.height *1.5);
        
        [self addChild: self.botaoSair];
        
    }
    return self;
}

/**
 *  Produzir Lixos com animacao de movimento! 
 * e verifica se ele ja andou pra fora da tela para remove-lo
 */
-(void)animaLixos{

    SKSpriteNode *lixo = [CriaNodes lixoAleatorioNoFrame: self.frame];
    [self.lixos addObject: lixo];
    [self addChild:lixo];

    for ( SKSpriteNode *nodeLixo in self.lixos ){
        if (nodeLixo.position.y + nodeLixo.size.height/2  < 0) {
            [self penaliza: nodeLixo];
            //[self.lixos removeObject: nodeLixo];
            

        }
        else{
            [nodeLixo runAction: [SKAction moveBy: CGVectorMake(0, -150) duration: 2]];
            [nodeLixo runAction: [SKAction rotateByAngle: arc4random()%7 duration: arc4random()%10+0.5]];
        }
        
    }
    [self performSelector:@selector(animaLixos) withObject:nil afterDelay:2];
}

/**
 *  animacões de movimento para brincar/teste
 *
 */
-(void)animaLixosTeste: (NSNumber* )animacao{    
    switch ([animacao intValue]) {
        case 1:
            for (SKSpriteNode *node in self.lixos){
                [node runAction: [SKAction moveBy:CGVectorMake(0, -100) duration:2]];
                [node runAction: [SKAction rotateByAngle:-(M_PI/2) duration:0.3]];
            }
            break;
        case 2:
            for (SKSpriteNode *node in self.lixos){
                [node runAction: [SKAction moveBy:CGVectorMake(-100, 0) duration:2]];
                [node runAction: [SKAction rotateByAngle:-(M_PI/2) duration:0.3]];
            }
            break;
        case 3:
            for (SKSpriteNode *node in self.lixos){
                [node runAction: [SKAction moveBy:CGVectorMake(0, 100) duration:2]];
                [node runAction: [SKAction rotateByAngle:-(M_PI/2) duration:0.3]];
            }
            break;
        case 4:
            for (SKSpriteNode *node in self.lixos){
                [node runAction: [SKAction moveBy:CGVectorMake(100, 0) duration:2]];
                [node runAction: [SKAction rotateByAngle:-(M_PI/2) duration:0.3]];
            }
            break;
    }

    animacao = [NSNumber numberWithInt:[animacao intValue] + 1];
    if ([animacao intValue] > 4) {
        animacao = [NSNumber numberWithInt:1];
    }
    [self performSelector:@selector(animaLixosTeste:) withObject:animacao afterDelay:2];
}

-(void) didBeginContact:(SKPhysicsContact *)contact{
    SKPhysicsBody *firstBody, *secondBody;
    
    if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask) {
        firstBody = contact.bodyA;
        secondBody = contact.bodyB;
    }
    else{
        firstBody = contact.bodyB;
        secondBody = contact.bodyA;
    }
    
    //verifica a colisao foi entre lixo deo tipo metal e a lixeira de metal
    //estes if/else feios sao feitos poequr eu preciso saber qual dos corpos eh o lixo para remove-lo
    //somete o fato de ter a colisao nao me diz quem é quem
    if (firstBody.categoryBitMask == lixeiraMetal) {
        if (secondBody.categoryBitMask == lixoMetal) {
            [self aumentaPontuacao: (SKSpriteNode *)secondBody.node];
            int metal = [[JogoViewController sharedJogoViewController] qteMetal];
            [[JogoViewController sharedJogoViewController] setQteMetal: metal + 1];
            return;
        }
    }
    else{
        if (firstBody.categoryBitMask == lixoMetal) {
            if (secondBody.categoryBitMask == lixeiraMetal) {
                [self aumentaPontuacao: (SKSpriteNode *)firstBody.node];
                int metal = [[JogoViewController sharedJogoViewController] qteMetal];
                [[JogoViewController sharedJogoViewController] setQteMetal: metal + 1];
                return;
            }
        }
    }
    //verifica a colisao foi entre lixo deo tipo papel e a lixeira de papel
    if (firstBody.categoryBitMask == lixeiraPapel) {
        if (secondBody.categoryBitMask == lixoPapel) {
            [self aumentaPontuacao: (SKSpriteNode *)secondBody.node];
            int papel = [[JogoViewController sharedJogoViewController] qtePapel];
            [[JogoViewController sharedJogoViewController] setQtePapel: papel + 1];
            return;
        }
    }
    else{
        if (firstBody.categoryBitMask == lixoPapel) {
            if (secondBody.categoryBitMask == lixeiraPapel) {
                [self aumentaPontuacao: (SKSpriteNode *)firstBody.node];
                int papel = [[JogoViewController sharedJogoViewController] qtePapel];
                [[JogoViewController sharedJogoViewController] setQtePapel: papel + 1];
                return;
            }
        }
    }
    //verifica a colisao foi entre lixo deo tipo metal e a lixeira de vidro
    if (firstBody.categoryBitMask == lixeiraVidro) {
        if (secondBody.categoryBitMask == lixoVidro) {
            [self aumentaPontuacao: (SKSpriteNode *)secondBody.node];
            int vidro = [[JogoViewController sharedJogoViewController] qteVidro];
            [[JogoViewController sharedJogoViewController] setQteVidro: vidro + 1];
            return;
        }
    }
    else{
        if (firstBody.categoryBitMask == lixoVidro) {
            if (secondBody.categoryBitMask == lixeiraVidro) {
                [self aumentaPontuacao: (SKSpriteNode *)firstBody.node];
                int vidro = [[JogoViewController sharedJogoViewController] qteVidro];
                [[JogoViewController sharedJogoViewController] setQteVidro: vidro + 1];
                return;
            }
        }
    }
    //verifica a colisao foi entre lixo deo tipo metal e a lixeira de plastico
    if (firstBody.categoryBitMask == lixeiraPlastico) {
        if (secondBody.categoryBitMask == lixoPlastico) {
            [self aumentaPontuacao: (SKSpriteNode *)secondBody.node];
            int plastico = [[JogoViewController sharedJogoViewController] qtePlastico];
            [[JogoViewController sharedJogoViewController] setQtePlastico: plastico + 1];
            return;
        }
    }
    else{
        if (firstBody.categoryBitMask == lixoPlastico) {
            if (secondBody.categoryBitMask == lixeiraPlastico) {
                [self aumentaPontuacao: (SKSpriteNode *)firstBody.node];
                int plastico = [[JogoViewController sharedJogoViewController] qtePlastico];
                [[JogoViewController sharedJogoViewController] setQtePlastico: plastico + 1];
                return;
            }
        }
    }
    
    //teve colisao mas nao acertou, remove o lixo da cena mesmo assim e tira ponto
    if ( !(firstBody.categoryBitMask == lixeiraMetal || firstBody.categoryBitMask == lixeiraPapel ||
           firstBody.categoryBitMask == lixeiraVidro || firstBody.categoryBitMask == lixeiraPlastico) ) {
        [self penaliza: firstBody.node];
        [self removeNode: firstBody.node];
    }
    
    if ( !(secondBody.categoryBitMask == lixeiraMetal || secondBody.categoryBitMask == lixeiraPapel ||
           secondBody.categoryBitMask == lixeiraVidro || secondBody.categoryBitMask == lixeiraPlastico) ) {
        [self penaliza: secondBody.node];
        [self removeNode: secondBody.node];
    }
    
    self.valorPontuacao = self.valorPontuacao -20;
    self.labelPontuacao.text = [NSString stringWithFormat:@"%d", self.valorPontuacao ];
    self.lixoSendoSegurado = false;
    
}
/**
 *  Metodo para incremento da pontuacao quando confirmado a colisao com a lixeira e o lixo correto e exclusao do mesmo *
 *  @param lixo Node do lixo que deve ser removido com animacao apos a colisao
 */
-(void)aumentaPontuacao: (SKSpriteNode *)lixo{
    self.valorPontuacao = self.valorPontuacao + 50;
    self.labelPontuacao.text = [NSString stringWithFormat:@"%d", self.valorPontuacao];
    self.lixoSendoSegurado = false;
    [self removeNode: lixo];
}
/**
 *  Faz apenas a remocao do node, mas esta em um metodo a parte para poder ser chamado com um delay
 *
 *  @param node Node que deve ser removido
 */
-(void)removeNode: (SKSpriteNode *)node{
    [node runAction: [SKAction fadeAlphaTo: 0.0 duration:0.3] completion:^{
        [node removeFromParent];
    }];
    
}
-(void)penaliza: (SKSpriteNode *)node{
    self.vidas = self.vidas -1;

    
    if (self.vidas <= 0) {
        [JogoViewController sharedJogoViewController].pontosDaUiltimaPartida.text = [NSString stringWithFormat:@"%d", self.valorPontuacao] ;
        
        [[JogoViewController sharedJogoViewController] morreuNoJogo];
        [self.view presentScene:nil];
        
    }

}

/**
 *  quando ocorre um toque, verifica se este aconteceu em algum dos nodes de lixo.
 *  se houver um toque encima de um node, guarda-o em uma propriedade do VC para atualizar a posicao posteriormente no touches moved
 *
 *  @param touches
 *  @param event
 */
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        for (SKSpriteNode *node in self.lixos ){
            if (CGRectContainsPoint(node.frame, location)) {
                [self.lixos removeObject: node];
                [node removeAllActions];
                [node runAction: [SKAction moveTo:location duration:0.05]];
                node.position = location;
                self.lixoSelecionado = node;
                self.lixoSendoSegurado = true;
                break;
            }
            if (CGRectContainsPoint(self.botaoSair.frame, location)) {
                [self sairDaCena];
            }
        }
    }
}

/**
 *  metodo do pseudo-botao para sair do jogo com auxilio do touchesBegan
 */
-(void)sairDaCena{
    if ( self.valorPontuacao > [JogoViewController sharedJogoViewController].maiorPontuacao ) {
        [JogoViewController sharedJogoViewController].maiorPontuacao = self.valorPontuacao;
    }
    [JogoViewController sharedJogoViewController].pontosDaUiltimaPartida.text = [NSString stringWithFormat:@"%d", self.valorPontuacao] ;
    
    [[JogoViewController sharedJogoViewController] jogoTerminouDesistencia];
    [self.view presentScene:nil];
    //aparentemente esse comando faz o equivalente ao dismiss na cena
}

/**
 *  quando o dedo é MOVIMENTADO, faz o node selecionado ir até a posicao deste toque
 *
 *  @param touches
 *  @param event
 */
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        if ( self.lixoSendoSegurado ) {
            if (location.x < self.lixeiraMetal.position.x) {
                [self.lixoSelecionado runAction: [SKAction moveTo:location duration:0.05]];
            }
        }
    }
}

/**
 *  quando o dedo é RETIRADO, o node sendo arrastado é também removido(e com animacao) e tira pontos, porem sāo menos pontos do que levar ao lixo errado
 *
 *  @param touches
 *  @param event
 */
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    if ( self.lixoSendoSegurado ) {
        self.valorPontuacao = self.valorPontuacao -15;
        self.labelPontuacao.text = [NSString stringWithFormat:@"%d", [self valorPontuacao]];
        self.lixoSendoSegurado = false;
    }
    [self removeNode: self.lixoSelecionado];
    [self.lixos removeObject: self.lixoSelecionado];
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
