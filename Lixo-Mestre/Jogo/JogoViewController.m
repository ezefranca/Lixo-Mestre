//
//  JogoViewController.m
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 16/06/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "JogoViewController.h"
#import "MenuMG1.h"
#import "MyScene.h"
#import "GameOverMG1.h"
#import "webService.h"

@interface JogoViewController ()

@end

@implementation JogoViewController

- (void)loadView {
    SKView *skView = [[SKView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.view = skView;
}

- (void)viewDidLoad{
    [super viewDidLoad];
    self.usuario = [[NSString alloc] init];
    
    preferencias = [NSUserDefaults standardUserDefaults];
    
    self.qteMetal = (int)[preferencias integerForKey: @"qteMetal"];
    self.qtePapel = (int)[preferencias integerForKey: @"qtePapel"];
    self.qteVidro = (int)[preferencias integerForKey: @"qteVidro"];
    self.qtePlastico = (int)[preferencias integerForKey: @"qtePlastico"];
    self.maiorPontuacao = (int)[preferencias integerForKey: @"maiorPontuacao"] ;
    
    [self loadMenu];
    [self loadGameOver];
    
 }

- (void)loadMenu{
    //coisas do menu
    self.imgView= [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 320, 58) ];
    self.imgView.image = [UIImage imageNamed: @"tirinha.png"];
    [self.view addSubview: self.imgView];
    
    self.voltar = [[UIButton alloc] initWithFrame: CGRectMake(8, 34, 30, 30)];
    [self.voltar setBackgroundImage: [UIImage imageNamed: @"seta.png"] forState: UIControlStateNormal];
    [self.voltar addTarget: self action:@selector(voltarMenu) forControlEvents: UIControlEventTouchDown];
    [self.view addSubview: self.voltar];
    
    //-----todos os textos
    self.titulo = [[UILabel alloc] initWithFrame:CGRectMake(50, 34, 240, 29)];
    self.instrucao1 = [[UILabel alloc] initWithFrame:CGRectMake(25, 135, 270, 21)];
    self.instrucao2 = [[UILabel alloc] initWithFrame:CGRectMake(25, 159, 270, 21)];
    self.instrucao3 = [[UILabel alloc] initWithFrame:CGRectMake(25, 185, 270, 21)];
    self.lembrar = [[UILabel alloc] initWithFrame:CGRectMake(25, 227, 270, 41)];
    self.record = [[UILabel alloc] initWithFrame:CGRectMake(25, 493, 270, 29)];
    
    self.titulo.text = @"Separador de Lixo";
    self.instrucao1.text = @"O Lixo Papão adora reciclar!";
    self.instrucao2.text = @"Coloque o lixo na lixeira";
    self.instrucao3.text = @"correta e alimente-o.";
    self.lembrar.text = @"Lembre-se:";
    self.record.text = [NSString stringWithFormat: @"recorde: %d", self.maiorPontuacao];
    
    self.titulo.textAlignment = NSTextAlignmentLeft ;
    self.instrucao1.textAlignment = NSTextAlignmentCenter;
    self.instrucao2.textAlignment = NSTextAlignmentCenter;
    self.instrucao3.textAlignment = NSTextAlignmentCenter;
    self.lembrar.textAlignment = NSTextAlignmentLeft;
    self.record.textAlignment = NSTextAlignmentCenter;
    
    UIFont *fonte = [UIFont fontWithName: @"Santor" size:17];
    self.titulo.font = [UIFont fontWithName: @"Santor" size:20];
    self.instrucao1.font = fonte;
    self.instrucao2.font = fonte;
    self.instrucao3.font = fonte;
    self.lembrar.font = fonte;
    self.record.font = [UIFont fontWithName: @"Santor" size:19];
    
    UIColor * cor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha:1.0];
    self.titulo.textColor = [UIColor whiteColor];
    self.instrucao1.textColor = cor;
    self.instrucao2.textColor = cor;
    self.instrucao3.textColor = cor;
    self.lembrar.textColor = cor;
    self.record.textColor = cor;
    
    [self.view addSubview: self.titulo];
    [self.view addSubview: self.instrucao1];
    [self.view addSubview: self.instrucao2];
    [self.view addSubview: self.instrucao3];
    [self.view addSubview: self.lembrar];
    [self.view addSubview: self.record];
    //---------
    
    //botoes de dica ao usuario
    self.hintVidro = [[UIButton alloc] initWithFrame: CGRectMake(33, 275, 51, 51)];
    self.hintPapel = [[UIButton alloc] initWithFrame: CGRectMake(102, 275, 51, 51)];
    self.hintPlastico = [[UIButton alloc] initWithFrame: CGRectMake(172, 275, 51, 51)];
    self.hintMetal = [[UIButton alloc] initWithFrame: CGRectMake(238, 275, 51, 51)];
    
    [self.hintVidro setTitle: @"Vidro" forState: UIControlStateNormal];
    [self.hintPapel setTitle: @"Papel" forState: UIControlStateNormal];
    [self.hintPlastico setTitle: @"Plastico" forState: UIControlStateNormal];
    [self.hintMetal setTitle: @"Metal" forState:UIControlStateNormal];
    
    self.hintVidro.titleLabel.textColor = [UIColor whiteColor];
    self.hintPapel.titleLabel.textColor = [UIColor whiteColor];
    self.hintPlastico.titleLabel.textColor = [UIColor whiteColor];
    self.hintMetal.titleLabel.textColor =[UIColor whiteColor];
    
    self.hintVidro.titleLabel.font = fonte;
    self.hintPapel.titleLabel.font = fonte;
    self.hintPlastico.titleLabel.font = [UIFont fontWithName: @"Santor" size:14];
    self.hintMetal.titleLabel.font = fonte;
    
    self.hintVidro.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 116/255.0 blue: 60/255.0 alpha:1.0];
    self.hintPapel.backgroundColor = [UIColor colorWithRed: 57/255.0 green: 106/255.0 blue: 178/255.0 alpha:1.0];
    self.hintPlastico.backgroundColor = [UIColor colorWithRed: 220/255.0 green: 54/255.0 blue: 38/255.0 alpha:1.0];
    self.hintMetal.backgroundColor = [UIColor colorWithRed: 255/255.0 green: 207/255.0 blue: 4/255.0 alpha:1.0];
    
    [self.view addSubview: self.hintVidro];
    [self.view addSubview: self.hintPapel];
    [self.view addSubview: self.hintPlastico];
    [self.view addSubview: self.hintMetal];
    
    self.play = [[UIButton alloc] initWithFrame: CGRectMake(58, 383, 204, 39)];
    [self.play setBackgroundImage: [UIImage imageNamed: @"joguinho botão play.png"] forState:UIControlStateNormal];
    [self.play addTarget: self action: @selector(abreJoguinhoManeiro) forControlEvents:UIControlEventTouchDown];
    [self.view addSubview: self.play];
    
    [self showMenu];
}
- (void)showMenu{
    self.imgView.hidden = NO;
    self.voltar.hidden = NO;
    self.titulo.hidden = NO;
    self.instrucao1.hidden = NO;
    self.instrucao2.hidden = NO;
    self.instrucao3.hidden = NO;
    self.lembrar.hidden = NO;
    self.play.hidden = NO;
    self.record.hidden = NO;
    
    self.hintVidro.hidden = NO;
    self.hintPapel.hidden = NO;
    self.hintPlastico.hidden = NO;
    self.hintMetal.hidden = NO;
}
- (void)hideMenu{
    self.imgView.hidden = YES;
    self.voltar.hidden = YES;
    self.titulo.hidden = YES;
    self.instrucao1.hidden = YES;
    self.instrucao2.hidden = YES;
    self.instrucao3.hidden = YES;
    self.lembrar.hidden = YES;
    self.play.hidden = YES;
    self.record.hidden = YES;
    
    self.hintVidro.hidden = YES;
    self.hintPapel.hidden = YES;
    self.hintPlastico.hidden = YES;
    self.hintMetal.hidden = YES;
}

