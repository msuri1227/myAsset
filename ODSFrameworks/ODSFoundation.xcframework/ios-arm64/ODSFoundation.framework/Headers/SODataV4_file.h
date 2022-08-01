//# xsc 19.1.1-0d1263-20190301

#ifndef SODATAV4_FILE_H
#define SODATAV4_FILE_H


@class SODataV4_FileManager;
@class SODataV4_DataFileReader;
@class SODataV4_DataFileWriter;
@class SODataV4_TextFileReader;
@class SODataV4_TextFileWriter;
@class SODataV4_FileException;

#ifndef imported_SODataV4__FileManager_public
#define imported_SODataV4__FileManager_public
/// @internal
///
@interface SODataV4_FileManager : SODataV4_ObjectBase
{
}
/// @brief Copy `source` file to `target` file.
///
///
/// @param source Source file name.
/// @param target Target file name.
+ (void) copyFile :(nonnull NSString*)source :(nonnull NSString*)target;
/// @internal
///
+ (void) createDirectory :(nonnull NSString*)file;
/// @brief Create a directory file.
///
///
/// @param file Directory file name.
/// @param createParents (optional) Should parent directories be created if they don't already exist? Defaults to `true`.
+ (void) createDirectory :(nonnull NSString*)file :(SODataV4_boolean)createParents;
/// @brief Create parent directory for a file, if the parent directory doesn't exist already.
///
///
/// @param file File name.
+ (void) createParent :(nonnull NSString*)file;
/// @internal
///
+ (void) deleteDirectory :(nonnull NSString*)file;
/// @brief Delete a directory file.
///
///
/// @param file Directory file name.
/// @param deleteChildren (optional) Should child files and directories be deleted if they exist? Defaults to `true`.
+ (void) deleteDirectory :(nonnull NSString*)file :(SODataV4_boolean)deleteChildren;
/// @brief Delete `file`.
///
///
/// @param file File name.
+ (void) deleteFile :(nonnull NSString*)file;
/// @brief Check if `file` exists.
///
///
/// @return `true` if the file (or directory) exists, `false` otherwise.
/// @param file File name.
+ (SODataV4_boolean) fileExists :(nonnull NSString*)file;
/// @return The length of an existing `file`.
/// @param file File name.
+ (SODataV4_long) fileLength :(nonnull NSString*)file;
/// @brief Check if a file name represents an existing directory.
///
///
/// @return `true` if the represents an existing directory, otherwise `false`.
/// @param file File name.
+ (SODataV4_boolean) isDirectory :(nonnull NSString*)file;
/// @return A list of the files in a directory.
/// @param path Directory name.
+ (nonnull SODataV4_StringList*) listFiles :(nonnull NSString*)path;
/// @brief Get the current application's preferred local directory name, or current directory name on platforms with no concept of the application's local directory.
///
///
+ (nonnull NSString*) localDirectory;
/// @return The parent directory for `file`, or `nil` if the file has no parent directory.
/// @param file File name.
+ (nullable NSString*) parentDirectory :(nonnull NSString*)file;
/// @brief Rename a file from `oldName` to `newName`.
///
///
/// @param oldName Original file name.
/// @param newName New file name.
+ (void) renameFile :(nonnull NSString*)oldName :(nonnull NSString*)newName;
/// @brief Convert a file name to canonical/preferred syntax for the file system.
///
///
/// @param file File name.
+ (nonnull NSString*) resolveName :(nonnull NSString*)file;
/// @return The unqualified name of `file`, excluding any parent directories.
/// @param file File name.
+ (nonnull NSString*) unqualifiedName :(nonnull NSString*)file;
@end
#endif

