//
//  RecompensasViewController.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 06/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RecompensasViewController : UIViewController  <UITableViewDelegate, UITableViewDataSource>{
    NSUserDefaults *preferencias;
    NSDictionary *rankingJson;
    NSString *usuario;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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

@end
