//
//  SODataV4_Tutorial.h
//  ODataV4OnlineCore
//
//  Copyright © 2017 SAP. All rights reserved.
//


/**
 * @example
 *
 *
 * # Creating your first app
 *
 * <b>Step 1: Create a new iOS project in Xcode</b>
 *
 * - File -> New -> Project. Objective-C language should be preferred.
 *
 * <b>Step 2: Setup project dependencies with Cocoapods</b>
 *
 * - Close your project in Xcode.
 *
 * - If you have Cocoapods installed already, check your version with <EM>pod --version</EM> command. If your version is higher than 1.2.0 and previously experienced problems during following the steps below, uninstall it by executing <EM>gem uninstall cocoapods</EM>. Use <EM>sudo</EM> if needed.
 *
 * - If Cocoapods is not present, install it by using the <EM>gem install cocoapods -v 1.2.0</EM> command in Terminal. Use <EM>sudo</EM> if needed.
 *
 * - In your terminal navigate to your project directory and run <EM>pod init</EM>. This will create a Podfile template.
 *
 * - Open that Podfile in a text editor and you should create a content equivalent to the snippet below, or copy-paste this one. Your SDK location should be under <EM>~/SAP/MobileSDK3/NativeSDK/</EM> by default, otherwise modify it.
 *
 *
 * - target 'ODataV4TestApp' do \n
 *   pod 'NativeSDK-Debug/ODataV4OnlineCore', :path => "~/SAP/MobileSDK3/NativeSDK/"  \n
 *   # If you intend to use the release version of our libraries, change the above NativeSDK-Debug to NativeSDK-Release.  \n
 *   end  \n
 *
 *
 * - Save the Podfile and run <EM>pod setup</EM> from Terminal. This will setup your local repository. If you don't seem to reach the dependencies with your network, check if your Terminal has the correct proxy settings.
 *
 * - If it succeeded, run <EM>pod install</EM>. This will create your Pods project and an <EM>.xcworkspace</EM> file including it. This <EM>.xcworkspace</EM> file will be used in the future instead of the <EM>.xcodeproj</EM> one.
 *
 * - If you want to update your dependencies when a new patch or release arrived, update your SDK with the newest SMP SDK Installer, then run <EM>pod update</EM> from the terminal to update the dependencies of your project.
 
 *
 * <b>Step 3: Create proxy classes for your OData service</b>
 *
 * - Have Java JDK or JRE installed on your machine and global variable JAVA_HOME set in your .bash_profile. You can set it like this: \n
 *      <EM>export JAVA_HOME=/Library/Java/JavaVirtualMachines/jdk1.8.0_111.jdk/Contents/Home</EM> \n
 *      Make sure to alter the path according to your java version and restart your terminal to apply these changes. \n
 *
 * - First navigate to your <EM>SDK installation path/NativeSDK/ODataFramework/iOS/tools/proxy-generator-mobile/bin</EM>.
 *
 * - Download the metadata of your service you intend to use in your application. You should name your metadata file, so it can identify your service, but try to make it short, like <EM>"Northwind.xml"</EM>.
 *
 * - Add executability permission to all scripts in the directory: <EM>chmod +x *.sh</EM>
 *
 * - Run the following script like this: <EM>./generateclasses.sh Your_metadata_file</EM>
 *
 * - Your proxy classes were generated at <EM>../genfiles/oc</EM>.
 *
 *
 * <b>Step 4: Assemble your project</b>
 *
 * - Step one directory up from the location of the previous script, then navigate to <EM>genfiles/oc</EM>.
 *
 * - Here you need 3 files added in your project: <EM>Your package name.h</EM>, <EM>Your package name.i</EM> and <EM>Your package name.m</EM>.
 *
 * - Open your <EM>.xcworkspace</EM> file in your project directory and add the files above.
 *
 * - Open <EM>Your package name.h</EM> and add the following line to import the SODataV4 runtime header:
 *
 *      <CODE>#import "SODataV4_runtime.h"</CODE>
 *
 * - Now your project should compile.
 *
 * - If you intend to communicate with a server not supporting TLS v1.2 or newer protocol (in most cases this is an only HTTP instead of HTTPS server), you should add exception domains under your App Transport Security Settings in your <EM>Info.plist</EM> file. These exception domains will be allowed to communicate with, using HTTP protocol. The content of your <EM>Info.plist</EM> should include a dictionary like below:
 *
 *
 * - NSAppTransportSecurity
 *   - NSExceptionDomains
 *     - example.com
 *       - NSIncludesSubdomains
 *         - YES
 *         .
 *       - NSTemporaryExceptionAllowsInsecureHTTPLoads
 *         - YES
 *         .
 *       - NSTemporaryExceptionMinimumTLSVersion
 *         - TLSv1.1
 *         .
 *       .
 *     .
 *   .
 * .
 *
 *
 * <b>Step 5: Write some code</b>
 *
 * Add a new class to your project which will handle the objects necessary for representing your OData V4 requests and entities. The following lines are needed to start some simple requests:
 *
 * <CODE>
 * // You need the header of proxy classes included:
 *
 * #import "Your_package_name.h"
 *
 *
 * // The following property will be the representation of your service:
 *
 * \@property (nonatomic, strong) Your_service_name* service;
 *
 *
 *
 * // Initialize your HttpConversationManager that will handle the requests. If you want to use authentication, you will also need a CommonAuthenticationConfigurator object.
 *
 * HttpConversationManager* manager = [[HttpConversationManager alloc] init];
 *
 *
 *
 * // The Online OData provider needs a handler object with the previous conversation manager.
 *
 * SODataV4_HttpConversationHandler* httpHandler = [[SODataV4_HttpConversationHandler alloc] initWithManager:manager];
 *
 * SODataV4_OnlineODataProvider* provider = [SODataV4_OnlineODataProvider new:\@"Give it some name" :\@"URL of your OData service" :httpHandler];
 *
 *
 *
 * // Finally, the service object.
 *
 * self.service = [Your_service_name new:provider];
 *
 *
 *
 * //Choose an entity set object you want to get from your service. The available classes can be found in Your_package_name.h.
 *
 * YourEntityList* EntityList = [self.service getYourEntityList];
 *
 * NSLog(\@"%@", [EntityList toString]);
 *
 *
 *
 * // Batch requests can be created like this:
 *
 * // Create your queries
 *
 *
 *  SODataV4_DataQuery* queryYourEntityList1 = [[[[SODataV4_DataQuery new] \n
 *          select:\@[[YourEntity1 YourEntity1ID],[YourEntity1 SomeProperty1],[YourEntity1 SomeProperty2]]] \n
 *          from:[Your_ServiceMetadata_EntitySets YourEntitySet]] \n
 *          filter:[[[YourEntity1 YourEntity1ID] \n
 *          equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:\@"FilterForThis1"]))] \n
 *          or:[[YourEntity1 YourEntity1ID] \n
 *          equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:\@"FilterForThisToo1"]))]]]; \n
 *
 *
 *  SODataV4_DataQuery* queryYourEntityList2 = [[[[SODataV4_DataQuery new] \n
 *          select:\@[[YourEntity2 YourEntity2ID],[YourEntity2 SomeProperty3],[YourEntity2 SomeProperty4]]] \n
 *          from:[Your_ServiceMetadata_EntitySets YourEntitySet]] \n
 *          filter:[[[YourEntity2 YourEntity2ID] \n
 *          equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:\@"FilterForThis2"]))] \n
 *          or:[[YourEntity2 YourEntity2ID] \n
 *          equal:((SODataV4_DataValue*)((NSObject*)[SODataV4_StringValue of:\@"FilterForThisToo2"]))]]];
 *
 *
 *
 * // Create the batch request
 *
 * SODataV4_RequestBatch* batch = [SODataV4_RequestBatch new];
 *
 * [batch addQuery:queryYourEntityList1];
 *
 * [batch addQuery:queryYourEntityList2];
 *
 *
 *
 * // Process the batch request
 *
 * [self.service processBatch:batch];
 *
 *
 *
 * // You can get the result of your queries like this
 *
 * SODataV4_QueryResult* result1 = [batch getQueryResult:queryYourEntityList1];
 *
 * SODataV4_QueryResult* result2 = [batch getQueryResult:queryYourEntityList2];
 *
 *
 *
 * // You can print the result. The type of <EM>result1.result</EM> is based on what kind of request you have sent. In this case, it was a read type.
 *
 * NSLog(\@"%@", [result1.result toString]);
 *
 * NSLog(\@"%@", [result2.result toString]);
 *
 *
 * </CODE>
 *
 *
 * <b>You can also find useful content under your proxy generator directory/examples/oc.</b>
 *
 *
 **/

