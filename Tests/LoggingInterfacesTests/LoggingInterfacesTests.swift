import Testing
import LoggingInterfaces
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Suite struct LoggingInterfacesTests {
    
    @Test func printing() async throws {
        
        final class MyLogger: Logger {
            
            typealias Message = String
            typealias Mode = PrintMode
            
            init() {}
            
            func log(_ message: Message, withMode mode: Mode? = nil) {
                switch mode {
                case .standard, nil:
                    print(message)
                case .error:
                    FileHandle.standardError.write(Data("\(message)\n".utf8))
                }
            }
            
            func close() throws {
                // -
            }
            
        }
        
        let logger: any Logger<String,PrintMode> = MyLogger()
        
        logger.log("hello", withMode: .standard)
        logger.log("error!", withMode: .error)
        
    }
    
    @Test func indifferentPrinting() async throws {
        
        final class MyLogger: Logger {
            
            typealias Message = String
            typealias Mode = IndifferentLoggingMode
            
            init() {}
            
            func log(_ message: Message, withMode mode: Mode? = nil) {
                print(message)
            }
            
            func close() throws {
                // -
            }
            
        }
        
        let logger = MyLogger()
        
        logger.log("hello")
        logger.log("error!")
        
    }
    
    

    
}
