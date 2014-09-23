//
//  HomeViewController.m
//  Lixo-Papao-Storyboard
//
//  Created by Ezequiel Franca dos Santos on 10/09/14.
//  Copyright (c) 2014 Ezequiel Franca dos Santos. All rights reserved.
//


#import "BluetoothVC.h"
#import "AppDelegate.h"



@interface BluetoothVC ()

@end

@implementation BluetoothVC



- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.logado = [preferencias boolForKey:@"Logado"];
    self.conectado = FALSE;
    self.botaoLixo.hidden = TRUE;
    self.botaoConectar.hidden = FALSE;
    //self.statusLbl.text = @"Desconectado";
    [[CNBluetoothCentral sharedBluetoothCentral] setDelegate:self];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidAppearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDWillDisappearNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(handleNotification:)
                                                 name:SVProgressHUDDidDisappearNotification
                                               object:nil];
    
    //    (void)setBackgroundColor:(UIColor*)color; // default is [UIColor whiteColor]
    //    + (void)setForegroundColor:(UIColor*)color; // default is [UIColor blackColor]
    //    + (void)setRingThickness:(CGFloat)width; // default is 4 pt
    //    + (void)setFont:(UIFont*)font; // default is [UIFont preferredFontForTextStyle:UIFontTextStyleSubheadline]
    //    + (void)setSuccessImage:(UIImage*)image; // default is bundled success image from Glyphish
    //    + (void)setErrorImage:(UIImage*)image; // default is bundled error image from Glyphish
    
    [SVProgressHUD setBackgroundColor:rgb(0, 0, 0)];
    [SVProgressHUD setForegroundColor:rgb(255, 255, 255)];
    [SVProgressHUD setRingThickness:6];
    
    
}

- (void)handleNotification:(NSNotification *)notif{
    NSLog(@"Notification recieved: %@", notif.name);
    NSLog(@"Status user info key: %@", [notif.userInfo objectForKey:SVProgressHUDStatusUserInfoKey]);
}

- (void)viewDidLoad{
    [super viewDidLoad];
//    UISwipeGestureRecognizer *left = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(leftGesture)];
//    left.direction = UISwipeGestureRecognizerDirectionLeft;
//    [[self view] addGestureRecognizer:left];
//    
//    UISwipeGestureRecognizer *right = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(rightGesture)];
//    right.direction = UISwipeGestureRecognizerDirectionRight;
//    [[self view] addGestureRecognizer:right];
    
    [self.view setUserInteractionEnabled:YES];
}


- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [SVProgressHUD dismiss];
    [[CNBluetoothCentral sharedBluetoothCentral] cleanup];
    [[CNBluetoothCentral sharedBluetoothCentral] setDelegate:nil];
    [imagemConectar setImage:[UIImage imageNamed:@"bixos papoes-01.png"]];
}
-(void)viewDidAppear:(BOOL)animated{
    [SVProgressHUD dismiss];
}

- (IBAction)botaoConectar:(id)sender {
   // [self.statusLbl.text isEqualToString:@"Conectando..."];
    if ([self logado]) {
        [[CNBluetoothCentral sharedBluetoothCentral] startCentral];
        [SVProgressHUD showWithStatus:@"Conectando... aguarde"];
        
    }
    else{
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle: @"Você precisa estar logado para conectar-se." message:@"Vá ao perfil no menu na lateral e conecte-se!" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        alert.alertViewStyle = UIAlertViewStyleDefault;
        [alert show];
    }

}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    [SVProgressHUD dismiss];
}

#pragma mark CNBlueToothCentralDelegate
- (void)scanStarted {
    //self.statusLbl.text = @"Procurando...";
}

- (void)centralDidNotStart:(NSString *)errorString {
    //UIAlert to warn about this error
    //self.statusLbl.text = [NSString stringWithFormat:@"Erro: - %@", errorString];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Erro" message: errorString delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
    alert.alertViewStyle = UIAlertViewStyleDefault;
    [alert show];
    
}

- (void)centralConnectedwithPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error {
    //Alert user that peripheral connected successfully
   // self.statusLbl.text = @"Conectado";
    self.botaoLixo.hidden = FALSE;
    self.botaoConectar.hidden = TRUE;
    [SVProgressHUD showSuccessWithStatus:@"Conectado com Successo!"];
    [imagemConectar setImage:[UIImage imageNamed:@"bixos papoes-02.png"]];
    [self setConectado:TRUE];
}

- (void)centralDisconnectwithPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error {
   // self.statusLbl.text = @"Desconectado";
    self.botaoLixo.hidden = TRUE;
    self.botaoConectar.hidden = FALSE;
    [imagemConectar setImage:[UIImage imageNamed:@"desconectar"]];
}

- (void)centralReadCharacteristic:(CBCharacteristic *)characteristic withPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error {
    NSUInteger i;
    NSMutableString *str;
    
    //Append the received string into the bottom text view
    NSMutableString *temp = [[NSMutableString alloc] initWithData:characteristic.value encoding:NSUTF8StringEncoding];
    // Show it on log
    NSLog(@"%@", temp);
    // Ignora os caracteres nulos "\0"
    for (i = 0 ; i < temp.length ; i++){
        if ([temp characterAtIndex:i] != '\0'){
            // Constroe a nova string
            if(i == 0)
                str = [NSMutableString stringWithFormat:@"%C",[temp characterAtIndex:i]];
            else{
                str = [NSMutableString stringWithFormat:@"%@%C", str, [temp characterAtIndex:i]];
            }
        }
    }
    // Display the single-character string
    // Reset used variables
    temp = (NSMutableString *)@"";
    str = (NSMutableString *)@"";
}

