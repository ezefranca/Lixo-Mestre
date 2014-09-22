//
//  RankingVC.m
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import "RankingVC.h"
#import "JogoViewController.h"
#import "webService.h"

@interface RankingVC ()

@end

@implementation RankingVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        [[self tela1] setHidden:NO];
      //  [[self tela2] setHidden:YES];
        [[self tela3] setHidden:YES];
        for ( UIButton *botao in [[self tela3] subviews]){
            botao.titleLabel.lineBreakMode = NSLineBreakByWordWrapping;
            [botao.titleLabel setTextAlignment:NSTextAlignmentCenter];
        }
    }
    return self;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    preferencias = [NSUserDefaults standardUserDefaults];
    
    [self inicializarManero];
}

- (void)viewWillAppear:(BOOL)animated{
    //muda o progress de todos para 0 para acontecer a animacao do viewdidapepar
    [[self papel]setProgress:0];
    [[self plastico]setProgress:0];
    [[self vidro]setProgress:0];
    [[self metal]setProgress:0];
    [[self pontos]setProgress:0];
}

-(void)viewDidAppear:(BOOL)animated{
    //coloca os valores nas progressview
    CGFloat npapel = [preferencias integerForKey:@"qtePapel"];
    CGFloat nplastico = [preferencias integerForKey:@"qtePlastico"];
    CGFloat nvidro = [preferencias integerForKey:@"qteVidro"] ;
    CGFloat nmetal = [preferencias integerForKey:@"qtePapel"] ;
    CGFloat npontos = [preferencias integerForKey:@"maiorPontuacao"];
    //NSLog(@"%0.2f %0.2f %0.2f %0.2f",npapel, nplastico, nvidro, nmetal);
    
    [[self labelPapelProgress] setText: [NSString stringWithFormat:@"%0.0f/50", npapel]];
    [[self labelPlasticoProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nplastico]];
    [[self labelVidroProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nvidro]];
    [[self labelMetalProgress] setText: [NSString stringWithFormat:@"%0.0f/50", nmetal]];
    [[self labelPontosProgress] setText: [NSString stringWithFormat:@"%0.0f/5000", npontos]];
    
    [[self papel] setProgress: npapel/50.0 animated:YES];
    [[self plastico] setProgress: nplastico/50.0 animated:YES];
    [[self vidro] setProgress: nvidro/50.0 animated:YES];
    [[self metal] setProgress: nmetal/50.0 animated:YES];
    [[self pontos] setProgress: npontos/5000.0 animated:YES];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)navegacaoManeira:(UIViewController*)tela{
    [tela setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:tela animated:YES completion:nil];
}

- (IBAction)botaoCompartilhar:(id)sender {
    NSString *texto = @"Estou utilizando o Lixo Papão";
    NSURL *url = [NSURL URLWithString:@"http://www.lixopapao.com.br/"];
    UIImage *image = [UIImage imageNamed:@"logo"];
    
    UIActivityViewController *controller =
    [[UIActivityViewController alloc]
     initWithActivityItems:@[texto, url, image]
     applicationActivities:nil];
    
    controller.excludedActivityTypes = @[UIActivityTypePostToWeibo,
                                         UIActivityTypeMessage,
                                         UIActivityTypePrint,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAddToReadingList,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToTencentWeibo,
                                         UIActivityTypeAirDrop];
    
    [self presentViewController:controller animated:YES completion:nil];
}

- (IBAction)botaoJogo1:(id)sender {
    JogoViewController *jogo = JogoViewController.new;
    [self navegacaoManeira:jogo];
}


- (IBAction)actionBotaoPontos:(id)sender {
    [[self tela1] setHidden:NO];
    //[[self tela2] setHidden:YES];
    [[self tela3] setHidden:YES];
}

- (IBAction)actionBotaoBadges:(id)sender {
    [[self tela1] setHidden:YES];
   // [[self tela2] setHidden:NO];
    [[self tela3] setHidden:YES];
}

- (IBAction)actionBotaoJogos:(id)sender {
    [[self tela1] setHidden:YES];
  //  [[self tela2] setHidden:YES];
    [[self tela3] setHidden:NO];
}

