//
//  segueManero.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 20/10/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "segueManero.h"
#import "LoginVC.h"

@implementation segueManero

-(void)perform{
    [[self sourceViewController] presentModalViewController: [self destinationViewController] animated:NO];
}

@end
