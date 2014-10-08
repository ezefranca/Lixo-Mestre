//
//  LocalData.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/10/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface LocalData : NSObject

+(void)saveFacePic:(UIImage*) image;
+(UIImage *)loadFacePicture;

@end
