//
//  LocalData.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 08/10/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "LocalData.h"

@implementation LocalData


+(void)saveFacePic:(UIImage*) image{
    NSData *data = UIImagePNGRepresentation(image);
    //Write the file out!
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path_to_file = [documentsDirectory stringByAppendingPathComponent:@"profileImage.png"];
    
    [data writeToFile:path_to_file atomically:YES];
    NSLog(@"Data saved.");
}


+(UIImage *)loadFacePicture{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *path_to_file = [documentsDirectory stringByAppendingPathComponent:@"profileImage.png"];
    
    UIImage *pic;
    
    if([[NSFileManager defaultManager] fileExistsAtPath:path_to_file]){
        NSData *data = [NSData dataWithContentsOfFile:path_to_file];
        
        pic = [[UIImage alloc] initWithData:data];
        NSLog(@"Found saved file, Finished loading in image");
    }
    else{
        pic = [UIImage imageNamed:@"b1bbbe.png"];
    }
    
    return pic;
}

@end
