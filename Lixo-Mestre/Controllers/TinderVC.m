//
//  TinderVC.m
//  LixeirasMenu
//
//  Created by Ezequiel Franca dos Santos on 16/09/14.
//  Copyright (c) 2014 Australian Broadcasting Corporation. All rights reserved.
//

#import "TinderVC.h"

@interface TinderVC () {
    DraggableView *draggableView;
    NSInteger index;
    NSMutableArray *loadedCards;
}
@end

@implementation TinderVC

//this makes it so only two cards are loaded at a time to
//avoid performance and memory costs


//all of the cards, not just what has been loaded
@synthesize allCards;


//CARREGA A PAGINA
- (void)viewDidLoad{
    [super viewDidLoad];


    [self performSelectorInBackground:@selector(loadCards) withObject:nil];
    // Do any additional setup after loading the view, typically from a nib.
}

//PRIMEIRO LOAD (CARREGA AS 3 PRIMEIRAS)
-(void)loadCards{
    NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
    NSString* usuario = [preferencias stringForKey: @"LoginApp"];
    NSDictionary *d = [webService carregarTinder: usuario];
    NSArray *a = (NSArray *)d;

    if (d){
        for (int i = 0 ; i < 3; i++) {
            NSDictionary *new = [a objectAtIndex: i];

            NSInteger coco = [[new objectForKey: @"id"] integerValue] ;
            NSLog(@"%ld", (long)coco);

            NSString *s = @"http://172.246.16.27/fotos/";

            NSString *url = [s stringByAppendingString: [new objectForKey: @"picture_path"]];


            NSURL *imageURL = [NSURL URLWithString: url];
            NSData *imageData = [NSData dataWithContentsOfURL: imageURL];
            UIImage *image = [UIImage imageWithData: imageData];

            [self.view insertSubview:[self createDraggableView : image : coco ] atIndex: i];
        }
    }
}

//CRIA A PARADINHA LOKA
-(DraggableView *)createDraggableView : (UIImage *) imagem : (NSInteger) idImg{
    draggableView = [[DraggableView alloc]initWithFrame:CGRectMake(60, 140, 200, 260)];
    draggableView.information.text = [allCards objectAtIndex:index]; //%%% placeholder for card-specific information

    draggableView.img.image = imagem;
    draggableView.idImg = idImg ;

    NSLog(@"%ld" , (long)draggableView.idImg);
    draggableView.delegate = self;
    return draggableView;
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tinderCarregaManeiro{
    //CARREGA O USUARIO PARA CONSULTA - LO NO BANCO DE DADOS;
    NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
    NSString* usuario = [preferencias stringForKey: @"LoginApp"];
    //WEB SERVICE Q RETORNA UMA IMAGEM SE ESTIVER DISPONIVEL;
    NSDictionary *d = [webService carregarUmaFotoTinder:usuario];
    //SE O RETORNAR CORRETAMENTE;
    if (d){
        //DICIONARIO PARA ARRAY PARA USAR OS INDEX;
        NSArray *a = (NSArray *)d;

        NSDictionary *new = [a objectAtIndex:0];

        NSInteger coco = [[new objectForKey: @"id"] integerValue] ;
        NSLog(@"%ld", (long)coco);

        NSString *s = @"http://172.246.16.27/fotos/";

        NSString *url = [s stringByAppendingString: [new objectForKey: @"picture_path"]];
        //CARREGA A IMAGEM NO FINAL DA FILA;
        NSURL *imageURL = [NSURL URLWithString: url];
        NSData *imageData = [NSData dataWithContentsOfURL: imageURL];
        UIImage *image = [UIImage imageWithData: imageData];

        [self.view insertSubview: [self createDraggableView : image : coco] atIndex: 0];
    }

}

//OCORRE DEPOIS DE QUITAR A GORDINHA
-(void)cardSwipedLeft:(UIView *)card;{
    [self performSelectorInBackground: @selector(tinderCarregaManeiro) withObject: nil];
    DraggableView *c = (DraggableView*)card;
    NSNumber *i = [NSNumber numberWithInt:0];
    NSNumber *j = [NSNumber numberWithInteger:c.idImg];

    NSArray *a = @[i, j];

    [self performSelectorInBackground: @selector(updateTinder:) withObject: a];

}

//OCORRE APOS ACEITAR A BONITINHA
-(void)cardSwipedRight:(UIView *)card{
    [self performSelectorInBackground: @selector(tinderCarregaManeiro) withObject: nil];
    DraggableView *c = (DraggableView*)card;
    NSNumber *i = [NSNumber numberWithInt: 1];
    NSNumber *j = [NSNumber numberWithInteger: c.idImg];

    NSArray *a = @[i, j];

    [self performSelectorInBackground:@selector(updateTinder:) withObject: a];
}

- (IBAction)botaoDislike:(id)sender {
//    [self performSelector:@selector(cardSwipedLeft:)
//               withObject: [[self.view subviews] lastObject]];
}

- (IBAction)botaoLike:(id)sender {
    /*
    [self performSelector:@selector(cardSwipedRight:)
               withObject: [[self.view subviews]  lastObject]];
     */
}

-(void)updateTinder : (NSArray*)parans{
    [webService updateTinder:[[parans objectAtIndex:0] integerValue]:[[parans objectAtIndex: 1] integerValue] ];
}
- (NSUInteger)supportedInterfaceOrientations{
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskPortrait;
    } else {
        return UIInterfaceOrientationMaskPortrait;
    }
}

@end
