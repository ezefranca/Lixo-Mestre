//
//  MenuViewController.h
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MenuVCperfil.h"
#import "ConfiguracoesVC.h"



@interface MenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>{
    NSUserDefaults *preferencias;
}


@property (weak, nonatomic) IBOutlet UIView *profileview;
@property (weak, nonatomic) IBOutlet UILabel *nomeUsuario;

@property (weak, nonatomic) IBOutlet UITableView *MenuTableView;


@end
