// The Swift Programming Language
// https://docs.swift.org/swift-book
import SwiftUI
/// 一种能够异步加载、缓存并显示图片的视图。
///
/// 此视图使用了自定义默认设置。
/// <doc://com.apple.documentation/documentation/Foundation/URLSession>
/// 实例：从指定的 URL 加载一张图片，然后将其显示出来。
/// 例如，您可以显示存储在服务器上的图标：
///
///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png"))
///         .frame(width: 200, height: 200)
///
/// 在图像加载完成之前，视图会显示一个标准的占位符，以填充可用空间。当加载过程成功完成之后，视图会更新以显示图像。在上述示例中，图标比框架小，因此看起来比占位符小。
/// ![一幅图示，左侧是一个灰色的方框，右侧是 SwiftUI 图标，图中有一条从第一个图标指向第二个图标的箭头。该图标大小约为灰色方框的一半。](AsyncImage-1)
///
/// 您可以使用以下方式指定一个自定义占位符：
/// ``init(url:urlCache:scale:content:placeholder:)``. .使用这个初始化器，您还可以
/// 使用 `content` 参数来操作加载的图像。
/// 例如，您可以添加一个修饰符来使加载的图像具有可调整大小的功能：
///
///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { image in
///         image.resizable()
///     } placeholder: {
///         ProgressView()
///     }
///     .frame(width: 50, height: 50)
///
/// 在此示例中，SwiftUI 首先展示一个“进度视图”，然后是经过缩放以适应指定框架的图像：
///
/// ![一幅图示，左侧为进度视图，右侧为 SwiftUI 图标，且有一条箭头从第一个位置指向第二个位置。](AsyncImage-2)
///
/// > 重要提示：您无法应用针对特定图像的修饰功能，例如
/// ``Image/resizable(capInsets:resizingMode:)``, 直接将它们传递给“缓存异步图像”。
/// 实际上，应将其应用于在定义视图外观时由“内容”闭包获取的“图像”实例上。
///
/// 为了更好地掌控装载过程，请使用
/// ``init(url:urlCache:scale:transaction:content:)``
/// 初始化器，它接受一个名为“content”的闭包，该闭包接收一个“AsyncImagePhase”对象，用于指示加载操作的状态。返回一个合适的视图。
///
///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { phase in
///         if let image = phase.image {
///             image // Displays the loaded image.
///         } else if phase.error != nil {
///             Color.red // Indicates an error.
///         } else {
///             Color.blue // Acts as a placeholder.
///         }
///     }
///
@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
public struct CachedAsyncImage<Content:View>: View{
    
    @State private var phase: AsyncImagePhase
    private let urlRequest: URLRequest?
    private let urlSession: URLSession
    private let scale: CGFloat
    private let transaction: Transaction
    private let content: (AsyncImagePhase) -> Content
    
    //=================================================================>
    
    public var body: some View {
        content(phase)
            .task(id: urlRequest, load)
    }
    
    //=================================================================>
    
