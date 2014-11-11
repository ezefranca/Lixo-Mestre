//
//  RecompensasViewController.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 06/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecompensasViewController : UIViewController <UIScrollViewDelegate>{
    NSUserDefaults *preferencias;
    NSDictionary *rankingJson;
    NSString *usuario;
}

@property (weak, nonatomic) IBOutlet UIScrollView *viewS;


@property (weak, nonatomic) IBOutlet UIProgressView *papel;
@property (weak, nonatomic) IBOutlet UIProgressView *plastico;
@property (weak, nonatomic) IBOutlet UIProgressView *vidro;
@property (weak, nonatomic) IBOutlet UIProgressView *metal;

@property (weak, nonatomic) IBOutlet UIProgressView *papelCert;
@property (weak, nonatomic) IBOutlet UIProgressView *plasticoCert;
@property (weak, nonatomic) IBOutlet UIProgressView *vidroCert;
@property (weak, nonatomic) IBOutlet UIProgressView *metalCert;


@property (weak, nonatomic) IBOutlet UILabel *labelPapelProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelPlasticoProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelVidroProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelMetalProgress;

@property (weak, nonatomic) IBOutlet UILabel *labelPapelCertProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelPlasticoCertProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelVidroCertProgress;
@property (weak, nonatomic) IBOutlet UILabel *labelMetalCertProgress;



@end
