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

@implementation ConfiguracoesVC{
    NSArray *itemsMenu;
}

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
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    preferencias = [NSUserDefaults standardUserDefaults];
    
    itemsMenu = [NSArray arrayWithObjects:@"Tutorial", @"Notificações", @"Sons",nil];

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
    
    
    cell.textLabel.text = [itemsMenu objectAtIndex:indexPath.row];
    cell.textLabel.font = [UIFont fontWithName: @"Santor" size: 19];
    cell.textLabel.textColor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha: 1.0];;
    
    UISwitch * switchManero = [[UISwitch alloc] initWithFrame:CGRectMake(200, 10, 0, 0)];
    
    [self setActionForSwitch: switchManero forIndex: indexPath.row];
    
    [cell addSubview: switchManero];
    
    
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(void)setActionForSwitch:(UISwitch*)sanduiche forIndex:(NSInteger)index{
    bool estado;
    
    switch (index) {
        //MUDAR OS METODOS PROS CERTOS QUANDO FAZER ELES!!!!!!
        case 0:
            estado = [preferencias boolForKey :@"Tutotial"];
            sanduiche.enabled = NO;
            [sanduiche addTarget: self action:@selector(toggleTutorial:) forControlEvents: UIControlEventAllTouchEvents ];
            break;
        case 1:
            estado = [preferencias boolForKey: @"Notificacoes"];
            sanduiche.enabled = NO;
            [sanduiche addTarget: self action:@selector(toggleNotificacoes:) forControlEvents: UIControlEventAllTouchEvents ];
            break;
        case 2:
            estado = [preferencias boolForKey: @"Sons"];
            sanduiche.enabled = YES;
            [sanduiche addTarget: self action:@selector(toggleSons:) forControlEvents: UIControlEventAllTouchEvents ];
            break;
        default:
            break;
    }
    
    sanduiche.selected = estado;
}

-(void)toggleTutorial:(id)sender{
    UISwitch * sanduiche = (UISwitch*)sender;
    bool estado = [preferencias boolForKey: @"Tutotial"];
    estado = !estado;
    
    sanduiche.selected = estado;
    [preferencias setBool: estado forKey: @"Tutorial"];
}

-(void)toggleNotificacoes:(id)sender{
    UISwitch * sanduiche = (UISwitch*)sender;
    bool estado = [preferencias boolForKey: @"Notificacoes"];
    estado = !estado;
    
    sanduiche.selected = estado;
    [preferencias setBool: estado forKey: @"Notificacoes"];
}

-(void)toggleSons:(id)sender{
    UISwitch * sanduiche = (UISwitch*)sender;
    bool estado = [preferencias boolForKey: @"Sons"];
    estado = !estado;
    
    sanduiche.selected = estado;
    [preferencias setBool: estado forKey: @"Sons"];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
