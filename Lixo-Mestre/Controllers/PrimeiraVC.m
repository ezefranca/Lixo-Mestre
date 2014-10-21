//
//  PrimeiraVC.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 20/10/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "PrimeiraVC.h"

@interface PrimeiraVC ()

@end

@implementation PrimeiraVC

- (void)viewDidLoad {
    [super viewDidLoad];
       // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    preferencias = [NSUserDefaults standardUserDefaults];
    estaLogado = [preferencias boolForKey:@"Logado"];
    // Verifiva se o opcao de mostrar tutorial esta habilitada no settings

    if( estaLogado ){
        [self performSegueWithIdentifier:@"1stAoTabbar" sender:nil];
    
    }else{
        [self performSegueWithIdentifier:@"1stAoLogin" sender:nil];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
