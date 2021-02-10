//
//  AAAOCCheckHook.m
//  AAACheckHook
//
//  Created by zhangsuya on 2020/11/17.
//

#import "AAAOCCheckHook.h"
#import "fishhook.h"
#import <objc/runtime.h>

IMP _Nullable (*class_oldreplaceMethod)(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
                                     const char * _Nullable types);

IMP _Nonnull (*method_oldsetImplementation)(Method _Nonnull m, IMP _Nonnull imp);

void (*method_oldexchangeImplementations)(Method _Nonnull m1, Method _Nonnull m2);

OBJC_EXPORT void
method_myexchangeImplementations(Method _Nonnull m1, Method _Nonnull m2) {
    SEL originSel = method_getName(m1);
    SEL replaceSel = method_getName(m2);
    NSLog(@"AAACheckHook originMethod %@ swizzMethod %@ ",NSStringFromSelector(originSel),NSStringFromSelector(replaceSel));
    method_oldexchangeImplementations(m1,m2);
}

OBJC_EXPORT IMP _Nullable class_myreplaceMethod(Class _Nullable cls, SEL _Nonnull name, IMP _Nonnull imp,
                    const char * _Nullable types)
{
    NSLog(@"AAACheckHook class: %@ selector:%@",NSStringFromClass(cls),NSStringFromSelector(name));
    return class_oldreplaceMethod(cls,name,imp,types);
    
}

OBJC_EXPORT IMP _Nonnull
method_mysetImplementation(Method _Nonnull m, IMP _Nonnull imp)
{
    SEL sel = method_getName(m);
    
    NSLog(@"AAACheckHook originOrSwizzMethod: %@ ",NSStringFromSelector(sel));
    return method_oldsetImplementation(m,imp);
}

@implementation AAAOCCheckHook

+(void)load
{

    rebind_symbols((struct rebinding[1]){"class_replaceMethod", (void *)class_myreplaceMethod, (void **)&class_oldreplaceMethod},1);
    rebind_symbols((struct rebinding[1]){"method_setImplementation", (void *)method_mysetImplementation, (void **)&method_oldsetImplementation},1);
    rebind_symbols((struct rebinding[1]){"method_exchangeImplementations", (void *)method_myexchangeImplementations, (void **)&method_oldexchangeImplementations},1);
    
}

@end
