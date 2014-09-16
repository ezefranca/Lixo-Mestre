//
//  MapaVC.h
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"

@interface MapaVC : UIViewController<MKMapViewDelegate, CLLocationManagerDelegate>{
    NSData *jsonDados;
}

@property (weak, nonatomic) IBOutlet MKMapView *mapa;
@property NSArray *viewDasAnnotations;
@property MKPolyline *routeOverlay;
@property MKRoute *currentRoute;

- (IBAction)botaoMenu:(id)sender;

- (IBAction)botaoMapaLixoPapao:(id)sender;
- (IBAction)botaoMapaColeta:(id)sender;
- (IBAction)botaoMapaCifrao:(id)sender;


@end
