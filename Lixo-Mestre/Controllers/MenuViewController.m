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

    self.nomeUsuario.text = [preferencias objectForKey:@"Nome"];
    self.nomeUsuario.font = [UIFont fontWithName:@"Santor" size:17];
    
    itemsMenu = [NSArray arrayWithObjects:@"Perfil",@"Recompensas", @"Estatistica", @"Configuracoes", nil];
    self.view.backgroundColor = [UIColor colorWithRed:0.0
                                                 green:128/255.0
                                                  blue:176/255.0
                                                 alpha:1.0];
    
    self.imagemPerfil.image = [LocalData loadFacePicture];
    //Deixar imagem redonda 
    CGRect x = self.imagemPerfil.bounds;
    self.imagemPerfil.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.imagemPerfil.layer.borderWidth = 1.0f;
    self.imagemPerfil.layer.borderColor = [UIColor clearColor].CGColor;
    self.imagemPerfil.clipsToBounds = YES;


}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    MenuTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[MenuTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    switch (indexPath.row) {
        case 0:
            cell.imageView.image = [UIImage imageNamed:@"conf.png"];
            break;
        case 1:
            cell.imageView.image = [UIImage imageNamed:@"recompensas.png"];
            break;
        case 2:
            cell.imageView.image = [UIImage imageNamed:@"estatistica.png"];
            break;
        case 3:
            cell.frame = CGRectMake(0, 0, 250, 250);
            cell.imageView.image = [UIImage imageNamed:@"conf.png"];
            break;
            
        default:
            cell.imageView.image = [UIImage imageNamed:@"settings-100.png"];
            break;
    }
    
    cell.textLabel.text = [itemsMenu objectAtIndex:indexPath.row];
    
    
    if (indexPath.row%2 == 0){
        cell.backgroundColor = [UIColor colorWithRed:234/255.0 green:232/255.0 blue:232/255.0 alpha:1.0];
        
    }
    else{
        cell.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:1.0];
    }
    

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //NSLog(@"Clicou em %ld", (long)indexPath.row);

    switch (indexPath.row) {
        case 0:{
            [self performSegueWithIdentifier:@"aoPerfil" sender:nil];
            
            break;
        }
        case 1:{

            break;
        }
        case 2:{

            break;
        }
        case 3:{
            [self performSegueWithIdentifier:@"aoConfiguracoes" sender:nil];

            break;
        }
        default:{

            break;
        }
    }
}

- (IBAction)unwindToMenu:(UIStoryboardSegue *)unwindSegue{

}

@end
