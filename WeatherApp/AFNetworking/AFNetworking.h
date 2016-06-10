// AFNetworking.h
//
//  Created by Brendan Stang on 6/1/16.
//  Copyright © 2016 Brendan Stang. All rights reserved.

#import <Foundation/Foundation.h>
#import <Availability.h>
#import <TargetConditionals.h>

#ifndef _AFNETWORKING_
    #define _AFNETWORKING_

    #import "AFURLRequestSerialization.h"
    #import "AFURLResponseSerialization.h"
    #import "AFSecurityPolicy.h"

#if !TARGET_OS_WATCH
    #import "AFNetworkReachabilityManager.h"
#endif

    #import "AFURLSessionManager.h"
    #import "AFHTTPSessionManager.h"

#endif /* _AFNETWORKING_ */
