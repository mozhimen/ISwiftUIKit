# SwiftUI CachedAsyncImage 🗃️

“CachedAsyncImage”就是“AsyncImage”，只不过它具备缓存功能。


## Usage

`CachedAsyncImage` 的 API 和行为与 `AsyncImage` 完全相同，所以您只需将此处的内容修改一下即可：
```swift
AsyncImage(url: logoURL)
```
to this:
```swift
CachedAsyncImage(url: logoURL)
```

除了 `AsyncImage` 的初始化方法之外，您还可以指定要使用的缓存（默认情况下使用的是 `URLCache.shared`），并且可以使用 `URLRequest` 而不是 `URL` ：
```swift
CachedAsyncImage(urlRequest: logoURLRequest, urlCache: .imageCache)
```

```swift
// URLCache+imageCache.swift

extension URLCache {
    
    static let imageCache = URLCache(memoryCapacity: 512_000_000, diskCapacity: 10_000_000_000)
}
```

还记得在设置缓存时的情况吗？在（这里指的是我们的图像）设置响应内容时，其大小必须不超过磁盘缓存大小的约 5%（请参阅[此讨论](https://developer.apple.com/documentation/foundation/nsurlsessiondatadelegate/1411612-urlsession#discussion)）。

## Installation

1. 在 Xcode 中，打开您的项目，然后点击“文件”菜单，选择“Swift 包” → “添加包依赖项...”2. 粘贴存储库网址（“”），然后点击“下一步”。3. 点击“完成”。