- (void)centralWroteCharacteristic:(CBCharacteristic *)characteristic withPeripheral:(CBPeripheral *)peripheral withError:(NSError *)error {
    //UIAlert confirm to user that BLE send was successful (optional)
}

-(void)enviarLixo{
    //Metodo de enviar
    NSString *enviar = @"$";
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senha"];
    enviar = [enviar stringByAppendingString:[preferencias stringForKey:@"userName"]];
    switch ([self tipo]) {
        case 1://papel
            enviar = [enviar stringByAppendingString:@"$1"];
            break;
        case 2://plastico
            enviar = [enviar stringByAppendingString:@"$2"];
            break;
        case 3://metal
            enviar = [enviar stringByAppendingString:@"$3"];
            break;
        case 4://vidro
            enviar = [enviar stringByAppendingString:@"$4"];
            break;
        default:
            return;
            break;
    }
    [self enviarDadosBluetooth:enviar];
}

- (IBAction)botaoPapel:(id)sender{
    //Metodo de enviar
    NSString *enviar = @"$";
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senha"];
    enviar = [enviar stringByAppendingString:[preferencias stringForKey:@"userName"]];
    enviar = [enviar stringByAppendingString:@"$1"];
    [self enviarDadosBluetooth:enviar];
}

- (IBAction)botaoPlastico:(id)sender{
    //Metodo de enviar
    NSString *enviar = @"$";
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senha"];
    enviar = [enviar stringByAppendingString:[preferencias stringForKey:@"userName"]];
    enviar = [enviar stringByAppendingString:@"$2"];
    [self enviarDadosBluetooth:enviar];
}

- (IBAction)botaoMetal:(id)sender{
    //Metodo de enviar
    NSString *enviar = @"$";
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senha"];
    enviar = [enviar stringByAppendingString:[preferencias stringForKey:@"userName"]];
    enviar = [enviar stringByAppendingString:@"$3"];
    [self enviarDadosBluetooth:enviar];
}

- (IBAction)botaoVidro:(id)sender{
    //Metodo de enviar
    NSString *enviar = @"$";
    preferencias = [NSUserDefaults standardUserDefaults];
    senhaSalva = [preferencias boolForKey:@"senha"];
    enviar = [enviar stringByAppendingString:[preferencias stringForKey:@"userName"]];
    enviar = [enviar stringByAppendingString:@"$4"];
    [self enviarDadosBluetooth:enviar];
}

- (void)enviarDadosBluetooth:(NSString *)tipoLixo{
    
    NSUInteger i;
    NSMutableString *str;
    NSString *temp;
    
    NSLog(@"Enviar");
    
    if ([[CNBluetoothCentral sharedBluetoothCentral] isConnected]) {
        
        // Get the string entered by the user
        temp = tipoLixo;
        
        // Ignora os caracteres nulos "\0"
        for (i = 0 ; i < temp.length ; i++){
            if ([temp characterAtIndex:i] != '\0'){
                // Constroe a nova string
                if(i == 0)
                    str = [NSMutableString stringWithFormat:@"%C",[temp characterAtIndex:i]];
                else{
                    str = [NSMutableString stringWithFormat:@"%@%C", str, [temp characterAtIndex:i]];
                }
            }
        }
        // Teste de envio
        //        str = [NSMutableString stringWithFormat:@"%@", @"$1988$0004"];
        NSLog(@"%@", temp);
        [[CNBluetoothCentral sharedBluetoothCentral] sendDataWithoutResponse:temp];
        
        // Resetar as variaveis usadas
        temp = (NSString *)@"";
        str = (NSMutableString *)@"";
        
    }
    else{
        //UIAlert user that we are not connected or no characters were entered
    }
    
}

//-(void)leftGesture{
//    NSUInteger index =  [[self tabBarController] selectedIndex];
//    [[self tabBarController] setSelectedIndex: index +4]; // vai ao ultimo elemento ta tabBar
//}
//
//-(void)rightGesture{
//    NSUInteger index =  [[self tabBarController] selectedIndex];
//    [[self tabBarController] setSelectedIndex: index +1];
//}

- (void)navegacaoManeira:(UIViewController*)tela{
    [tela setModalTransitionStyle: UIModalTransitionStyleCrossDissolve];
    [self presentViewController:tela animated:YES completion:nil];
}

- (IBAction)botaoSettings:(id)sender {
//    SettingsViewController *t = [[SettingsViewController alloc]init];
//    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:t];
//    [self navegacaoManeira:nc];
}

- (IBAction)botaoLixo:(id)sender {
    if ([self conectado]) {
        UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Selecione o tipo de lixo:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                                @"Papel",
                                @"Plastico",
                                @"Metal",
                                @"Vidro",
                                nil];
        popup.tag = 1;
        [popup showInView:[UIApplication sharedApplication].keyWindow];
    }
}

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            [self setTipo:1];
            break;
        case 1:
            [self setTipo:2];
            break;
        case 2:
            [self setTipo:3];
            break;
        case 3:
            [self setTipo:4];
            break;
        default:
            [self setTipo:0];
            break;
    }
    [self enviarLixo];
}


- (IBAction)botaoMenu:(id)sender {
        [[NSNotificationCenter defaultCenter] postNotificationName:kShowHideMenuNotification object:self];
}
@end
