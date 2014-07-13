//
//  NetworkAuxiliar.m
//  SeguridadApp
//
//  Created by Ramiro Ponce on 03/06/14.
//  Copyright (c) 2014 Ramiro Ponce. All rights reserved.
//

#import "NetworkAuxiliar.h"
#import "ErrorHelper.h"

@interface NetworkAuxiliar ()
{
    NSMutableData* returnData;
}
@end

@implementation NetworkAuxiliar

- (id) initWithDelegate:(id<NetworkAuxiliarDelegate>) del
{
    if (self = [super init]) {
        self.delegate = del;
    }
    return self;
}

- (void) uploadPhotos:(UIImage*)image1 image2:(UIImage*)image2 image3:(UIImage*)image3 image4:(UIImage*)image4
{
    NSString *boundary = @"------WebKitFormBoundaryry2BRYQ7DtZ97sNg";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add image data
    if (image1 != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image1, 1.0);
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    if (image2 != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image2, 1.0);
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    if (image3 != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image3, 1.0);
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    if (image4 != nil) {
        NSData *imageData = UIImageJPEGRepresentation(image4, 1.0);
        if (imageData) {
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:imageData];
            [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    NSString* url_string = [NSString stringWithFormat:@"%@%@",API_BASE_URL,API_UPLOAD];
    NSURL* requestURL = [NSURL URLWithString:url_string];
    [request setURL:requestURL];
    
    NSURLConnection* serverConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [serverConnection start];
}

- (void) uploadPhoto:(UIImage*)image
{
    
    NSString *boundary = @"------WebKitFormBoundaryry2BRYQ7DtZ97sNg";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add image data
    NSData *imageData = UIImageJPEGRepresentation(image, 1.0);
    if (imageData) {

        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:imageData];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    NSString* url_string = [NSString stringWithFormat:@"%@%@",API_BASE_URL,API_UPLOAD];
    NSURL* requestURL = [NSURL URLWithString:url_string];
    [request setURL:requestURL];
    
    NSURLConnection* serverConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [serverConnection start];
}

- (void) uploadVideo:(NSURL*)videoURL
{
    NSString *boundary = @"------WebKitFormBoundaryry2BRYQ7DtZ97sNg";
    
    // create request
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
    [request setHTTPShouldHandleCookies:NO];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"POST"];
    
    // set Content-Type in HTTP header
    NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
    [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    // post body
    NSMutableData *body = [NSMutableData data];
    
    // add image data
    NSData *data = [NSData dataWithContentsOfURL:videoURL];
    if (data) {
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Disposition: form-data; name=\"file\"; filename=\"video.mov\"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"Content-Type: application/octet-stream\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:data];
        [body appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
    }
    
    [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
    
    // setting the body of the post to the reqeust
    [request setHTTPBody:body];
    
    // set the content-length
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[body length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    
    // set URL
    NSString* url_string = [NSString stringWithFormat:@"%@%@",API_BASE_URL,API_UPLOAD];
    NSURL* requestURL = [NSURL URLWithString:url_string];
    [request setURL:requestURL];
    
    NSURLConnection* serverConnection = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [serverConnection start];
}

- (void) connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    returnData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    [returnData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    //if (connection == serverConnection) {}
    
    NSString *responseString = [[NSString alloc] initWithData:returnData encoding:NSUTF8StringEncoding];
    
    NSLog(@"Response: %@", responseString);
    
    if ([responseString rangeOfString:@"err"].location == NSNotFound) {
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(connectionDidFinishSuccess:)]) {
            [self.delegate connectionDidFinishSuccess:responseString];
        }
    } else {
        NSString* error_message;
        if ([responseString rangeOfString:@"err"].location == NSNotFound) {
            error_message = [ErrorHelper errorMessage:@""];
        }else{
            error_message = [ErrorHelper errorMessage:ERR_FILE_IS_REQUIRED];
        }
        
        if (self.delegate != nil && [self.delegate respondsToSelector:@selector(connectionDidFinishError:)]) {
            [self.delegate connectionDidFinishError:error_message];
        }
    }
}

- (void) connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    NSString* error_message;
    error_message = [ErrorHelper errorMessage:@""];
    
    if (self.delegate != nil && [self.delegate respondsToSelector:@selector(connectionDidFinishError:)]) {
        [self.delegate connectionDidFinishError:error_message];
    }
}

@end
