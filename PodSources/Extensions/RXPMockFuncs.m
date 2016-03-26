//
//  NSObject+expecta_receive.m
//  Pods
//
//  Created by Nicolas on 3/26/16.
//
//

#import "RXPMockFuncs.h"
#import <objc/runtime.h>

static char kPartialMockObjectKey;

OCPartialMockObject *RXPGetPartialMock(id object) {
    return objc_getAssociatedObject(object, &kPartialMockObjectKey);
}

void RXPSetPartialMock(id object, OCPartialMockObject *mock) {
    objc_setAssociatedObject(object, &kPartialMockObjectKey, mock, OBJC_ASSOCIATION_ASSIGN);
}
