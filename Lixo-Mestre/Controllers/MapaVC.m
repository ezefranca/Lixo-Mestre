//
//  MapaVC.m
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import "MapaVC.h"
#import "SVProgressHUD.h"
#import "MyAnnotation.h"

#define METERS_PER_MILE 1609.344

@interface MapaVC ()

@end

@implementation MapaVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if ( self ) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    
    self.mapa.delegate = self;
    self.mapa.showsUserLocation = TRUE;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appToBackground) name:UIApplicationDidEnterBackgroundNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(appReturnsActive) name:UIApplicationDidBecomeActiveNotification object:nil];

    [self performSelectorInBackground:@selector(conectar) withObject:nil];
    
//    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftGesture)];
//    left.direction = UISwipeGestureRecognizerDirectionLeft;
//    [[self view] addGestureRecognizer:left];
//    
//    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightGesture)];
//    right.direction = UISwipeGestureRecognizerDirectionRight;
//    [[self view] addGestureRecognizer:right];
    
    
    /*
    BOOL first = TRUE;
    double x1,x2,y1,y2;
    double dx ;
    double dy;
    double dist;
    double menor = 0.0;
    CLLocationCoordinate2D c;
    
    x1 = self.mapa.userLocation.location.coordinate.latitude;
    y1 = self.mapa.userLocation.location.coordinate.longitude;
    
    for (CLLocation *l in self.mapa.annotations) {
        
        x2 = l.coordinate.latitude;
        y2 = l.coordinate.longitude;
        
        dx = (x2-x1);
        dy = (y2-y1);
        dist = sqrt(dx*dx + dy*dy);
        
        dist = dist * (-1);
        
        if (first) {
            
            menor = dist;
            c.latitude = x2;
            c.longitude = y2;
            first = FALSE;
        }
        else
        {
            if (dist < menor) {
                menor = dist;
                c.latitude = x2;
                c.longitude = y2;
            }
        }
    }
     
    
    MKDirectionsRequest *directionsRequest = [MKDirectionsRequest new];
    // Start at our current location
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    [directionsRequest setSource:source];
    // Make the destination
    CLLocationCoordinate2D destinationCoords = c;
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoords addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    [directionsRequest setDestination:destination];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        // We're done
        
        // Now handle the result
        if (error) {
            NSLog(@"There was an error getting your directions");
            return;
        }
        
        // So there wasn't an error - let's plot those routes
        _currentRoute = [response.routes firstObject];
        [self plotRouteOnMap:_currentRoute];
    }];
    */
    
    CLLocationCoordinate2D zoomLocation;
    zoomLocation.latitude = -23.669569;
    zoomLocation.longitude= -46.700767;
    
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(zoomLocation, 1.5*METERS_PER_MILE, 1.5*METERS_PER_MILE);
    [self.mapa setRegion:viewRegion animated:YES];
    
    
    //com delay pra nao "travar" antes de abrir a view do mapa
    self.routeOverlay = nil;
    
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

