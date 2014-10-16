//
//  webService.h
//  webService
//
//  Created by GABRIEL VIEIRA on 20/05/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface webService : NSObject

extern NSString *usuarioUniversal;

+(BOOL)login : (NSString *)email : (NSString *)pass;
+(BOOL)check;
+(int)newUser : (NSString *)user :  (NSString *)pass : (NSString *)nickName;
+(void)uploadImage: (UIImage *)imagemDoPerfil : (NSString *)username;
+(BOOL)updateTinder : (int )evaluation : (int)idRecycled;

+(NSDictionary *)rankingUser: (NSString *)type : (NSString *)user;
+(NSDictionary *)carregarTinder : (NSString *)email;

+(BOOL)salvaPontosJoguinho:(NSString *)user Papel:(NSString *)papel Vidro:(NSString *)vidro Plastico:(NSString *)plastico Metal:(NSString *)metal Pontuacao:(NSString *)total;
+(NSDictionary *)carregarUmaFotoTinder : (NSString *)email;
+(BOOL)carregarPontosUsuario: (NSString *)user;
@end
