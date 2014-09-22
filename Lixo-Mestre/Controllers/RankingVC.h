//
//  RankingVC.h
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "RankingProvPontos.h"
#import "RankingProvBadges.h"
#import "YLProgressBar.h"

@interface RankingVC : UIViewController{
    NSUserDefaults *preferencias;
    NSDictionary *rankingJson;
    NSString *usuario;
}

@property (weak, nonatomic) IBOutlet UIView *tela1;

@property (weak, nonatomic) IBOutlet UIView *tela3;

@property (nonatomic, strong) IBOutlet UIButton* botaoCompartilhar;
//@property (nonatomic, strong) IBOutlet UIButton* botaoContato;

//@property (weak, nonatomic) IBOutlet UILabel *labelMetal;
@property (weak, nonatomic) IBOutlet UILabel *labelPapel;
//@property (weak, nonatomic) IBOutlet UILabel *labelPlastico;
//@property (weak, nonatomic) IBOutlet UILabel *labelVidro;
//@property (weak, nonatomic) IBOutlet UILabel *labelPontos;

@property UIProgressView *papel;
@property UIProgressView *plastico;
@property UIProgressView *vidro;
@property UIProgressView *metal;
@property UIProgressView *pontos;

@property UILabel *labelMetalProgress;
@property UILabel *labelPapelProgress;
@property UILabel *labelPlasticoProgress;
@property UILabel *labelVidroProgress;
@property UILabel *labelPontosProgress;

- (IBAction)botaoCompartilhar:(id)sender;
- (IBAction)botaoMenu:(id)sender;

@end
