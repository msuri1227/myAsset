//
//  XMLReader.h
//
//  Created by Troy Brant on 9/18/10.
//  Updated by Antoine Marcadet on 9/23/11.
//  Updated by Divan Visagie on 2012-08-26
//

#import <Foundation/Foundation.h>

enum {
    XMLReaderOptionsProcessNamespaces           = 1 << 0, // Specifies whether the receiver reports the namespace and the qualified name of an element.
    XMLReaderOptionsReportNamespacePrefixes     = 1 << 1, // Specifies whether the receiver reports the scope of namespace declarations.
    XMLReaderOptionsResolveExternalEntities     = 1 << 2, // Specifies whether the receiver reports declarations of external entities.
};
typedef NSUInteger XMLReaderOptions;

@interface ODSXMLReader : NSObject <NSXMLParserDelegate>

+ (NSDictionary *)dictionaryForXMLData:(NSData *)data error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLData:(NSData *)data options:(XMLReaderOptions)options error:(NSError **)errorPointer;
+ (NSDictionary *)dictionaryForXMLString:(NSString *)string options:(XMLReaderOptions)options error:(NSError **)errorPointer;
- (NSDictionary *)convertHexTOString:(NSString *)string;
- (NSString *)hexToString:(NSString *)string;
- (NSData *)convertHexStringToJson:(NSString *)string;
- (NSData *)convertStringToJson:(NSString *)string;
- (NSData *)convertXmlStringToJson:(NSString *)string;
- (NSString *) stringToHex:(NSString *)str;
- (NSString *)convertToHtml:(NSString *)form : (NSString *)model :(NSString *)Stylesheet :(NSString *)Theme :(NSString *)fromEdit :(NSString *)workNo :(NSString *)version : (NSString *)title;
-(NSString *) createHtmlFromform:(NSString *)form model:(NSString *)model Options:(NSDictionary *)options;
- (NSArray *)parseXMl:(NSData *)xmldata;
- (NSString*)convertDictionaryToXML:(NSDictionary*)dictionary withStartElement:(NSString*)startElement isFirstElement:(BOOL) isFirstElement;
@end