#ifndef imported_SODataV4__DataFileReader_public
#define imported_SODataV4__DataFileReader_public
/// @internal
///
@interface SODataV4_DataFileReader : SODataV4_ByteStream
{
    @private FILE* fp;
    @private SODataV4_ByteBuffer* _Nonnull _buffer;
    @private SODataV4_int _length;
    @private SODataV4_int _offset;
    @private SODataV4_int _bufferSize;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Close the file.
///
///
- (void) close;
/// @brief Open a data file for read access.
///
///
/// @return The opened file reader.
/// @param file File name.
+ (nonnull SODataV4_DataFileReader*) open :(nonnull NSString*)file;
/// @brief Read a byte, returning its unsigned value.
///
///
/// @return Unsigned byte, or -1 if end of file has been reached.
- (SODataV4_int) readByte;
/// @brief Read the entire contents of `file`.
///
///
/// @return Binary representation of `file`.
/// @param file File name.
+ (nonnull NSData*) readFile :(nonnull NSString*)file;
/// @brief Alter the buffer size. Should be called after `open`, but before reading content.
///
///
/// @return This file.
/// @param size Buffer size.
- (nonnull SODataV4_DataFileReader*) withBufferSize :(SODataV4_int)size;
@end
#endif

#ifdef import_SODataV4__DataFileReader_private
#ifndef imported_SODataV4__DataFileReader_private
#define imported_SODataV4__DataFileReader_private
@interface SODataV4_DataFileReader (private)
+ (nonnull SODataV4_DataFileReader*) new;
- (SODataV4_boolean) readMore;
+ (nonnull SODataV4_DataFileReader*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__DataFileWriter_public
#define imported_SODataV4__DataFileWriter_public
/// @internal
///
@interface SODataV4_DataFileWriter : SODataV4_ByteStream
{
    @private FILE* fp;
    @private SODataV4_ByteBuffer* _Nullable _buffer;
    @private SODataV4_int _bufferSize;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Open a data file for append access. Creates the file if it doesn't already exist.
///
///
/// @param file File name.
+ (nonnull SODataV4_DataFileWriter*) append :(nonnull NSString*)file;
/// @brief Close the file.
///
///
- (void) close;
/// @brief Flush buffered contents to the file.
///
///
- (void) flush;
/// @brief Open a data file for write access. Recreates the file if already exists.
///
///
/// @param file File name.
+ (nonnull SODataV4_DataFileWriter*) open :(nonnull NSString*)file;
/// @brief Alter the buffer size. Should be called after `SODataV4_DataFileWriter`.`append` / `SODataV4_DataFileWriter`.`open`, but before writing content.
///
///
/// @return This file.
/// @param size Buffer size.
- (nonnull SODataV4_DataFileWriter*) withBufferSize :(SODataV4_int)size;
/// @brief Write data content to the file. Text is converted to UTF-8 format for writing.
///
///
/// @param data Data content.
- (void) writeBinary :(nonnull NSData*)data;
/// @brief Write data content to the file.
///
///
/// @param value Data content.
- (void) writeByte :(SODataV4_byte)value;
/// @brief Write a `file` to contain `data`.
///
///
/// @param file File name.
/// @param data Data content.
+ (void) writeFile :(nonnull NSString*)file :(nonnull NSData*)data;
@end
#endif

#ifdef import_SODataV4__DataFileWriter_private
#ifndef imported_SODataV4__DataFileWriter_private
#define imported_SODataV4__DataFileWriter_private
@interface SODataV4_DataFileWriter (private)
+ (nonnull SODataV4_DataFileWriter*) new;
- (void) flushBuffer;
- (nonnull SODataV4_ByteBuffer*) getBuffer;
- (void) initBuffer;
+ (nonnull SODataV4_DataFileWriter*) _new1 :(nullable NSString*)p1;
@end
#endif
#endif

#ifndef imported_SODataV4__TextFileReader_public
#define imported_SODataV4__TextFileReader_public
/// @internal
///
@interface SODataV4_TextFileReader : SODataV4_CharStream
{
    @private SODataV4_DataFileReader* _Nonnull _input_;
    @private SODataV4_ByteBuffer* _Nonnull _bytes;
    @private SODataV4_CharBuffer* _Nonnull _chars;
    @private SODataV4_int _index;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Close the file.
///
///
- (void) close;
/// @brief Open a text file for read access.
///
///
/// @param file File name.
+ (nonnull SODataV4_TextFileReader*) open :(nonnull NSString*)file;
/// @brief Read a single character (UTF-16 code unit) from this file.
///
///
/// @return Unsigned integer equivalent of the character read (a UTF-16 code unit), or `-1` at end of file.
- (SODataV4_int) readChar;
/// @brief Read the entire contents of `file`.
///
///
/// @param file File name.
+ (nonnull NSString*) readFile :(nonnull NSString*)file;
/// @brief Read the entire contents of `file` as a list of lines.
///
///
/// @return List of lines.
/// @param file File name.
+ (nonnull SODataV4_StringList*) readLines :(nonnull NSString*)file;
/// @brief Alter the buffer size. Should be called after `open`, but before reading content.
///
///
/// @return This file.
/// @param size Buffer size.
- (nonnull SODataV4_TextFileReader*) withBufferSize :(SODataV4_int)size;
@end
#endif

#ifdef import_SODataV4__TextFileReader_private
#ifndef imported_SODataV4__TextFileReader_private
#define imported_SODataV4__TextFileReader_private
@interface SODataV4_TextFileReader (private)
+ (nonnull SODataV4_TextFileReader*) new;
- (nonnull SODataV4_DataFileReader*) _input;
- (void) set_input :(nonnull SODataV4_DataFileReader*)value;
+ (nonnull SODataV4_TextFileReader*) _new1 :(nullable NSString*)p1 :(nonnull SODataV4_DataFileReader*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataFileReader* _input;
@end
#endif
#endif

#ifndef imported_SODataV4__TextFileWriter_public
#define imported_SODataV4__TextFileWriter_public
/// @internal
///
@interface SODataV4_TextFileWriter : SODataV4_CharStream
{
    @private SODataV4_CharBuffer* _Nonnull _buffer;
    @private SODataV4_DataFileWriter* _Nonnull _writer_;
}
- (nonnull id) init;
/// @internal
///
- (void) _init;
/// @brief Open a text file for append access. Creates the file if it doesn't already exist.
///
///
/// @param file File name.
+ (nonnull SODataV4_TextFileWriter*) append :(nonnull NSString*)file;
/// @brief Close the file.
///
///
- (void) close;
/// @brief Flush buffered contents to the file.
///
///
- (void) flush;
/// @brief Open a text file for write access. Recreates the file if already exists.
///
///
/// @param file File name.
+ (nonnull SODataV4_TextFileWriter*) open :(nonnull NSString*)file;
/// @brief Alter the buffer size. Should be called after `SODataV4_TextFileWriter`.`append` / `SODataV4_TextFileWriter`.`open`, but before writing content.
///
///
/// @return This file.
/// @param size Buffer size.
- (nonnull SODataV4_TextFileWriter*) withBufferSize :(SODataV4_int)size;
/// @brief Write text content to the file. Text is converted to UTF-8 format for writing.
///
///
/// @param value Text content.
- (void) writeChar :(SODataV4_char)value;
/// @brief Write a `file` to contain `text`.
///
///
/// @param file File name.
/// @param text Text content.
+ (void) writeFile :(nonnull NSString*)file :(nonnull NSString*)text;
/// @brief Write text content to the file. Text is converted to UTF-8 format for writing.
///
///
/// @param text Text content.
- (void) writeString :(nonnull NSString*)text;
@end
#endif

#ifdef import_SODataV4__TextFileWriter_private
#ifndef imported_SODataV4__TextFileWriter_private
#define imported_SODataV4__TextFileWriter_private
@interface SODataV4_TextFileWriter (private)
+ (nonnull SODataV4_TextFileWriter*) new;
- (nonnull SODataV4_DataFileWriter*) _writer;
- (void) forceWrite :(nonnull SODataV4_CharBuffer*)buffer;
- (void) maybeWrite :(nonnull SODataV4_CharBuffer*)buffer;
- (void) set_writer :(nonnull SODataV4_DataFileWriter*)value;
+ (nonnull SODataV4_TextFileWriter*) _new1 :(nullable NSString*)p1 :(nonnull SODataV4_DataFileWriter*)p2;
@property (nonatomic, readwrite, strong, nonnull) SODataV4_DataFileWriter* _writer;
@end
#endif
#endif

#ifndef imported_SODataV4__FileException_public
#define imported_SODataV4__FileException_public
/// @internal
///
@interface SODataV4_FileException : SODataV4_DataStorageException
{
}
/// @brief Default initializer.
///
///
+ (nonnull SODataV4_FileException*) new;
/// @internal
///
- (void) _init;
/// @return A new exception with the specified root cause.
/// @param cause Root cause.
+ (nonnull SODataV4_FileException*) withCause :(nullable NSException*)cause;
/// @return A new exception with the specified root cause and message text.
/// @param cause Root cause.
/// @param message Message text.
+ (nonnull SODataV4_FileException*) withCauseAndMessage :(nullable NSException*)cause :(nonnull NSString*)message;
/// @return A new exception with the specified message text.
/// @param message Message text.
+ (nonnull SODataV4_FileException*) withMessage :(nullable NSString*)message;
@end
#endif

#ifdef import_SODataV4__FileException_private
#ifndef imported_SODataV4__FileException_private
#define imported_SODataV4__FileException_private
@interface SODataV4_FileException (private)
+ (nonnull SODataV4_FileException*) _new1 :(nullable NSException*)p1;
+ (nonnull SODataV4_FileException*) _new2 :(nullable NSException*)p1 :(nullable NSString*)p2;
+ (nonnull SODataV4_FileException*) _new3 :(nullable NSString*)p1;
@end
#endif
#endif

#endif
