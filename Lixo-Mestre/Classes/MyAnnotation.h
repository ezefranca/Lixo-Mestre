//
//  MyAnnotation.h
//  MAPlay
//
//  Created by Alessandro Camillo Gimenez de Menezes on 22/07/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface MyAnnotation : NSObject


//3.1
@property (strong, nonatomic) NSString *title;
@property (nonatomic) NSString *subtitle;
@property (nonatomic,assign) CLLocationCoordinate2D coordinate;
@property (nonatomic) int nTag;

-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title;
-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title  subtitle:(NSString*)subtitle;
//-(id) initWithCoordinate:(CLLocationCoordinate2D)coordinate title:(NSString *)title  tag:(NSInteger*)tag;
@end