    /// 初始化并显示来自指定 URL 的图像。
    ///
    /// 在图像加载完成之前，SwiftUI 会显示一个默认的占位图。当
    /// 加载操作成功完成后，SwiftUI 会更新视图以显示加载的图像。如果操作失败，SwiftUI 仍会继续显示占位图。以下示例从示例服务器加载并显示一个图标：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png"))
    ///
    /// 如果您想要自定义占位符或为加载的图像应用特定于图像的修饰符（例如“Image/resizable(capInsets：resizingMode:)”）的话，应使用“init(url：scale：content：placeholder:)”初始化器来实现。
    ///
    /// - Parameters:
    ///   - url: 要显示的图片的 URL 。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    public init(url: URL?, urlCache: URLCache = .shared,  scale: CGFloat = 1) where Content == Image {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale)
    }
    
    /// 从指定的 URL 加载并显示一张图片。
    ///
    /// 在图像加载完成之前，SwiftUI 会显示一个默认的占位图。当
    /// 加载操作成功完成后，SwiftUI 会更新视图以显示加载的图像。如果操作失败，SwiftUI 仍会继续显示占位图。以下示例从示例服务器加载并显示一个图标：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png"))
    ///
    /// 如果您想要自定义占位符或为加载的图像应用特定于图像的修饰符（例如“Image/resizable(capInsets：resizingMode:)”）的话，应使用“init(url：scale：content：placeholder:)”初始化器来实现。
    ///
    /// - Parameters:
    ///   - urlRequest: 要显示的图像的 URL 请求。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    public init(urlRequest: URLRequest?, urlCache: URLCache = .shared,  scale: CGFloat = 1) where Content == Image {
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale) { phase in
#if os(macOS)
            phase.image ?? Image(nsImage: .init())
#else
            phase.image ?? Image(uiImage: .init())
#endif
        }
    }
    
    /// 从指定的 URL 加载并显示一张可修改的图片，加载过程中会使用一个自定义占位符。
    ///
    /// 在图像加载完成之前，SwiftUI 会显示您指定的占位视图。当加载操作成功完成时，SwiftUI 会更新视图以显示您指定的内容，这些内容是您使用加载的图像创建的。例如，您可以先显示一个绿色的占位图，然后显示加载图像的拼接版本：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { image in
    ///         image.resizable(resizingMode: .tile)
    ///     } placeholder: {
    ///         Color.green
    ///     }
    ///
    /// 如果加载操作失败，SwiftUI 仍会显示
    /// 该占位符。若要能够在出现加载错误时显示不同的视图，请使用 ``init(url:scale:transaction:content:)`` 构造函数替代。
    ///
    /// - Parameters:
    ///   - url: 要显示的图片的 URL 。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    ///   - content: 一个闭包会将加载的图像作为输入，并
    ///     返回要显示的视图。您可以直接返回图像，或者
    ///     在返回之前根据需要对其进行修改。
    ///   - placeholder: 一个闭包会在加载操作成功完成之前一直显示该视图。
    public init<I, P>(url: URL?, urlCache: URLCache = .shared,  scale: CGFloat = 1, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, content: content, placeholder: placeholder)
    }
    
    /// 从指定的 URL 加载并显示一张可修改的图片，加载过程中会使用一个自定义占位符。
    ///
    /// 一个闭包会在加载操作成功完成之前将视图显示出来。在图像加载之前，SwiftUI 会显示您指定的占位视图。当加载操作成功完成时，SwiftUI 会更新视图以显示您指定的内容，该内容是使用加载的图像创建的。例如，您可以先显示一个绿色的占位视图，然后显示加载图像的拼接版本：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { image in
    ///         image.resizable(resizingMode: .tile)
    ///     } placeholder: {
    ///         Color.green
    ///     }
    ///
    /// 如果加载操作失败，SwiftUI 仍会显示
    /// 该占位符。若要能够在出现加载错误时显示不同的视图，请使用 ``init(url:scale:transaction:content:)`` 构造函数替代。
    ///
    /// - Parameters:
    ///   - urlRequest: 要显示的图像的 URL 请求。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    ///   - content: 一个闭包会将加载的图像作为输入，并
    ///     返回要显示的视图。您可以直接返回图像，或者
    ///     在返回之前根据需要对其进行修改。
    ///   - placeholder: 一个闭包会在加载操作成功完成之前一直显示该视图。
    public init<I, P>(urlRequest: URLRequest?, urlCache: URLCache = .shared,  scale: CGFloat = 1, @ViewBuilder content: @escaping (Image) -> I, @ViewBuilder placeholder: @escaping () -> P) where Content == _ConditionalContent<I, P>, I : View, P : View {
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale) { phase in
            if let image = phase.image {
                content(image)
            } else {
                placeholder()
            }
        }
    }
    
    /// 分阶段从指定的 URL 加载并显示可修改的图像。
    ///
    /// 如果将异步图像的 URL 设为 `nil`，或者在设置 URL 后但在加载操作完成之前进行设置，那么该阶段的值为 `empty`。在操作完成后，该阶段的值会变为 `failure(_:)` 或 `success(_:)` 中的一种。在第一种情况下，该阶段的 `AsyncImagePhase/error` 属性表示失败的原因。在第二种情况下，该阶段的 `AsyncImagePhase/image` 属性包含加载的图像。利用该阶段来驱动 `content` 封闭式的输出，该封闭式定义了视图的外观：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { phase in
    ///         if let image = phase.image {
    ///             image // Displays the loaded image.
    ///         } else if phase.error != nil {
    ///             Color.red // Indicates an error.
    ///         } else {
    ///             Color.blue // Acts as a placeholder.
    ///         }
    ///     }
    ///
    /// 若要当更改 URL 时添加过渡效果，请为“CachedAsyncImage”应用一个标识符。
    ///
    /// - Parameters:
    ///   - url: 要显示的图片的 URL 。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    ///   - transaction: 当阶段发生变化时所应采用的交易方式。
    ///   - content: 一个闭包会将加载阶段作为输入参数，并
    /// 返回针对指定阶段应显示的视图。
    public init(url: URL?, urlCache: URLCache = .shared, scale: CGFloat = 1, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let urlRequest = url == nil ? nil : URLRequest(url: url!)
        self.init(urlRequest: urlRequest, urlCache: urlCache, scale: scale, transaction: transaction, content: content)
    }
    
    /// 一个闭包接收加载阶段作为输入，
    /// 并返回用于指定加载项的要显示的视图，同时以阶段形式显示来自指定 URL 的可修改图像。
    ///
    /// 如果将异步图像的 URL 设为 `nil`，或者在设置 URL 后但在加载操作完成之前进行设置，那么该阶段的值为 `empty`。在操作完成后，该阶段的值会变为 `failure(_:)` 或 `success(_:)` 中的一种。在第一种情况下，该阶段的 `AsyncImagePhase/error` 属性表示失败的原因。在第二种情况下，该阶段的 `AsyncImagePhase/image` 属性包含加载的图像。利用该阶段来驱动 `content` 封闭式的输出，该封闭式定义了视图的外观：
    ///
    ///     CachedAsyncImage(url: URL(string: "https://example.com/icon.png")) { phase in
    ///         if let image = phase.image {
    ///             image // Displays the loaded image.
    ///         } else if phase.error != nil {
    ///             Color.red // Indicates an error.
    ///         } else {
    ///             Color.blue // Acts as a placeholder.
    ///         }
    ///     }
    ///
    /// To add transitions when you change the URL, apply an identifier to the
    /// ``CachedAsyncImage``.
    ///
    /// - Parameters:
    ///   - urlRequest: 要显示的图像的 URL 请求。
    ///   - urlCache: 该 URL 缓存用于为会话中的请求提供缓存响应。
    ///   - scale: 用于该图像的缩放比例。默认值为“1”。设定一个
    /// 当加载专为更高分辨率屏幕设计的图像时，会有不同的值。例如，对于存储在磁盘上的图像，如果要以“@2x”后缀命名，就将其值设为 2 。
    ///   - transaction: 当阶段发生变化时所应采用的交易方式。
    ///   - content: 一个闭包会将加载阶段作为输入参数，并
    /// 返回针对指定阶段应显示的视图。
    public init(urlRequest: URLRequest?, urlCache: URLCache = .shared, scale: CGFloat = 1, transaction: Transaction = Transaction(), @ViewBuilder content: @escaping (AsyncImagePhase) -> Content) {
        let configuration = URLSessionConfiguration.default
        configuration.urlCache = urlCache
        self.urlRequest = urlRequest
        self.urlSession =  URLSession(configuration: configuration)
        self.scale = scale
        self.transaction = transaction
        self.content = content
        
        self._phase = State(wrappedValue: .empty)
        do {
            if let urlRequest = urlRequest, let image = try getImage_cached(from: urlRequest, cache: urlCache) {
                self._phase = State(wrappedValue: .success(image))
            }
        } catch {
            self._phase = State(wrappedValue: .failure(error))
        }
    }
    
    //=================================================================>
    
    @Sendable
    private func load() async {
        do {
            if let urlRequest = urlRequest {
                let (image, metrics) = try await getImage_remote(from: urlRequest, session: urlSession)
                if metrics.transactionMetrics.last?.resourceFetchType == .localCache {
                    // WARNING: This does not behave well when the url is changed with another
                    phase = .success(image)
                } else {
                    withAnimation(transaction.animation) {
                        phase = .success(image)
                    }
                }
            } else {
                withAnimation(transaction.animation) {
                    phase = .failure(AsyncImage<Content>.LoadingError())
                }
            }
        } catch {
            withAnimation(transaction.animation) {
                phase = .failure(error)
            }
        }
    }
}