-(void)conectar
{
    NSString *url = [NSString stringWithFormat: @"http://172.246.16.27/lixoPapao/retornaPontos.php"];
    jsonDados = [[NSData alloc] initWithContentsOfURL:
                 [NSURL URLWithString:url]];
    
    
    NSError *error;
    
    NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                             JSONObjectWithData:jsonDados
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
    NSMutableArray *arraydaora;
    arraydaora = [[NSMutableArray alloc] init];
    arraydaora = (NSMutableArray *)jsonDadosUsuario;
    //NSLog(@"%@", [arraydaora[1]objectForKey:@"latitude"]);
    //NSLog(@"%@", [arraydaora[1]objectForKey:@"longitude"]);
    
    
     for (id local in arraydaora) {
     CLLocationCoordinate2D coordinate1;
     coordinate1.latitude = [[local objectForKey: @"latitude"] doubleValue];
     coordinate1.longitude = [[local objectForKey: @"longitude"] doubleValue];
     NSString *tipo = [local objectForKey: @"tipo"];
     
     if ([[local objectForKey: @"nome"] isEqualToString: @"type"]) {
     [local setObject: tipo forKey: @"nome"];
     }
     //        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:coordinate1 title:[local objectForKey:@"nome"] subtitle: tipo];
     //        [self.mapa addAnnotation: annotation];
     
     MKPointAnnotation * ann = [[MKPointAnnotation alloc] init];
     [ann setTitle: [local objectForKey: @"nome"]];
     [ann setSubtitle: tipo];
     [ann setCoordinate:coordinate1];
     [self.mapa addAnnotation: ann];
     }
    
    
    [self setViewDasAnnotations: [self.mapa annotations]];
    //[SVProgressHUD dismiss];
    //float x = [arraydaora objectAtIndex:0];
}

  /*
-(void)parseDados{
    NSError *error;
    
    NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                             JSONObjectWithData:jsonDados
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
    NSMutableArray *arraydaora;
    arraydaora = [[NSMutableArray alloc] init];
    arraydaora = (NSMutableArray *)jsonDadosUsuario;
    NSLog(@"%@", [arraydaora[1]objectForKey:@"latitude"]);
    NSLog(@"%@", [arraydaora[1]objectForKey:@"longitude"]);
    
  
    for (id local in arraydaora) {
        CLLocationCoordinate2D coordinate1;
        coordinate1.latitude = [[local objectForKey:@"latitude"] doubleValue];
        coordinate1.longitude = [[local objectForKey:@"longitude"] doubleValue];
        NSString *tipo = [local objectForKey:@"tipo"];
        
        if ([[local objectForKey:@"nome"] isEqualToString: @"type"]) {
            [local setObject: tipo forKey:@"nome"];
        }
        //        MyAnnotation *annotation = [[MyAnnotation alloc] initWithCoordinate:coordinate1 title:[local objectForKey:@"nome"] subtitle: tipo];
        //        [self.mapa addAnnotation: annotation];
        
        MKPointAnnotation * ann = [[MKPointAnnotation alloc] init];
        [ann setTitle: [local objectForKey:@"nome"]];
        [ann setSubtitle: tipo];
        [ann setCoordinate:coordinate1];
        [self.mapa addAnnotation: ann];
    }
   
    
    [self setViewDasAnnotations: [self.mapa annotations]];
    [SVProgressHUD dismiss];
    //float x = [arraydaora objectAtIndex:0];
}

*/
-(void) viewWillDisappear:(BOOL)animated{
    //[self.mapa removeAnnotations: [self.mapa annotations]];
}

#pragma mark - MKMapViewDelegate methods
- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id)annotation {
    if([annotation isKindOfClass:[MKUserLocation class]]) {
        return nil;
    }
    
    static NSString *identifier = @"myAnnotation";
    MKAnnotationView * annotationView = (MKAnnotationView *)[self.mapa dequeueReusableAnnotationViewWithIdentifier:identifier];
    if ( !annotationView ){
        annotationView = [[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:identifier];
        annotationView.canShowCallout = YES;
        
        //aki que muda a imagem do pino dependendo do do tipo de ponto
        if ( [[annotation subtitle] isEqualToString: @"pev"] ||
            [[annotation subtitle] isEqualToString: @"triagem"] ||
            [[annotation subtitle] isEqualToString: @"comercio"] ){
            annotationView.image = [UIImage imageNamed: @"mapa-coleta.png"];
        }
        else{
            if ( [[annotation subtitle] isEqualToString: @"cooperativa"] ||
                [[annotation subtitle] isEqualToString: @"associacao"]) {
                annotationView.image = [UIImage imageNamed: @"mapa-$.png"];
            }
            else{
                annotationView.image = [UIImage imageNamed: @"mapa-lixopapao.png"];
            }
        }
    }
    else{
        annotationView.annotation = annotation;
    }
    return annotationView;
}

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view{
    [self fazRota:view];
}

- (MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
    MKPolylineRenderer *renderer = [[MKPolylineRenderer alloc] initWithPolyline:overlay];
    renderer.strokeColor = [UIColor redColor];
    renderer.lineWidth = 4.0;
    return  renderer;
}

-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error{
    NSLog(@"%@", error);
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Nāo foi possivel encontrar sua localizaçāo." message: error.localizedFailureReason delegate:self cancelButtonTitle: @"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
}

- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated{
}

#pragma mark - Utility Methods
- (IBAction)botaoMapaLixoPapao:(id)sender {
    CLLocationCoordinate2D userLoc;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            userLoc = [annotation coordinate];
            break;
        }
    }
    CLLocationCoordinate2D currentPoint;
    CLLocationCoordinate2D closestPoint = CLLocationCoordinate2DMake(CLLocationDistanceMax, CLLocationDistanceMax);
    MKPointAnnotation *point;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ( [[annotation subtitle] isEqualToString: @"lixo papao"]) {
            currentPoint = [annotation coordinate];
            
            if ( sqrt(pow(userLoc.latitude - currentPoint.latitude, 2) + pow(userLoc.longitude - currentPoint.longitude, 2)) <
                sqrt(pow(userLoc.latitude - closestPoint.latitude, 2) + pow(userLoc.longitude - closestPoint.longitude, 2)) ) {
                closestPoint = currentPoint;
                point = annotation;
            }
        }
    }
    [self fazRota: [self.mapa viewForAnnotation:point]];
    
}

