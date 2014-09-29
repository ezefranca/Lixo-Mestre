//
//  RankingVC2.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 26/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "RankingVC2.h"
#import "JogoViewController.h"
#import "webService.h"

@interface RankingVC2 ()

@end

@implementation RankingVC2

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

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)botaoMenu:(id)sender{
    [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
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

- (void)navegacaoManeira:(UIViewController*)tela{
    [tela setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:tela animated:YES completion:nil];
}

#pragma table view methods
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    UITableViewCell *cell = [[UITableViewCell alloc] init];

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
    
    switch (indexPath.row) {
        case 0:{
            [self dismissViewControllerAnimated:YES completion:nil];
            
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
