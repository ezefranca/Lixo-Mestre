//
//  RankingProvBadges.h
//  LixoPapao
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RankingProvBadges : NSObject

@property NSMutableArray * scores;
@property int pontuacao;

+(RankingProvBadges*)sharedRankingBadges;
+(id)allocWithZone:(struct _NSZone *)zone;

@end
