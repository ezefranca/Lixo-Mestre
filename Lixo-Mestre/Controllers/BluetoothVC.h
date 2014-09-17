//
//  HomeViewController.h
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "RedeSocialVC.h"
//#import "PerfilVC.h"
#import "MapaVC.h"
#import <CoreBluetooth/CoreBluetooth.h>
#import "CNBluetoothCentral.h"
#import "SVProgressHUD.h"
#import "webService.h"

#define rgb(r, g, b)  [UIColor colorWithRed:((r) / 255.0) green:((g) / 255.0) blue:((b) / 255.0) alpha:1.0]

@interface BluetoothVC : UIViewController <CNBluetoothCentralDelegate, UIActionSheetDelegate>{
    NSUserDefaults *preferencias;
    BOOL senhaSalva;
    __weak IBOutlet UIImageView *imagemConectar;
}


@property int tipo;
@property BOOL conectado;
@property (weak, nonatomic) IBOutlet UIButton *botaoLixo;
@property (weak, nonatomic) IBOutlet UIButton *botaoConectar;
//@property (weak, nonatomic) IBOutlet UILabel *statusLbl;

- (IBAction)botaoConectar:(id)sender;
- (IBAction)botaoLixo:(id)sender;

- (void)enviarLixo;

- (IBAction)botaoMenu:(id)sender;

@end
