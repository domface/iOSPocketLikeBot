//
// Created by Dominik Andrzejczuk on 6/30/14.
// Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "OAuth.h"


@implementation OAuth

//DOMFACE
/*
- (NSMutableArray *)accessTokenArray {

    if (!_accessTokenArray)
        _accessTokenArray = [[NSMutableArray alloc] initWithArray:@[
                @"7397744.a93a673.b34edf44f0d64c0484f5f6d9180c34a2",
                @"7397744.1339bcb.e649e7c6c3c845f2a0c1363d3eeab4ad",
                @"7397744.145f8b0.83b62f4976aa4861ba992db9731c439d",
                @"7397744.62a7621.8086f3fa3bda4a3287e544e282697be4",
                @"7397744.87683f6.e6298d5b2ecf4015b93d9728eccd5aa4",
                @"7397744.6c274f0.3df47c3bff1148e69e22d133cbef0823",
                @"7397744.0c178a5.0b0f99a16599484690fd6d7adb9db521",
                @"7397744.44baca5.c1fc6276a76d49b8b94ea40bebe91390",
                @"7397744.e891b77.12478eff7d0c4fd29f792d03328b4058",
                @"7397744.52e1875.4b4ae312bdc64e08a7515c66ba675428",
                @"7397744.3e6c373.b61bfe89473d4a96bf78307687abd6d9",
                @"7397744.b28d08c.56d576e5179e4f838cc242034d61956f"
        ]];
    return _accessTokenArray;
} */

//CHARLOTTE


- (NSMutableArray *)accessTokenArray {

    if (!_accessTokenArray) _accessTokenArray = [[NSMutableArray alloc] initWithArray:@[
                @"40459874.a93a673.c3a646a851da470f932227cd277e02ba",
                @"40459874.1339bcb.5396c28d18084b3182e6f36d5c543af0",
                @"40459874.145f8b0.4d6b63fe6f48433daa5528cea1afa270",
                @"40459874.e891b77.2c730397cb8f4790af4702696422d061",
                @"40459874.52e1875.51f6f472a5114f4d89db67ad58ae8665",
                @"40459874.87683f6.4f943384b1824bba913392529a209448",
                @"40459874.6c274f0.f73d9b9247684775a187a3064ab012d3",
                @"40459874.0c178a5.f0e420b74b0f4b8c83af40ff79741e7c",
                @"40459874.ae34404.44769572b2644e07a8a3b3f8b8cc0219",
                @"40459874.3e6c373.a1732461ebe14a368589aaa5bb3a32bb",
                @"40459874.62a7621.4bf6443aa1f242b28743879b690b35ce",
                @"40459874.edc4f3a.827a0c262ce34938a3a632f38dc61661"
        ]];
    return _accessTokenArray;
}

- (NSMutableArray *)theList {

    if (!_theList) _theList = [[NSMutableArray alloc] init];
    return _theList;
}

- (NSMutableArray *)pictureArray {
    
    if (!_pictureArray) _pictureArray = [[NSMutableArray alloc] init];
    return _pictureArray;
}

- (NSUInteger)picListCounter {
    if (!_picListCounter) _picListCounter = 0;
    return _picListCounter;
}

- (NSUInteger)accessTokenCounter {
    if (!_accessTokenCounter) _accessTokenCounter = 0;
    return _accessTokenCounter;
}

- (NSUInteger)global {
    if (!_global) _global = 0;
    return _global;
}

- (NSMutableString *)theURL
{
    if (!_theURL) _theURL = [[NSMutableString alloc] init];
    return _theURL;
}

