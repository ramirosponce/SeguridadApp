//
//  ErrorHelper.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 27/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "ErrorHelper.h"

@implementation ErrorHelper

+ (NSString*) errorMessage:(NSString*)error_message
{
    if ([error_message isEqualToString:ERR_LOGIN_INCORRECT]) {
        return NSLocalizedString(@"Email o Password incorrectos. Por favor, verifique los datos ingreasados.", @"Email o Password incorrectos. Por favor, verifique los datos ingreasados.");
    }
    
    if ([error_message isEqualToString:ERR_USR_EMAIL_UNCONFIRMED]) {
        return NSLocalizedString(@"Confirme el email de registracion para realizar esta accion. Quiere que reenviemos el mail de confirmacion?.", @"Confirme el email de registracion para realizar esta accion. Quiere que reenviemos el mail de confirmacion?.");
    }
    
    if ([error_message isEqualToString:ERR_FILE_IS_REQUIRED]) {
        return NSLocalizedString(@"Error al subir archivo, por favor intentelo nuevamente mas tarde.", @"Error al subir archivo, por favor intentelo nuevamente mas tarde.");
    }
    
    if ([error_message isEqualToString:UNAUTHORIZED]) {
        return NSLocalizedString(@"Usted no esta autorizado a realizar esta accion.", @"Usted no esta autorizado a realizar esta accion.");
    }
    
    if ([error_message isEqualToString:ERR_PARAM_ID_IS_REQUIRED]) {
        return NSLocalizedString(@"Ha ocurrido un problema, Por favor intentelo nuevamente mas tarde.", @"Ha ocurrido un problema, Por favor intentelo nuevamente mas tarde.");
    }
    
    if ([error_message isEqualToString:ERR_USR_ACTION_EXISTENT]) {
        return NSLocalizedString(@"Usted ya ha realizado esta accion, solamente se puede hacer una sola vez por comentario.", @"Usted ya ha realizafo esta accion, solamente se puede hacer una sola vez por comentario.");
    }
    
    return NSLocalizedString(@"Ha ocurrido un problema, Por favor intentelo nuevamente mas tarde.", @"Ha ocurrido un problema, Por favor intentelo nuevamente mas tarde.");
}



@end
