//
//  MyAnnotation.m
//  MAPlay
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "MyAnnotation.h"

@implementation MyAnnotation
//3.2
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title {
    if ((self = [super init])) {
        self.coordinate =coordinate;
        self.title = title;
    }
    return self;
}

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title  subtitle:(NSString*)subtitle{
    if ((self = [super init])) {
        self.coordinate =coordinate;
        self.title = title;
        self.subtitle = subtitle;
    }
    return self;
}@end
