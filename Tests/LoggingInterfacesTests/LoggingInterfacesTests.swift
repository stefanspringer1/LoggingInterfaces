import Testing
import LoggingInterfaces
#if canImport(FoundationEssentials)
import FoundationEssentials
#else
import Foundation
#endif

@Test func example() async throws {
    
    enum PrintMode: Sendable {
        case standard
        case error
    }
    
    final class MyLogger: Logger {
        
        typealias Message = String
        typealias Mode = PrintMode
        
        init() {}
        
        func log(_ message: Message, withMode mode: Mode) {
            switch mode {
            case .standard:
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
