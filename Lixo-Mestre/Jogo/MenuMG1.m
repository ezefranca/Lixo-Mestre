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
    }
    return self;
}


-(void)didMoveToView:(SKView *)view{
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}
-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event{
}
-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event{
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
