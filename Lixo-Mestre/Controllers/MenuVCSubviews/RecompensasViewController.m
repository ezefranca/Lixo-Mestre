//
//  RecompensasViewController.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 06/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "RecompensasViewController.h"

@interface RecompensasViewController ()

@end

@implementation RecompensasViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    preferencias = [NSUserDefaults standardUserDefaults];
    
    self.nomeUsuario.font = [UIFont fontWithName:@"Santor" size:17];
    self.nomeUsuario.text = [preferencias objectForKey:@"Nome"];
    
    self.qteMoedas.font = [UIFont fontWithName:@"Santor" size:15];
//    self.qteMoedas.text = [NSString stringWithFormat:@"%ld moedas", (long)[preferencias integerForKey:@"userMoedas"]];
    self.qteMoedas.text = @"550 moedas";
    
    self.qteEstrelas.font = [UIFont fontWithName:@"Santor" size:15];
//    self.qteEstrelas.text = [NSString stringWithFormat:@"%ld estrelas", (long)[preferencias integerForKey:@"userEstrelas"]];
    self.qteEstrelas.text = @"8 estrelas";
    
    [self setAllProgressViews: [NSArray arrayWithObjects:
                             self.papel,
                             self.plastico,
                             self.vidro,
                             self.metal,
                             self.papelCert,
                             self.plasticoCert,
                             self.vidroCert,
                             self.metalCert,nil]];
    
    [self setAllProgressLabels:[NSArray arrayWithObjects:
                                self.labelPapelProgress,
                                self.labelPlasticoProgress,
                                self.labelVidroProgress,
                                self.labelMetalProgress,
                                self.labelPapelCertProgress,
                                self.labelPlasticoCertProgress,
                                self.labelVidroCertProgress,
                                self.labelMetalCertProgress,
                                nil]];
    [self inicializarManero];
    // Do any additional setup after loading the view.
    

    NSNumber *a = [[NSNumber alloc] initWithInt:5];
    NSNumber *b = [[NSNumber alloc] initWithInt:10];
    NSNumber *c = [[NSNumber alloc] initWithInt:15];
    NSNumber *d = [[NSNumber alloc] initWithInt:20];
    NSNumber *e = [[NSNumber alloc] initWithInt:25];

    qteLixosAmounts = [NSMutableArray arrayWithObjects: a,b,c,d,e, nil];
    
   
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews
{
    [self.viewS setContentSize: CGSizeMake(320, 800)];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self setValoresProgress];
}


#pragma mark coisitas da progressview
- (void)inicializarManero
{
    CGAffineTransform trans = CGAffineTransformMakeScale(1.0f, 10.0f);
    UIColor *progressColour = [UIColor colorWithRed:0/255.0 green:127/255.0 blue:177/255.0 alpha:1.0];

    for (UIProgressView *progress in [self allProgressViews]) {
        [progress setProgressTintColor: progressColour];
        progress.transform = trans;
        // pra "arredondar"a borda
//        self.papel.layer.cornerRadius = 10;
//        self.papel.layer.masksToBounds = YES;
//        self.papel.layer.borderWidth = 0;
    }
    
    UIFont *labelProgFont = [UIFont fontWithName: @"Santor" size:17];
    
    for (UILabel *label in [self allProgressLabels]) {
        [label setFont: labelProgFont];
    }

}


-(void)setValoresProgress
{
    //coloca os valores nas progressview
    CGFloat npapel = [preferencias integerForKey: @"qtePapel"];
    CGFloat nplastico = [preferencias integerForKey: @"qtePlastico"];
    CGFloat nvidro = [preferencias integerForKey: @"qteVidro"];
    CGFloat nmetal = [preferencias integerForKey: @"qtePapel"];
    
//    CGFloat nPapelC = [preferencias integerForKey: @"qtePapelCerto"];
//    CGFloat nPlasticoC = [preferencias integerForKey: @"qtePlasticoCerto"];
//    CGFloat nVidroC = [preferencias integerForKey: @"qteVidroCerto"];
//    CGFloat nMetalC = [preferencias integerForKey: @"qtePapelCerto"];
    CGFloat nPapelC = 2;
    CGFloat nPlasticoC = 4;
    CGFloat nVidroC = 1;
    CGFloat nMetalC = 3;
    
//    CGFloat tpapel = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosPapel"]] integerValue];
//    CGFloat tplastico = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosPlastico"]] integerValue];
//    CGFloat tvidro = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosVidro"]] integerValue];
//    CGFloat tmetal = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosMetal"]] integerValue];
    CGFloat tpapel =    [[qteLixosAmounts objectAtIndex: 2] integerValue];
    CGFloat tplastico = [[qteLixosAmounts objectAtIndex: 3] integerValue];
    CGFloat tvidro =    [[qteLixosAmounts objectAtIndex: 4] integerValue];
    CGFloat tmetal =    [[qteLixosAmounts objectAtIndex: 2] integerValue];
    
//    CGFloat tPapelC = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosPapelCert"]] integerValue];
//    CGFloat tPlasticoC = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosPapelCert"]] integerValue];
//    CGFloat tVidroC = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey: @"qteCiclosPapelCert"]] integerValue];
//    CGFloat tMetalC = [[qteLixosAmounts objectAtIndex: [preferencias integerForKey:@"qteCiclosPapelCert"]] integerValue];
    CGFloat tPapelC =    [[qteLixosAmounts objectAtIndex: 0] integerValue];
    CGFloat tPlasticoC = [[qteLixosAmounts objectAtIndex: 0] integerValue];
    CGFloat tVidroC =    [[qteLixosAmounts objectAtIndex: 0] integerValue];
    CGFloat tMetalC =    [[qteLixosAmounts objectAtIndex: 0] integerValue];
    
    
    [self.papel setProgress: npapel/tpapel animated: YES];
    [self.plastico setProgress: nplastico/tplastico animated: YES];
    [self.vidro setProgress: nvidro/tvidro animated: YES];
    [self.metal setProgress: nmetal/tmetal animated: YES];
    
    [self.papelCert setProgress: nPapelC/tPapelC animated: YES];
    [self.plasticoCert setProgress: nPlasticoC/tPlasticoC animated: YES];
    [self.vidroCert setProgress: nVidroC/tVidroC animated: YES];
    [self.metalCert setProgress: nMetalC/tMetalC animated: YES];
    
    
    self.labelPapelProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", npapel, tpapel];
    self.labelPlasticoProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nplastico, tplastico];
    self.labelVidroProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nvidro, tvidro ];
    self.labelMetalProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nmetal, tmetal ];
    
    self.labelPapelCertProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nPapelC, tPapelC ];
    self.labelPlasticoCertProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nPlasticoC, tPlasticoC];
    self.labelVidroCertProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nVidroC, tVidroC];
    self.labelMetalCertProgress.text = [NSString stringWithFormat: @"%0.0f/%0.0f", nMetalC, tMetalC];

}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
