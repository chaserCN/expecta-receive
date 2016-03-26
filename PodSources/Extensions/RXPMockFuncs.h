//
//  NSObject+expecta_receive.h
//  Pods
//
//  Created by Nicolas on 3/26/16.
//
//

#import <Foundation/Foundation.h>
#import "OCPartialMockObject.h"

OCPartialMockObject *RXPGetPartialMock(id object);
void RXPSetPartialMock(id object, OCPartialMockObject *mock);

@interface NSObject (expecta_receive)
@property (nonatomic, strong, setter=set_rxp_partialMock:) OCPartialMockObject *rxp_partialMock;
@end
