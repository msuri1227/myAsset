//
//  XSLTtransform.h
//  xslto
//
//  Created by Rover Software on 30/05/18.
//  Copyright © 2018 Rover Software. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XSLTtransform : NSObject

-(NSString *)TransformXmltoHtml:(NSString *)data xmlfile:(NSString *)xmlData loadLocal:(BOOL)loadLocal;
@end

