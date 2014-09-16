//
//  RankingProvBadges.m
//  LixoPapao
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "RankingProvBadges.h"

@implementation RankingProvBadges

-(id)init{
    self = [super init];
    if (self) {
        NSUserDefaults * preferencias = [NSUserDefaults standardUserDefaults];
        self.pontuacao = [preferencias integerForKey:@"maiorPontuacao"];
        
        self.scores = [[NSMutableArray alloc] initWithObjects: [NSString stringWithFormat:@"Maior pontuacao: %d", self.pontuacao], nil];
    }
    
    return self;
}

+(RankingProvBadges*)sharedRankingBadges{
    static RankingProvBadges*sharedRanking = nil;
    @synchronized(self){
        if (sharedRanking == nil) {
            sharedRanking = [[super allocWithZone:NULL] init];
        }
    }
    return  sharedRanking;
}

+(id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedRankingBadges];
}


@end
