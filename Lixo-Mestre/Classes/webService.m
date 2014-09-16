//
//  webService.m
//  webService
//
//  Created by GABRIEL VIEIRA on 20/05/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "webService.h"
#import "Reachability.h"

@implementation webService


+(BOOL)check{
    // Allocate a reachability object
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable)
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

+(BOOL)login : (NSString *)user : (NSString *)pass{
    if ([self check]){
        
        NSString *url =  @"http://172.246.16.27/lixoPapao/loginManager.php";
        NSString *post = [NSString stringWithFormat:@"type=login&user=%@&pass=%@",user , pass];
        
        NSLog(@"%@" , post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        
        [ request setHTTPMethod: @"POST"];
        [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [ request setHTTPBody: postData ];
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
        NSString *content = [NSString stringWithUTF8String:[returnData bytes]];
        
        //se precisar de um json maneiro
        
        /*
         NSError* error;
         NSDictionary* json = [NSJSONSerialization
         JSONObjectWithData:returnData //1
         
         options:kNilOptions
         error:&error];
         
         NSString *ret ;
         
         for (NSString *s in json) {
         ret = s;
         }
         */
        int x = [content integerValue];
        
        if (x){
        NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
            if (preferencias) {
                    [preferencias setObject:user forKey:@"userName"];
                    [preferencias setObject:pass forKey:@"password"];
                    [preferencias synchronize];
                }
            return YES;
        }
    }
    return NO;
}

+(int)newUser:(NSString *)user :(NSString *)pass :(NSString *)nickName{
    int x = 0;
    if ([self check]){
        NSString *url =  @"http://172.246.16.27/lixoPapao/loginManager.php";
        NSString *post = [NSString stringWithFormat:@"type=new&user=%@&pass=%@&nick_name=%@",user , pass, nickName];
        
        //NSLog(@"%@" , post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        
        [ request setHTTPMethod: @"POST"];
        [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [ request setHTTPBody: postData ];
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
        NSString *content = [NSString stringWithUTF8String:[returnData bytes]];
        
         x = [content integerValue];

        //se precisar de um json maneiro
        
       /*
         NSError* error;
         NSDictionary* json = [NSJSONSerialization
         JSONObjectWithData:returnData //1
         
         options:kNilOptions
         error:&error];
         
         NSString *ret ;
         
         for (NSString *s in json) {
         ret = s;
         }
       */
    }
    return x;
}

+(void)uploadImage: (UIImage *)imagemDoPerfil : (NSString *)username{
    NSData *imageData = UIImagePNGRepresentation(imagemDoPerfil);
    
    NSString *urlString = @"http://172.246.16.27/lixoPapao/imagem.php";
    NSString *filename = username;
    NSMutableURLRequest *request= [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    NSString *boundary = @"---------------------------14737809831466499882746641449";
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    NSMutableData *postbody = [NSMutableData data];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"userfile\"; filename=\"%@.jpg\"\r\n", filename] dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
    [postbody appendData:[NSData dataWithData:imageData]];
    [postbody appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    [request setHTTPBody:postbody];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
    NSString *returnString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    NSLog(@"%@", returnString);
    
    return;
}

+(NSDictionary *)carregarTinder : (NSString *)user{
    if ([self check]){
        NSString *url =  @"http://172.246.16.27/lixoPapao/tinder.php";
        NSString *post = [NSString stringWithFormat:@"type=first&user=%@",user];
        
        NSLog(@"%@" , post);
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        
        [ request setHTTPMethod: @"POST"];
        [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [ request setHTTPBody: postData ];
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
       // NSString *content = [NSString stringWithUTF8String:[returnData bytes]];
        
        //se precisar de um json maneiro
        
         NSError* error;
         NSDictionary* json = [NSJSONSerialization
         JSONObjectWithData:returnData //1
         
         options:kNilOptions
         error:&error];
         
         //NSString *ret ;
        return json;
    }
    return nil;
}


+(BOOL)updateTinder : (int )evaluation : (int)idRecycled{
    if ([self check]){
        NSString *url =  @"http://172.246.16.27/lixoPapao/tinder.php";
        NSString *post = [NSString stringWithFormat:@"type=update&evaluation1=%d&id_recycled=%d",evaluation , idRecycled];
        
        NSLog(@"%@" , post);
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        
        [ request setHTTPMethod: @"POST"];
        [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [ request setHTTPBody: postData ];
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
        NSString *content = [NSString stringWithUTF8String:[returnData bytes]];
        
        if ([content isEqualToString:@"erro"]) {
            return false;
        }
        else{
            return true;
        }
        //se precisar de um json maneiro
        /*
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:returnData //1
                              
                              options:kNilOptions
                              error:&error];
        
        //NSString *ret ;
        
        return json;
        */
    }
    return false;
}

+(NSString *)getUser{
    return @"foo";
}

+(NSDictionary *)rankingUser: (NSString *)type : (NSString *)user{
    NSString *url =  @"http://172.246.16.27/lixoPapao/rank?";
    NSString *post = [NSString stringWithFormat:@"type=%@&user=%@",type , user];
    
    NSLog(@"%@" , post);
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    
    NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
    
    [ request setHTTPMethod: @"POST"];
    [ request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    [ request setHTTPBody: postData ];
    NSURLResponse *response;
    NSError *err;
    NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];

    NSError *error;
    NSMutableDictionary *jsonDadosUsuario = [NSJSONSerialization
                                             JSONObjectWithData:returnData
                                             options:NSJSONReadingMutableContainers
                                             error:&error];
    return jsonDadosUsuario;
}

+(BOOL)salvaPontosJoguinho:(NSString *)user Papel:(NSString *)papel Vidro:(NSString *)vidro Plastico:(NSString *)plastico Metal:(NSString *)metal Pontuacao:(NSString *)total{
    if ([self check]){
        NSString *url =  @"http://172.246.16.27/lixoPapao/rank.php";
        NSString *post = [NSString stringWithFormat:@"type=salvarjogolixo&user=%@&papel=%@&vidro=%@&plastico=%@&metal=%@&total=%@",user, papel, vidro, plastico, metal, total];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        
        [request setHTTPBody: postData ];
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];
        
        NSString *content = [NSString stringWithUTF8String:[returnData bytes]];

        int x = [content integerValue];
        if (x){
            NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
            if (preferencias) {
                [preferencias setObject:user forKey:@"userName"];
                [preferencias synchronize];
            }
            return YES;
        }
    }
    return NO;
}

+(BOOL)carregarPontosUsuario: (NSString *)user{
    if ([self check]){
        NSString *url =  @"http://172.246.16.27/lixoPapao/rank.php";
        NSString *post = [NSString stringWithFormat:@"type=carregarjogolixo&user=%@", user];
        
        NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
        
        NSMutableURLRequest *request = [ [ NSMutableURLRequest alloc ] initWithURL: [ NSURL URLWithString: url]];
        [request setHTTPMethod: @"POST"];
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        [request setHTTPBody: postData ];
        
        NSURLResponse *response;
        NSError *err;
        NSData *returnData = [ NSURLConnection sendSynchronousRequest: request returningResponse:&response error:&err];

        //se precisar de um json maneiro
        NSError* error;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:returnData //1
                              
                              options:kNilOptions
                              error:&error];
        //return json;
        //NSLog(@"%@",json);
        NSUserDefaults *preferencias = [NSUserDefaults standardUserDefaults];
        if (preferencias) {
            [preferencias setObject:user forKey:@"userName"];
            
            [preferencias setInteger: [[json valueForKey:@"metal"] intValue] forKey:@"qteMetal"];
            [preferencias setInteger: [[json valueForKey:@"papel"] intValue] forKey:@"qtePapel"];
            [preferencias setInteger: [[json valueForKey:@"vidro"] intValue] forKey: @"qteVidro]"] ;
            [preferencias setInteger: [[json valueForKey:@"plastico"] intValue] forKey:@"qtePlastico"];
            [preferencias setInteger: [[json valueForKey:@"total"] intValue] forKey:@"maiorPontuacao"];
            [preferencias synchronize];
        }
        else{
            return NO;
        }
        return YES;
    }
    return NO;
}

@end
