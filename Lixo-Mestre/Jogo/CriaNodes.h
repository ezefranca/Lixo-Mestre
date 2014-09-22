//
//  CriaNodes.h
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 16/05/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "MascarasColisao.h"

@interface CriaNodes : NSObject

+(SKSpriteNode *)lixeiraTipo: (NSString *)material forFrame: (CGRect)frame;
+(SKSpriteNode *)lixoAleatorioNoFrame: (CGRect)frame;

@end
