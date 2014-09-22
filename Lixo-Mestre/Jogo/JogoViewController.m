//
//  JogoViewController.m
//  jogo-lixo
//
//  Created by Alessandro Camillo Gimenez de Menezes on 16/06/14.
//  Copyright (c) 2014 Alessandro Camillo Gimenez de Menezes. All rights reserved.
//

#import "JogoViewController.h"
#import "MyScene.h"
#import "RankingProvPontos.h"
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
    [self setUsuario: [[NSString alloc] init]];
    
    preferencias = [NSUserDefaults standardUserDefaults];
    
    [self setQteMetal: [preferencias integerForKey:@"qteMetal"]];
    [self setQtePapel: [preferencias integerForKey:@"qtePapel"]];
    [self setQteVidro: [preferencias integerForKey:@"qteVidro"]];
    [self setQtePlastico: [preferencias integerForKey:@"qtePlastico"]];
    [self setMaiorPontuacao: [preferencias integerForKey:@"maiorPontuacao"] ];
    
    CGSize tamanho = self.view.frame.size;
    [self setBotaoDerp: [[UIButton alloc] initWithFrame:CGRectMake(tamanho.width/2 -50,tamanho.height/2 -25, 100, 50)]];
    [[self botaoDerp] addTarget:self action:@selector(abreJoguinhoManeiro) forControlEvents: UIControlEventTouchUpInside];
    [[self botaoDerp] setTitle:@" " forState:UIControlStateNormal];
    
    [self.view addSubview: [self botaoDerp]];
    
    [self setBotaoVoltar: [[UIButton alloc] initWithFrame:CGRectMake(20, 20, 46, 30)]];
    [[self botaoVoltar] addTarget:self action:@selector(voltarMenu) forControlEvents: UIControlEventTouchUpInside];
    [[self botaoVoltar] setTitle:@"Voltar" forState:UIControlStateNormal];
    
    [self.view addSubview: [self botaoVoltar]];
}

-(void)viewWillAppear:(BOOL)animated{
    [self performSelector:@selector(abreJoguinhoManeiro) withObject:nil afterDelay:0.05];
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [preferencias setInteger:[self qteMetal] forKey:@"qteMetal"];
    [preferencias setInteger:[self qtePapel] forKey:@"qtePapel"];
    [preferencias setInteger:[self qteVidro] forKey:@"qteVidro"];
    [preferencias setInteger:[self qtePlastico] forKey:@"qtePlastico"];
    [preferencias setInteger:[self maiorPontuacao] forKey:@"maiorPontuacao"];
    if ([preferencias synchronize]) {
        NSString* qtemetal = [NSString stringWithFormat:@"%d", [preferencias integerForKey:@"qteMetal"]];
        NSString *qtepapel = [NSString stringWithFormat:@"%d", [preferencias integerForKey:@"qtePapel"]];
        NSString *qtevidro = [NSString stringWithFormat:@"%d", [preferencias integerForKey:@"qteVidro"]];
        NSString *qteplastico = [NSString stringWithFormat:@"%d", [preferencias integerForKey:@"qtePlastico"]];
        NSString *pontos = [NSString stringWithFormat:@"%d", [preferencias integerForKey:@"maiorPontuacao"]];
        [webService salvaPontosJoguinho:[preferencias objectForKey:@"userName"] Papel:qtepapel Vidro:qtevidro Plastico:qteplastico Metal:qtemetal Pontuacao:pontos];
    }
}

-(void)viewDidDisappear:(BOOL)animated{
    [preferencias synchronize];
}

-(void )viewDidAppear:(BOOL)animated{
    
}

- (BOOL)shouldAutorotate{
    return NO;
}

/**
 *  faz exatamente o que o nome diz, volta ao menu
 */
-(void)voltarMenu{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)navegacaoManeira:(UIViewController*)tela{
    [self presentViewController:tela animated:YES completion:nil];
}

/**
 *  faz exatamente o que o nome diz
 */
-(void)abreJoguinhoManeiro{
    SKView * skView = (SKView *)self.view;
   // skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    SKScene * scene = [MyScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    // Present the scene.
    [skView presentScene:scene];
    [self jogoEmAndamento];
}

/**
 *  quando o jogo comecar a rodar, esconde os elementos da view neste metodo para que eles nao fiquem ativos dirante o jogo
 */
-(void)jogoEmAndamento{
    [self botaoDerp].alpha = 0.0;
}

/**
 *  quando o jogo terminar, mostra novamente os elementos da view.
 *  este metodo teve ter o cabecalho no .h para que seja visivel no singleton
 */
-(void)jogoTerminou{
    [self botaoDerp].alpha = 1.0;
    [self performSelector:@selector(voltarMenu)];
}

- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    }
    else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

/**
 *  metodo para criar singleton deste ViewController
 *
 *  @return o priprio singleton
 */
+(JogoViewController *)sharedJogoViewController{
    static JogoViewController *sharedJogoViewController = nil;
    if (!sharedJogoViewController){
        sharedJogoViewController = [[super allocWithZone:nil]init];
    }
    return sharedJogoViewController;
}

+ (id)allocWithZone:(struct _NSZone *)zone{
    return [self sharedJogoViewController];
}


@end