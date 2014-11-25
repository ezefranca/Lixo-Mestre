//
//  ConfiguracoesVC.h
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 30/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>

@interface ConfiguracoesVC : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource>{
    NSUserDefaults *preferencias;
}

@property (weak, nonatomic) IBOutlet UITableView *tableView;


- (IBAction)voltar:(id)sender;


@end
