//
//  ViewProgresso.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 01/10/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "ViewProgresso.h"

@implementation ViewProgresso

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)drawRect:(CGRect)rect{
    preferencias = [NSUserDefaults standardUserDefaults];
    CGContextRef ctx = UIGraphicsGetCurrentContext();

    CGPoint centroPapel = CGPointMake(105, 80);
    CGPoint centroVidro = CGPointMake(215, 80);
    CGPoint centroPlastico = CGPointMake(105, 185);
    CGPoint centroMetal = CGPointMake(215, 185);

    CGContextSetRGBStrokeColor(ctx, 0/255.0, 127/255.0, 177/255.0, 1.0);
    CGContextSetLineWidth(ctx, 6);
    
    int qtePapel = (int)[preferencias integerForKey:@"qtePapel"];
    int qteMetal = (int)[preferencias integerForKey:@"qteMetal"];
    int qteVidro =  (int)[preferencias integerForKey:@"qteVidro"];
    int qtePlastico = (int)[preferencias integerForKey:@"qtePlastico"];
    
    float total = qteMetal + qtePapel + qtePlastico + qteVidro;
    
    int raio = 35;
//    CGContextAddArc(<#CGContextRef c#>, <#CGFloat x#>, <#CGFloat y#>, <#CGFloat radius#>, <#CGFloat startAngle#>, <#CGFloat endAngle#>, <#int clockwise#>);
    
    float startAngle = (M_PI*3)/2;
    //progress do papel
    CGContextAddArc(ctx, centroPapel.x, centroPapel.y, raio, startAngle, startAngle + M_PI*2.0*((qtePapel/total)*1.0), NO);
    CGContextStrokePath(ctx);
    
    //progress do metal
    CGContextAddArc(ctx, centroMetal.x, centroMetal.y, raio,  startAngle, startAngle + M_PI*2.0*((qteMetal/total)*1.0), NO);
    CGContextStrokePath(ctx);
    
    //progress do plastico
    CGContextAddArc(ctx, centroPlastico.x, centroPlastico.y, raio,  startAngle , startAngle + M_PI*2.0*((qtePlastico/total)*1.0), NO);
    CGContextStrokePath(ctx);
    
    //progress do vidro
    CGContextAddArc(ctx, centroVidro.x, centroVidro.y, raio,  startAngle, startAngle + M_PI*2.0*((qteVidro/total)*1.0), NO);
    CGContextStrokePath(ctx);
    
  
}

@end