// MARK: - LoadingError

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension AsyncImage {
    
    struct LoadingError: Error {
    }
}

// MARK: - Helpers

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension CachedAsyncImage {
    private func getImage_remote(from request: URLRequest, session: URLSession) async throws -> (Image, URLSessionTaskMetrics) {
        let (data, _, metrics) = try await session.data(for: request)
        if metrics.redirectCount > 0, let lastResponse = metrics.transactionMetrics.last?.response {
            let requests = metrics.transactionMetrics.map { $0.request }
            requests.forEach(session.configuration.urlCache!.removeCachedResponse)
            let lastCachedResponse = CachedURLResponse(response: lastResponse, data: data)
            session.configuration.urlCache!.storeCachedResponse(lastCachedResponse, for: request)
        }
        return (try getImage_multiPlatform(from: data), metrics)
    }
    
    private func getImage_cached(from request: URLRequest, cache: URLCache) throws -> Image? {
        guard let cachedResponse = cache.cachedResponse(for: request) else { return nil }
        return try getImage_multiPlatform(from: cachedResponse.data)
    }
    
    private func getImage_multiPlatform(from data: Data) throws -> Image {
#if os(macOS)
        if let nsImage = NSImage(data: data) {
            return Image(nsImage: nsImage)
        } else {
            throw AsyncImage<Content>.LoadingError()
        }
#else
        if let uiImage = UIImage(data: data, scale: scale) {
            return Image(uiImage: uiImage)
        } else {
            throw AsyncImage<Content>.LoadingError()
        }
#endif
    }
}

// MARK: - AsyncImageURLSession
private class URLSessionTaskController: NSObject, URLSessionTaskDelegate,@unchecked Sendable {
    
    var metrics: URLSessionTaskMetrics?
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didFinishCollecting metrics: URLSessionTaskMetrics) {
        self.metrics = metrics
    }
}

@available(iOS 15.0, macOS 12.0, tvOS 15.0, watchOS 8.0, *)
private extension URLSession {
    
    func data(for request: URLRequest) async throws -> (Data, URLResponse, URLSessionTaskMetrics) {
        let controller = URLSessionTaskController()
        let (data, response) = try await data(for: request, delegate: controller)
        return (data, response, controller.metrics!)
    }
}
