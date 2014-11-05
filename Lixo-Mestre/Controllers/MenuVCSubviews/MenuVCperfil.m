//
//  MenuVCperfil.m
//  Lixo-Mestre
//
//  Created by Alessandro Camillo Gimenez de Menezes on 29/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//

#import "MenuVCperfil.h"

@interface MenuVCperfil ()

@end

@implementation MenuVCperfil

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
    preferencias = [NSUserDefaults standardUserDefaults];

    //Deixar imagem redonda
    CGRect x = self.foto.bounds;
    self.foto.layer.cornerRadius = CGRectGetHeight(x) / 2;
    self.foto.layer.borderWidth = 1.0f;
    self.foto.layer.borderColor = [UIColor clearColor].CGColor;
    self.foto.clipsToBounds = YES;
    
    self.titulo.font = [UIFont fontWithName:@"Santor" size:20];
    self.nome.font = [UIFont fontWithName:@"Santor" size:17];

    self.labelPapel.font = [UIFont fontWithName:@"Santor" size:17];
    self.labelVidro.font = [UIFont fontWithName:@"Santor" size:17];
    self.labelPlastico.font = [UIFont fontWithName:@"Santor" size:17];
    self.labelMetal.font = [UIFont fontWithName:@"Santor" size:17];
    
    self.progressTitulo.font = [UIFont fontWithName:@"Santor" size:30];
    
    int total = [preferencias integerForKey:@"qteMetal"]+
    [preferencias integerForKey:@"qtePapel"]+
    [preferencias integerForKey:@"qteVidro"]+
    [preferencias integerForKey:@"qtePlastico"];
    self.viewDesenho.totalLixos = total;
    self.progresso.text = [NSString stringWithFormat:@"%d Lixos reciclados",total];
    self.progresso.font = [UIFont fontWithName:@"Santor" size:17];
    

}

-(void)viewWillAppear:(BOOL)animated{
    self.foto.image = [LocalData loadFacePicture];
    self.nome.text = [preferencias objectForKey:@"Nome"];
    
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

- (IBAction)convidar:(id)sender {
    
}

- (IBAction)unwindToPerfil:(UIStoryboardSegue *)unwindSegue{
    
}

//isso eh um metodo de view, nao de viewcontroller >.<
//so criando uma uiview custom (ViewProgresso)
//-(void)drawRect:(CGRect)rect{
//}


@end