#pragma mark coisitas da progressview
- (void)inicializarManero{
    CGAffineTransform trans = CGAffineTransformMakeScale(1.0f, 10.0f);
    //rgb(41, 128, 185) da cor tema do app
    UIColor *progressColour = [UIColor colorWithRed:41/255.0 green:128/255.0 blue:185/255.0 alpha:1.0];
    
    //progressview e label da qte de papel
    CGRect tamanhoPapel = CGRectMake(10, 39, 280, 25);
    [self setLabelPapelProgress: [[UILabel alloc] initWithFrame: tamanhoPapel]];
    [[self labelPapelProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPapelProgress] setFont: [[self labelPapel] font]];
    
    tamanhoPapel.origin.y = tamanhoPapel.origin.y + 12;
    [self setPapel: [[UIProgressView alloc] initWithFrame: tamanhoPapel] ];
    [[self papel] setProgressTintColor: progressColour];
    [[self papel] setProgressViewStyle: UIProgressViewStyleDefault];
    [self papel].transform = trans;
    self.papel.layer.cornerRadius = 10;
    self.papel.layer.masksToBounds = YES;
    self.papel.layer.borderWidth = 0;
    [[self tela1] addSubview: [self papel]];
    [[self tela1] addSubview: [self labelPapelProgress]];
    
    //progressview e label da qte de plastico
    CGRect tamanhoPlastico = CGRectMake(10, 109, 280, 25);
    [self setLabelPlasticoProgress: [[UILabel alloc] initWithFrame: tamanhoPlastico]];
    [[self labelPlasticoProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPlasticoProgress] setFont: [[self labelPapel] font]];
    
    tamanhoPlastico.origin.y = tamanhoPlastico.origin.y +12;
    [self setPlastico: [[UIProgressView alloc] initWithFrame: tamanhoPlastico] ];
    [[self plastico] setProgressTintColor: progressColour];
    [[self plastico] setProgressViewStyle: UIProgressViewStyleDefault];
    [self plastico].transform = trans;
    self.plastico.layer.cornerRadius = 10;
    self.plastico.layer.masksToBounds = YES;
    self.plastico.layer.borderWidth = 0;
    [[self tela1] addSubview: [self plastico]];
    [[self tela1] addSubview: [self labelPlasticoProgress]];
    
    
    //progressview e label da qte de vidro
    CGRect tamanhoVidro = CGRectMake(10, 179, 280, 25);
    [self setLabelVidroProgress: [[UILabel alloc] initWithFrame: tamanhoVidro]];
    [[self labelVidroProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelVidroProgress] setFont: [[self labelPapel] font]];
    
    tamanhoVidro.origin.y = tamanhoVidro.origin.y +12;
    [self setVidro: [[UIProgressView alloc] initWithFrame:tamanhoVidro] ];
    [[self vidro] setProgressTintColor: progressColour];
    [[self vidro] setProgressViewStyle: UIProgressViewStyleDefault];
    [self vidro].transform = trans;
    self.vidro.layer.cornerRadius = 10;
    self.vidro.layer.masksToBounds = YES;
    self.vidro.layer.borderWidth = 0;
    [[self tela1] addSubview: [self vidro]];
    [[self tela1] addSubview: [self labelVidroProgress]];
    
    
    //progressview e label da qte de metal
    CGRect tamanhoMetal = CGRectMake(10, 249, 280, 25);
    [self setLabelMetalProgress: [[UILabel alloc] initWithFrame: tamanhoMetal]];
    [[self labelMetalProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelMetalProgress] setFont: [[self labelPapel] font]];
    
    tamanhoMetal.origin.y = tamanhoMetal.origin.y +12;
    [self setMetal: [[UIProgressView alloc] initWithFrame:tamanhoMetal] ];
    [[self metal] setProgressTintColor: progressColour];
    [[self metal] setProgressViewStyle: UIProgressViewStyleDefault];
    [self metal].transform = trans;
    self.metal.layer.cornerRadius = 10;
    self.metal.layer.masksToBounds = YES;
    self.metal.layer.borderWidth = 0;
    [[self tela1] addSubview: [self metal]];
    [[self tela1] addSubview: [self labelMetalProgress]];
    
    
    //progressview e label da qte de pontos
    CGRect tamanhoPontos = CGRectMake(10, 318, 280, 25);
    [self setLabelPontosProgress: [[UILabel alloc] initWithFrame: tamanhoPontos]];
    [[self labelPontosProgress] setTextAlignment: NSTextAlignmentCenter];
    [[self labelPontosProgress] setFont: [[self labelPapel] font]];
    
    tamanhoPontos.origin.y = tamanhoPontos.origin.y +12;
    [self setPontos: [[UIProgressView alloc] initWithFrame: tamanhoPontos] ];
    [[self pontos] setProgressTintColor: progressColour];
    [[self pontos] setProgressViewStyle: UIProgressViewStyleDefault];
    [self pontos].transform = trans;
    self.pontos.layer.cornerRadius = 10;
    self.pontos.layer.masksToBounds = YES;
    self.pontos.layer.borderWidth = 0;
    [[self tela1] addSubview: [self pontos]];
    [[self tela1] addSubview: [self labelPontosProgress]];
}

- (IBAction)botaoMenu:(id)sender {
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

@end
