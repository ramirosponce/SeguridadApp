//
//  Main.h
//  SeguridadApp
//
//  Created by Ramiro Ponce on 06/05/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#ifndef SeguridadApp_Main_h
#define SeguridadApp_Main_h

#endif

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#define IS_PHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_5 (IS_PHONE && [[UIScreen mainScreen] bounds].size.height == 568.0f)
#define SCREEN_SIZE [[UIScreen mainScreen] bounds].size

// Date Filter Type
typedef enum {
    kDateFilterToday = 0,
    kDateFilterWeek = 1,
    kDateFilterMonth = 2,
    kDateFilterAll = 3,
} DateFilterType;

//#define API_BASE_URL                  @"http://appseguridad.avec.com.do/"
#define API_BASE_URL                  @"http://911enlinea.do/"
#define API_TIPO_DENUNCIAS            @"tipodenuncias"
#define API_DENUNCIA                  @"denuncia"
#define API_DENUNCIA_SEARCH           @"denuncia/search"
#define API_DENUNCIA_FIND_BY_ID       @"denuncia/findById"
#define API_UPDATE                    @"denuncia/update"
#define API_NEW                       @"denuncia/new"
#define API_LOGIN                     @"login"
#define API_SIGNUP                    @"signup"
#define API_UPLOADS                   @"app/uploads/"
#define API_UPLOAD                    @"upload"
#define API_REGIONS                   @"regiones"

#define SIGN_UP_OK                    @"OP_OK"
#define ERR_LOGIN_INCORRECT           @"ERR_LOGIN_INCORRECT"
#define ERR_USR_EMAIL_UNCONFIRMED     @"ERR_USR_EMAIL_UNCONFIRMED"
#define ERR_FILE_IS_REQUIRED          @"ERR_FILE_IS_REQUIRED"
#define UNAUTHORIZED                  @"UNAUTHORIZED"
#define ERR_PARAM_ID_IS_REQUIRED      @"ERR_PARAM_ID_IS_REQUIRED"
#define ERR_USR_ACTION_EXISTENT       @"ERR_USR_ACTION_EXISTENT"


#define MAX_COMPLAINT_COUNT          50

