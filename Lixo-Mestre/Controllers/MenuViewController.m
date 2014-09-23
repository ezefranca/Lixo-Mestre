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
    itemsMenu = [NSArray arrayWithObjects:@"Perfil",@"Recompensas", @"Total Reciclado", @"Estatistica", @"Configuracao", nil];
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
    
    cell.textLabel.text = [itemsMenu objectAtIndex:indexPath.row];
    cell.imageView.image = [UIImage imageNamed:@"settings-100.png"];
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"Clicou em %ld", (long)indexPath.row);
    
    UIStoryboard *Board = [UIStoryboard storyboardWithName:@"LixoPapao" bundle:nil];

    
    switch (indexPath.row) {
        case 0:{
            LoginVC* l = [Board instantiateViewControllerWithIdentifier:@"Login"];
            [self presentViewController:l animated:YES completion:nil];
            
            break;
        }
        case 1:{
            break;
        }
        case 2:{
            break;
        }
        case 3:{
            break;
        }
        default:{
            break;
        }
    }
    
    
}

@end
