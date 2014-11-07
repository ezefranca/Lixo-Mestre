//
//  RecompensasViewController.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 06/11/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "RecompensasViewController.h"

@interface RecompensasViewController ()

@end

@implementation RecompensasViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cellItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier];
    }
    
    switch (indexPath.row) {
            
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
       
    }
}



#pragma mark coisitas da progressview
- (void)inicializarManero{
    CGAffineTransform trans = CGAffineTransformMakeScale(1.0f, 10.0f);
    //rgb(41, 128, 185) da cor tema do app
    UIColor *progressColour = [UIColor colorWithRed:41/255.0 green:128/255.0 blue:185/255.0 alpha:1.0];
    
    //progressview e label da qte de papel
    CGRect tamanhoPapel = CGRectMake(10, 59, 280, 25);
    [self setLabelPapelProgress: [[UILabel alloc] initWithFrame: tamanhoPapel]];
    [[self labelPapelProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPapelProgress] setFont: [UIFont fontWithName:@"Santor" size:17]];
    
    tamanhoPapel.origin.y = tamanhoPapel.origin.y + 12;
    [self setPapel: [[UIProgressView alloc] initWithFrame: tamanhoPapel] ];
    [[self papel] setProgressTintColor: progressColour];
    [[self papel] setProgressViewStyle: UIProgressViewStyleDefault];
    [self papel].transform = trans;
    self.papel.layer.cornerRadius = 10;
    self.papel.layer.masksToBounds = YES;
    self.papel.layer.borderWidth = 0;
    [self.view addSubview: [self papel]];
    [self.view addSubview: [self labelPapelProgress]];
    
    //progressview e label da qte de plastico
    CGRect tamanhoPlastico = CGRectMake(10, 129, 280, 25);
    [self setLabelPlasticoProgress: [[UILabel alloc] initWithFrame: tamanhoPlastico]];
    [[self labelPlasticoProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPlasticoProgress] setFont: [UIFont fontWithName:@"Santor" size:17]];
    
    tamanhoPlastico.origin.y = tamanhoPlastico.origin.y +12;
    [self setPlastico: [[UIProgressView alloc] initWithFrame: tamanhoPlastico] ];
    [[self plastico] setProgressTintColor: progressColour];
    [[self plastico] setProgressViewStyle: UIProgressViewStyleDefault];
    [self plastico].transform = trans;
    self.plastico.layer.cornerRadius = 10;
    self.plastico.layer.masksToBounds = YES;
    self.plastico.layer.borderWidth = 0;
    [self.view addSubview: [self plastico]];
    [self.view addSubview: [self labelPlasticoProgress]];
    
    
    //progressview e label da qte de vidro
    CGRect tamanhoVidro = CGRectMake(10, 199, 280, 25);
    [self setLabelVidroProgress: [[UILabel alloc] initWithFrame: tamanhoVidro]];
    [[self labelVidroProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelVidroProgress] setFont: [UIFont fontWithName:@"Santor" size:17]];
    
    tamanhoVidro.origin.y = tamanhoVidro.origin.y +12;
    [self setVidro: [[UIProgressView alloc] initWithFrame:CGRectMake(10, 211, 280, 25)] ];
    [[self vidro] setProgressTintColor: progressColour];
    [[self vidro] setProgressViewStyle: UIProgressViewStyleDefault];
    [self vidro].transform = trans;
    self.vidro.layer.cornerRadius = 10;
    self.vidro.layer.masksToBounds = YES;
    self.vidro.layer.borderWidth = 0;
    [self.view addSubview: [self vidro]];
    [self.view addSubview: [self labelVidroProgress]];
    
    
    //progressview e label da qte de metal
    CGRect tamanhoMetal = CGRectMake(10, 269, 280, 25);
    [self setLabelMetalProgress: [[UILabel alloc] initWithFrame: tamanhoMetal]];
    [[self labelMetalProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelMetalProgress] setFont: [UIFont fontWithName:@"Santor" size:17]];
    
    tamanhoMetal.origin.y = tamanhoMetal.origin.y +12;
    [self setMetal: [[UIProgressView alloc] initWithFrame:tamanhoMetal] ];
    [[self metal] setProgressTintColor: progressColour];
    [[self metal] setProgressViewStyle: UIProgressViewStyleDefault];
    [self metal].transform = trans;
    self.metal.layer.cornerRadius = 10;
    self.metal.layer.masksToBounds = YES;
    self.metal.layer.borderWidth = 0;
    [self.view addSubview: [self metal]];
    [self.view addSubview: [self labelMetalProgress]];
    
    
    //progressview e label da qte de pontos
    CGRect tamanhoPontos = CGRectMake(10, 338, 280, 25);
    [self setLabelPontosProgress: [[UILabel alloc] initWithFrame: tamanhoPontos]];
    [[self labelPontosProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPontosProgress] setFont: [UIFont fontWithName:@"Santor" size:17]];
    
    tamanhoPontos.origin.y = tamanhoPontos.origin.y +12;
    [self setPontos: [[UIProgressView alloc] initWithFrame: tamanhoPontos] ];
    [[self pontos] setProgressTintColor: progressColour];
    [[self pontos] setProgressViewStyle: UIProgressViewStyleDefault];
    [self pontos].transform = trans;
    self.pontos.layer.cornerRadius = 10;
    self.pontos.layer.masksToBounds = YES;
    self.pontos.layer.borderWidth = 0;
    [self.view addSubview: [self pontos]];
    [self.view addSubview: [self labelPontosProgress]];
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
