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

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLayoutSubviews{
    [self.viewS setContentSize: CGSizeMake(320, 790)];
    [self inicializarManero];
}

-(void)viewDidAppear:(BOOL)animated{
    //coloca os valores nas progressview
    CGFloat npapel = [preferencias integerForKey:@"qtePapel"];
    CGFloat nplastico = [preferencias integerForKey:@"qtePlastico"];
    CGFloat nvidro = [preferencias integerForKey:@"qteVidro"] ;
    CGFloat nmetal = [preferencias integerForKey:@"qtePapel"] ;

    //NSLog(@"%0.2f %0.2f %0.2f %0.2f",npapel, nplastico, nvidro, nmetal);
    
    [[self papel] setProgress: npapel/50.0 animated:YES];
    [[self plastico] setProgress: nplastico/50.0 animated:YES];
    [[self vidro] setProgress: nvidro/50.0 animated:YES];
    [[self metal] setProgress: nmetal/50.0 animated:YES];
    
    [[self labelPapelProgress] setText: [NSString stringWithFormat:@"%0.0f/50", npapel]];
    [[self labelPlasticoProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nplastico]];
    [[self labelVidroProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nvidro]];
    [[self labelMetalProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nmetal]];

}





#pragma mark coisitas da progressview
- (void)inicializarManero
{
    CGAffineTransform trans = CGAffineTransformMakeScale(1.0f, 10.0f);
    UIColor *progressColour = [UIColor colorWithRed:0/255.0 green:127/255.0 blue:177/255.0 alpha:1.0];
    
    UIFont *labelProgFont = [UIFont fontWithName:@"Santor" size:17];
    
    //progressview e label da qte de papel
    [[self labelPapelProgress] setFont: labelProgFont];
    [[self papel] setProgressTintColor: progressColour];
    [self papel].transform = trans;

    // pra "arredondar"a borda
//    self.papel.layer.cornerRadius = 10;
//    self.papel.layer.masksToBounds = YES;
//    self.papel.layer.borderWidth = 0;
    
    //progressview e label da qte de plastico
    [[self labelPlasticoProgress] setFont: labelProgFont];
    [[self plastico] setProgressTintColor: progressColour];
    [self plastico].transform = trans;

    
    //progressview e label da qte de vidro
    [[self labelVidroProgress] setFont: labelProgFont];
    [[self vidro] setProgressTintColor: progressColour];
    [self vidro].transform = trans;
    

    //progressview e label da qte de metal
    [[self labelMetalProgress] setFont: labelProgFont];
    [[self metal] setProgressTintColor: progressColour];
    [self metal].transform = trans;
    
    
    //progressview e label da qte de metal
    [[self labelPapelCertProgress] setFont: labelProgFont];
    [[self papelCert] setProgressTintColor: progressColour];
    [self papelCert].transform = trans;
    
    
        //progressview e label da qte de metal
    [[self labelPlasticoCertProgress] setFont: labelProgFont];
    [[self plasticoCert] setProgressTintColor: progressColour];
    [self plasticoCert].transform = trans;
    
    
    //progressview e label da qte de metal
    [[self labelVidroCertProgress] setFont: labelProgFont];
    [[self vidroCert] setProgressTintColor: progressColour];
    [self vidroCert].transform = trans;
    
    
    //progressview e label da qte de metal
    [[self labelMetalCertProgress] setFont: labelProgFont];
    [[self metalCert] setProgressTintColor: progressColour];
    [self metalCert].transform = trans;
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
