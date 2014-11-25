//
//  ConfiguracoesVC.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 30/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "ConfiguracoesVC.h"

@interface ConfiguracoesVC ()

@end

@implementation ConfiguracoesVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    

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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


- (IBAction)voltar:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}



-(IBAction)logouty{
    [FBSession.activeSession closeAndClearTokenInformation];
    [FBSession.activeSession close];
    [FBSession setActiveSession:nil];
    [preferencias setBool: NO forKey:@"Logado"];
    
    [self performSegueWithIdentifier:@"unwindProLogin" sender:Nil];
}

-(BOOL)shouldAutorotate{
    return NO;
}

@end
