# 🎬 MovieFest

MovieFest is an iOS application built with **SwiftUI** and **Xcode 14.2**, showcasing integration with **TheMovieDB API** for fetching popular movies.  
It demonstrates clean architecture, networking with **URLSession** & **Alamofire (via SPM)**, **async/await continuation**, and **dependency injection** for flexible service management.  

---

## ✨ Features

- 📌 **Popular Movies List** – Fetches and displays trending movies from TheMovieDB.  
- 🖼️ **Movie Details Page** – Detailed view with poster, title, release date, and overview.  
- 🔄 **Multiple Networking Options** – Choose between `URLSession` and `Alamofire`.  
- ⚡ **Async/Await Continuation** – Modern Swift concurrency for clean async APIs.  
- 🛠️ **Dependency Injection** – Swap networking layer without changing business logic.  
- 🗄️ **Image Caching** – System-level caching via `URLCache` (planned custom cache improvements).  

---

## 🛠️ Tech Stack

- **Language:** Swift 5.7+  
- **IDE:** Xcode 14.2  
- **Frameworks:** SwiftUI, Foundation, Alamofire (via SPM)  
- **Architecture:** MVVM with Service Abstraction  
- **Networking:**  
  - `URLSession` (native, async/await + completion)  
  - `Alamofire` (via Swift Package Manager)  

---

## 📦 Installation

1. Clone the repository:  
   ```bash
   git clone https://github.com/shivajipawar/MovieFest.git
   cd MovieFest
   ```

2. Open in **Xcode 14.2+**.  

3. Make sure you have a valid **TMDB API Key**.  
   Replace in `Constants.swift`:  

   ```swift
   enum API {
       static let baseURL = "https://api.themoviedb.org/3"
       static let apiKey = "YOUR_API_KEY"
   }
   ```

4. Build & Run ✅  

---

## 📲 Screens

### Home Screen
- Two buttons:  
  - **URLSession Mode**  
  - **Alamofire Mode**  
- Chooses networking service dynamically.  

### Movie List Screen
- Displays fetched popular movies in a list.  
- Each row includes poster, title, release date.  
- Tapping a row navigates to **Movie Details**.  

### Movie Details Screen
- Full poster image.  
- Movie title, release date, overview.  
- NavigationStack with inline title.  

---

## 🧩 Key Implementations

### 🔹 Dependency Injection for Services
```swift
protocol MovieService {
    func fetchPopularMovies(completion: @escaping (Result<[Movie], Error>) -> Void)
}

class MovieServiceImpl: MovieService { /* URLSession implementation */ }
class MovieServiceImplWithAlamofire: MovieService { /* Alamofire implementation */ }
```

Injected into ViewModel:
```swift
@StateObject private var movieVM = MoviesViewModel(
    movieService: MovieServiceImpl() // or MovieServiceImplWithAlamofire()
)
```

---

### 🔹 Continuation with Async/Await
```swift
func loadMoviesWithContinuation() async throws -> [Movie] {
    try await withCheckedThrowingContinuation { continuation in
        movieService.fetchPopularMovies { result in
            switch result {
            case .success(let movies):
                continuation.resume(returning: movies)
            case .failure(let error):
                continuation.resume(throwing: error)
            }
        }
    }
}
```

---

### 🔹 Alamofire Example
```swift
let url = "\(API.baseURL)/movie/popular?api_key=\(API.apiKey)"
AF.request(url).responseData { response in
    switch response.result {
    case .success(let data):
        // Decode manually or pass to continuation
    case .failure(let error):
        print("❌ Error: \(error)")
    }
}
```

---

### 🔹 URLSession Example
```swift
let url = URL(string: "\(API.baseURL)/movie/popular?api_key=\(API.apiKey)")!
URLSession.shared.dataTask(with: url) { data, _, error in
    if let data = data {
        let movies = try? JSONDecoder().decode(MovieResponse.self, from: data)
        completion(.success(movies?.results ?? []))
    } else if let error = error {
        completion(.failure(error))
    }
}.resume()
```

---

### 🔹 Image Caching (URLCache)
Configured in `MovieFestApp`:
```swift
let memoryCapacity = 50 * 1024 * 1024 // 50 MB
let diskCapacity = 200 * 1024 * 1024  // 200 MB
URLCache.shared = URLCache(memoryCapacity: memoryCapacity,
                           diskCapacity: diskCapacity,
                           diskPath: "MovieFestCache")
```

---

## 🚀 Roadmap

- [ ] Custom `ImageCache` with `NSCache`.  
- [ ] Offline movie persistence with CoreData.  
- [ ] Unit testing with XCTest (network stubs).  
- [ ] CI/CD pipeline setup with GitHub Actions.  

---

## 📜 License

This project is for learning/demo purposes only. API key and usage are subject to [TheMovieDB](https://www.themoviedb.org/documentation/api) policies.  
