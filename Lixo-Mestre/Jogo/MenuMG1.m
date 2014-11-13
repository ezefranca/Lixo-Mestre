//
//  MenuMG1.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 13/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuMG1.h"
#import "MyScene.h"

@implementation MenuMG1


//r 216  g 241  b 241
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        self.backgroundColor = [SKColor colorWithRed:216/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
        
        [self setBotaoSair: [SKSpriteNode spriteNodeWithImageNamed:@"icone voltar.png"]];
        [[self botaoSair] setSize: CGSizeMake(30, 30)];
        [self botaoSair].position = CGPointMake(self.frame.size.width/2, [self botaoSair].frame.size.height *1.5);
        
        [self addChild: [self botaoSair]];
        
    }
    return self;
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
}


-(void)didMoveToView:(SKView *)view{
    UIImageView *imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 42) ];
    imgView.image = [UIImage imageNamed: @"tirinha.png"];
    [self.view addSubview: imgView];
    
    UIButton *voltar = [[UIButton alloc] initWithFrame: CGRectMake(8, 26, 30, 30)];
    [voltar addTarget:self action:@selector(voltarMenu) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview: voltar];
    
    
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
        for (SKSpriteNode *node in [[self view] subviews] ){
            if (CGRectContainsPoint(node.frame, location)) {

            }
            if (CGRectContainsPoint([self botaoSair].frame, location)) {
                [self sairDaCena];
            }
        }
    }
}

/**
 *  metodo do pseudo-botao para sair do jogo com auxilio do touchesBegan
 */
-(void)sairDaCena{
    if ([self valorPontuacao] > [[JogoViewController sharedJogoViewController] maiorPontuacao]) {
        [[JogoViewController sharedJogoViewController] setMaiorPontuacao: [self valorPontuacao]];
    }
    
    [[JogoViewController sharedJogoViewController] jogoTerminou];
    [self.view presentScene:nil];
    //aparentemente esse comando faz o equivalente ao dismiss na cena
}


-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];

    }
}


-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