- (void)request
{
    [self global];
    self.theURL = nil;
    [self theURL];
    
    
    [self initAccessToken];
    [self accessTokenArray];

    // ######### ENTER YOUR HASTAGS HERE IN BETWEEN THE QUOTES. BE SURE TO LEAVE THE 'NIL' AT THE END!! ###################################
    // IF YOU WANT MORE HASTAGS, SIMPLY CREATE ANOTHER ELEMENT LIKE THIS --> @"hashtagname", SEPARATE EACH TAG WITH A COMMA ###############
    // ####################################################################################################################################
    // ####################################################################################################################################

    [self picListCounter];
    [self accessTokenCounter];
    [self.theURL appendString:@"https://api.instagram.com/v1/tags/"];
    [self.theURL appendString:[self.pictureArray objectAtIndex:self.picListCounter]];
    [self.theURL appendString:[NSString stringWithFormat:@"/media/recent?access_token=%@",self.strAccessToken]];
    self.theList = nil;
    NSMutableArray *listOfImageIds = [[NSMutableArray alloc] init];
    for (int i = 0; i < 18; i++)
    {
        NSURL *theURL = [NSURL URLWithString:self.theURL];
        NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:theURL cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];

        //Specify method of request(Get or Post)
        [theRequest setHTTPMethod:@"GET"];

        //Now pass your own parameter

        //[theRequest setValue:yourValue forHTTPHeaderField:theNameOfThePropertyValue];

        NSURLResponse *theResponse = NULL;
        NSError *theError = NULL;
        NSData *theResponseData = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&theResponse error:&theError];
        NSDictionary *dataDictionaryResponse = [NSJSONSerialization JSONObjectWithData:theResponseData options:NSJSONReadingAllowFragments error:&theError];
        NSDictionary *paginationDict = [dataDictionaryResponse objectForKey:@"pagination"];
        NSString *nextURL = [paginationDict valueForKey:@"next_url"];
        self.theURL = nextURL;
        NSArray *insideData = [dataDictionaryResponse objectForKey:@"data"];
        for (NSDictionary *element in insideData)
        {
            [listOfImageIds addObject:[element valueForKey:@"id"]];
        }
    }
    [self theList];
    self.theList = listOfImageIds;
    NSLog(@"%@", [self.pictureArray objectAtIndex:self.picListCounter]);
    [self likeImagesInList];
}


- (void)likeImagesInList
{
    NSMutableString *likeURL = [[NSMutableString alloc] init];
    int count = 0;
    for (NSString *element in self.theList)
    {
        [likeURL deleteCharactersInRange:(NSMakeRange(0, [likeURL length]))];
        [likeURL appendString:@"https://api.instagram.com/v1/media/"];
        [likeURL appendString:element];
        [likeURL appendString:[NSString stringWithFormat:@"/likes?access_token=%@", self.strAccessToken]];
        NSURL *executeLike = [NSURL URLWithString:likeURL];
        NSMutableURLRequest *likeRequest = [NSMutableURLRequest requestWithURL:executeLike cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:20.0f];
        [likeRequest setHTTPMethod:@"POST"];

        NSHTTPURLResponse *likeResponse = NULL;
        NSError *likeError = NULL;
        NSData *likeResponseData = [NSURLConnection sendSynchronousRequest:likeRequest returningResponse:&likeResponse error:&likeError];
        NSDictionary *likeData = [NSJSONSerialization JSONObjectWithData:likeResponseData options:NSJSONReadingAllowFragments error:&likeError];
        NSDictionary *metaData = [likeData objectForKey:@"meta"];
        if ([[metaData valueForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:200]])
        {
            count++;
            self.global++;
            [NSThread sleepForTimeInterval:4];
            NSLog(@"Liked Picture: %@. Count: %d, Total Liked: %d", element, count, self.global);
            if (count == 349){
                NSLog(@"Taking a break for One Hour");
                [NSThread sleepForTimeInterval:3601];
                self.currentToken++;
                self.picListCounter++;
                break;
            }
        }
        else if ([[metaData valueForKey:@"code"] isEqualToNumber:[NSNumber numberWithInt:429]])
        {
            if (self.currentToken < [self.accessTokenArray count] - 1)
            {
                NSLog(@"Rate Limited, Switching Access Token");
                NSLog(@"%d", [self.accessTokenArray count]);
                self.currentToken++;
                [self switchAccessToken];
            }
            else
            {
                NSLog(@"Rate Limited, NextPic in One Hour");
                self.currentToken = 0;
                self.picListCounter++;
                [NSThread sleepForTimeInterval:3601];
                break;
            }
        }
        else {
            if (self.self.currentToken < [self.accessTokenArray count] - 1)
            {
                NSLog(@"Rate Limited, Switching Access Token");
                self.currentToken++;
                [self switchAccessToken];
            }
            else
            {
                NSLog(@"Rate Limited, NextPic in One Hour");
                self.currentToken = 0;
                self.picListCounter++;
                [NSThread sleepForTimeInterval:3601];
                break;
            }
        }
    }
    [self request];
}


- (void)initAccessToken
{
    if (self.currentToken < 1)
    {
        self.currentToken = 0;
        self.strAccessToken = @"7397744.a93a673.b34edf44f0d64c0484f5f6d9180c34a2";
        NSLog([NSString stringWithFormat:@"%d", self.currentToken]);
    }
}


- (void)switchAccessToken
{
    self.strAccessToken = self.accessTokenArray[self.currentToken];
    
    NSLog([NSString stringWithFormat:@"%d", self.currentToken]);
    NSLog(self.accessTokenArray[self.currentToken]);
}



@end