- (void)loadGameOver{
    self.deadLixo = [[UIImageView alloc] initWithFrame: CGRectMake(46, 43, 229, 149)];
    self.gg = [[UILabel alloc] initWithFrame: CGRectMake(19, 193, 282, 66)];
    self.pontosBg = [[UIImageView alloc] initWithFrame:CGRectMake(55, 283, 206, 91)];
    self.pontosDaUiltimaPartida = [[UILabel alloc] initWithFrame: CGRectMake(55, 290, 210, 49)];;
    self.jogarDenovo = [[UIButton alloc] initWithFrame:CGRectMake(60, 384, 201, 32)];
    self.quit = [[UIButton alloc] initWithFrame:CGRectMake(60, 431, 201, 34)];
    self.record2 = [[UILabel alloc] initWithFrame: CGRectMake(0, 486, 320, 37)];


    self.deadLixo.image = [UIImage imageNamed:@"TA DES MAI A DO.png"]; //sei la, pergunta pra polly
    self.pontosBg.image = [UIImage imageNamed: @"joguinho botão pontos.png"];
    
    self.gg.font = [UIFont fontWithName: @"Santor" size: 44.0];
    self.pontosDaUiltimaPartida.font = [UIFont fontWithName: @"Santor" size: 44.0];
    self.jogarDenovo.titleLabel.font = [UIFont fontWithName: @"Santor" size: 25.0];
    self.quit.titleLabel.font = [UIFont fontWithName: @"Santor" size:25.0];
    self.record2.font = [UIFont fontWithName: @"Santor" size:20.0 ];


    self.gg.text = @"GAME OVER!";
    self.pontosDaUiltimaPartida.text = @"ioioio";
    [self.jogarDenovo setTitle: @"jogar novamente" forState: UIControlStateNormal];
    [self.quit setTitle: @"voltar" forState: UIControlStateNormal];
    self.record2.text = [NSString stringWithFormat: @"recorde: %d", self.maiorPontuacao];
    
    self.gg.textColor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha: 1.0];
    self.pontosDaUiltimaPartida.textColor = [UIColor whiteColor];
    self.jogarDenovo.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha: 1.0];
    self.quit.backgroundColor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha: 1.0];
    self.record2.textColor = [UIColor colorWithRed: 0/255.0 green: 127/255.0 blue: 177/255.0 alpha: 1.0];
