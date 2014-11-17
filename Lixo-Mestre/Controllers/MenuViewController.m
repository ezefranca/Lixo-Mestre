//
//  MenuViewController.m
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuTableViewCell.h"


@interface MenuViewController ()

@end

@implementation MenuViewController{
    NSArray *itemsMenu;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    preferencias = [NSUserDefaults standardUserDefaults];

    self.nomeUsuario.font = [UIFont fontWithName:@"Santor" size:17];
    
    itemsMenu = [NSArray arrayWithObjects:@"          Perfil",@"          Recompensas", @"          Estatistica", @"         Configuracoes", @"          Sair",nil];
    self.view.backgroundColor = [UIColor colorWithRed:0.0
                                                 green:128/255.0
                                                  blue:176/255.0
                                                 alpha:1.0];

    //Deixar imagem redonda 
    CGRect x = self.imagemPerfil.bounds;
    self.imagemPerfil.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.imagemPerfil.layer.borderWidth = 1.0f;
    self.imagemPerfil.layer.borderColor = [UIColor clearColor].CGColor;
    self.imagemPerfil.clipsToBounds = YES;

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.nomeUsuario.text = [preferencias objectForKey: @"Nome"];
    self.imagemPerfil.image = [LocalData loadFacePicture];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier: simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier: simpleTableIdentifier];
    }
    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, 70, 200, 40)];
//    label.text = [itemsMenu objectAtIndex:indexPath.row];
    
    UIImageView *imgview= [[UIImageView alloc] initWithFrame: CGRectMake(10, 15, 40, 40)];
    UIImage *imagem;
    
    switch (indexPath.row) {
        case 0:
            imagem = [UIImage imageNamed: @"icone perfil.png"];
            break;
        case 1:
            imagem = [UIImage imageNamed: @"icone recompensa.png"];
            break;
        case 2:
            imagem = [UIImage imageNamed: @"atividade.png"];
            break;
        case 3:
            imagem = [UIImage imageNamed: @"icone confg.png"];
            break;
        case 4:
            imagem = [UIImage imageNamed: @"icone sair.png"];
            break;
        default:
            imagem = [UIImage imageNamed: @"settings-100.png"];
            break;
    }
    imgview.image = imagem;
    [cell addSubview: imgview];
    
    
    cell.textLabel.text = [itemsMenu objectAtIndex:indexPath.row];
    
    if (indexPath.row%2 == 0){
        cell.backgroundColor = [UIColor colorWithRed: 1.0 green: 1.0 blue: 1.0 alpha: 1.0];
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed: 234/255.0 green: 232/255.0 blue: 232/255.0 alpha:1.0];
    }
    

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"Clicou em %ld", (long)indexPath.row);

    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier: @"aoPerfil" sender:nil];
            
            break;
        }
        case 1:{
            [self performSegueWithIdentifier: @"aoRecompensas" sender:nil];

            break;
        }
        case 2:{

            break;
        }
        case 3:{
            [self performSegueWithIdentifier: @"aoConfiguracoes" sender:nil];

            break;
        }
        default:{
            [FBSession.activeSession closeAndClearTokenInformation];
            [FBSession.activeSession close];
            [FBSession setActiveSession:nil];
            [LocalData deleteFacePicture];
            [preferencias setBool: NO forKey: @"Logado"];
            [self performSegueWithIdentifier: @"unwindLogout" sender:Nil];
            break;
        }
    }
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)unwindSegue{

}

@end
