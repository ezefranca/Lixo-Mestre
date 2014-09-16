//
//  RankingProvPontos.h
//  LixoPapao
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingProvPontos : NSObject

@property NSMutableArray * scores;

@property int metal;
@property int papel;
@property int vidro;
@property int plastico;

+(RankingProvPontos*)sharedRankingPontos;
+(id)allocWithZone:(struct _NSZone *)zone;

@end