;
    
    self.pontosDaUiltimaPartida.textAlignment = NSTextAlignmentCenter;
    self.record2.textAlignment = NSTextAlignmentCenter;
    
    [self.jogarDenovo addTarget:self action: @selector(abreJoguinhoManeiro) forControlEvents:UIControlEventTouchDown];
    [self.quit addTarget: self action: @selector(abreMenuManeiro) forControlEvents:UIControlEventTouchDown];
    
    
    [self.view addSubview: self.deadLixo];
    [self.view addSubview: self.gg];
    [self.view addSubview: self.pontosBg];
    [self.view addSubview: self.pontosDaUiltimaPartida];
    [self.view addSubview: self.jogarDenovo];
    [self.view addSubview: self.quit];
    [self.view addSubview: self.record2];
    
    [self hideGameOver];
}
- (void)showGameOver{
    self.deadLixo.hidden = NO;
    self.gg.hidden = NO;
    self.pontosBg.hidden = NO;
    self.pontosDaUiltimaPartida.hidden = NO;
    self.jogarDenovo.hidden = NO;
    self.quit.hidden = NO;
    self.record2.hidden = NO;
    
}
- (void)hideGameOver{
    self.deadLixo.hidden = YES;
    self.gg.hidden = YES;
    self.pontosBg.hidden = YES;
    self.pontosDaUiltimaPartida.hidden = YES;
    self.jogarDenovo.hidden = YES;
    self.quit.hidden = YES;
    self.record2.hidden = YES;
}