- (IBAction)botaoMapaColeta:(id)sender {
    CLLocationCoordinate2D userLoc;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            userLoc = [annotation coordinate];
            break;
        }
    }
    CLLocationCoordinate2D currentPoint;
    CLLocationCoordinate2D closestPoint = CLLocationCoordinate2DMake(CLLocationDistanceMax, CLLocationDistanceMax);
    MKPointAnnotation *point;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ( [[annotation subtitle] isEqualToString: @"pev"] ||
            [[annotation subtitle] isEqualToString: @"triagem"] ||
            [[annotation subtitle] isEqualToString: @"comercio"] ) {
            currentPoint = [annotation coordinate];
            
            if ( sqrt(pow(userLoc.latitude - currentPoint.latitude, 2) + pow(userLoc.longitude - currentPoint.longitude, 2)) <
                sqrt(pow(userLoc.latitude - closestPoint.latitude, 2) + pow(userLoc.longitude - closestPoint.longitude, 2)) ) {
                closestPoint = currentPoint;
                point = annotation;
            }
        }
    }
    [self fazRota: [self.mapa viewForAnnotation:point]];
}

- (IBAction)botaoMapaCifrao:(id)sender{
    CLLocationCoordinate2D userLoc;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ([annotation isKindOfClass:[MKUserLocation class]]) {
            userLoc = [annotation coordinate];
            break;
        }
    }
    CLLocationCoordinate2D currentPoint;
    CLLocationCoordinate2D closestPoint = CLLocationCoordinate2DMake(CLLocationDistanceMax, CLLocationDistanceMax);
    MKPointAnnotation *point;
    for ( id<MKAnnotation> annotation in [self viewDasAnnotations]) {
        if ( [[annotation subtitle] isEqualToString: @"cooperativa"] ||
            [[annotation subtitle] isEqualToString: @"associacao"]) {
            currentPoint = [annotation coordinate];
            
            if ( sqrt(pow(userLoc.latitude - currentPoint.latitude, 2) + pow(userLoc.longitude - currentPoint.longitude, 2)) <
                sqrt(pow(userLoc.latitude - closestPoint.latitude, 2) + pow(userLoc.longitude - closestPoint.longitude, 2)) ) {
                closestPoint = currentPoint;
                point = annotation;
            }
        }
    }
    [self fazRota: [self.mapa viewForAnnotation:point]];
}

-(void)fazRota: (MKAnnotationView *)view{
    CLLocationCoordinate2D y = [[ view annotation] coordinate];
    MKDirectionsRequest *directionsRequest = [MKDirectionsRequest new];
    // Start at our current location
    MKMapItem *source = [MKMapItem mapItemForCurrentLocation];
    [directionsRequest setSource:source];
    // Make the destination
    CLLocationCoordinate2D destinationCoords = y;
    
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc] initWithCoordinate:destinationCoords addressDictionary:nil];
    MKMapItem *destination = [[MKMapItem alloc] initWithPlacemark:destinationPlacemark];
    [directionsRequest setDestination:destination];
    
    MKDirections *directions = [[MKDirections alloc] initWithRequest:directionsRequest];
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse *response, NSError *error) {
        // We're done
        
        // Now handle the result
        if ( error ) {
            NSLog(@"There was an error getting your directions");
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nāo foi possivel traçar nova a rota." message: error.localizedFailureReason delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
            alert.alertViewStyle = UIAlertViewStyleDefault;
            [alert show];
            return;
        }
        // So there wasn't an error - let's plot those routes
        _currentRoute = [response.routes firstObject];
        [self plotRouteOnMap:_currentRoute];
    }];
}

- (IBAction)estiloMapa:(id)sender {
    NSInteger opcaoescolhida = [sender selectedSegmentIndex];
    switch (opcaoescolhida) {
        case 0:
            [[self mapa] setMapType:MKMapTypeStandard];
            break;
        case 1:
            [[self mapa] setMapType:MKMapTypeSatellite];
            break;
        case 2:
            [[self mapa] setMapType:MKMapTypeHybrid];
            break;
        default:
            break;
    }
}

- (void)plotRouteOnMap:(MKRoute *)route{
    if( _routeOverlay ) {
        [self.mapa removeOverlay:_routeOverlay];
    }
    // Update the ivar
    _routeOverlay = route.polyline;
    
    // Add it to the map
    [self.mapa addOverlay:_routeOverlay];
}

- (void)appToBackground{
    [self.mapa setShowsUserLocation:NO];
}

- (void)appReturnsActive{
    [self.mapa setShowsUserLocation:YES];
}

- (void)navegacaoManeira:(UIViewController*)tela{
    [self presentViewController:tela animated:YES completion:nil];
}


- (IBAction)botaoMenu:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

-(BOOL)shouldAutorotate{
    return NO;
}

@end
