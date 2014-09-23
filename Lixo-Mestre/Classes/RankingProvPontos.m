//
//  RankingProvPontos.m
//  LixoPapao
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "RankingProvPontos.h"

@implementation RankingProvPontos

-(id)init{
    self = [super init];
    if (self) {
        NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
        self.metal = (int)[preferencias integerForKey:@"qteMetal"];
        self.papel = (int)[preferencias integerForKey:@"qtePapel"];
        self.vidro = (int)[preferencias integerForKey:@"qteVidro"];
        self.plastico = (int)[preferencias integerForKey:@"qtePlastico"];
        
        self.scores = [[NSMutableArray alloc] initWithObjects:[NSString stringWithFormat:@"metal: %d", self.metal],
                                                              [NSString stringWithFormat:@"papel: %d", self.papel],
                                                              [NSString stringWithFormat:@"vidro: %d", self.vidro],
                                                              [NSString stringWithFormat:@"plastico: %d", self.plastico] , nil];
    }
    
    return self;
}

+(RankingProvPontos*)sharedRankingPontos{
    static RankingProvPontos*sharedRanking = nil;
    @synchronized(self){
        if (sharedRanking == nil) {
            sharedRanking = [[super allocWithZone:NULL] init];
        }
    }
    return  sharedRanking;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedRankingPontos];
}


@end