- (void)viewWillAppear:(BOOL)animated{
    [self performSelector: @selector(abreMenuManeiro) withObject: nil afterDelay: 0.05];
}

- (void)viewDidAppear:(BOOL)animated{
}

- (void)viewWillDisappear:(BOOL)animated{
}

- (void)viewDidDisappear:(BOOL)animated{
    [preferencias synchronize];
}

- (void)updatePontos{
    [preferencias setInteger:[self qteMetal] forKey:@"qteMetal"];
    [preferencias setInteger:[self qtePapel] forKey:@"qtePapel"];
    [preferencias setInteger:[self qteVidro] forKey:@"qteVidro"];
    [preferencias setInteger:[self qtePlastico] forKey:@"qtePlastico"];
    [preferencias setInteger:[self maiorPontuacao] forKey:@"maiorPontuacao"];
    
    if ([preferencias synchronize]) {
        NSString* qtemetal = [NSString stringWithFormat:@"%d",
                              (int)[preferencias integerForKey:@"qteMetal"]];
        NSString *qtepapel = [NSString stringWithFormat:@"%d",
                              (int)[preferencias integerForKey:@"qtePapel"]];
        NSString *qtevidro = [NSString stringWithFormat:@"%d",
                              (int)[preferencias integerForKey:@"qteVidro"]];
        NSString *qteplastico = [NSString stringWithFormat:@"%d",
                                 (int)[preferencias integerForKey:@"qtePlastico"]];
        NSString *pontos = [NSString stringWithFormat:@"%d",
                            (int)[preferencias integerForKey:@"maiorPontuacao"]];
        
        [webService salvaPontosJoguinho:[preferencias objectForKey: @"userName"] Papel: qtepapel Vidro: qtevidro Plastico: qteplastico Metal: qtemetal Pontuacao: pontos];
    }
    [preferencias synchronize];
}


- (void)voltarMenu{
    [self dismissViewControllerAnimated: YES completion: nil];
}

- (void)jogoTerminouDesistencia{
    [self performSelectorInBackground: @selector(updatePontos) withObject: nil];
    
    self.record.text = [NSString stringWithFormat: @"recorde: %d", self.maiorPontuacao];
    self.record2.text = self.record.text;
    
    [self abreMenuManeiro];
}

- (void)morreuNoJogo{
    [self performSelectorInBackground: @selector(updatePontos) withObject: nil];
    
    [self hideMenu];
    [self showGameOver];
    
    SKView * skView = (SKView *)self.view;
    
    GameOverMG1 * scene = [GameOverMG1 sceneWithSize: skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene: scene];
    
    
}


- (void)abreMenuManeiro{
    [self showMenu];
    [self hideGameOver];
    SKView * skView = (SKView *)self.view;
    
    MenuMG1 * scene = [MenuMG1 sceneWithSize: skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    [skView presentScene: scene];
}

- (void)abreJoguinhoManeiro{
    [self hideMenu];
    [self hideGameOver];
    SKView * skView = (SKView *)self.view;
    
    MyScene * scene = [MyScene sceneWithSize: skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    scene.lixos = [[NSMutableArray alloc] init];
    
    [skView presentScene: scene transition: [SKTransition fadeWithColor: [UIColor whiteColor] duration:0.5]];
}




- (void)navegacaoManeira:(UIViewController*)tela{
    [self presentViewController:tela animated:YES completion:nil];
}

/**
 *  metodo para criar singleton deste ViewController
 *
 *  @return o priprio singleton
 */
+ (JogoViewController *)sharedJogoViewController{
    static JogoViewController *sharedJogoViewController = nil;
    if (!sharedJogoViewController){
        sharedJogoViewController = [[super allocWithZone:nil]init];
    }
    return sharedJogoViewController;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedJogoViewController];
}


- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    }
    else
    {
        return UIInterfaceOrientationMaskPortrait;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}


@end