# 📱 Crypto Market iOS App

![License: BSD](https://img.shields.io/badge/License-BSD%203--Clause-blue.svg)

## 🚀 Overview

**Crypto Market** is an iOS application that provides real-time cryptocurrency data, emulating the functionality of Apple's built-in Stocks app. Utilizing the [CoinGecko API](https://www.coingecko.com/en/api), the app offers users up-to-date information on various cryptocurrencies, including prices, market capitalization, and more.

---

## 🧩 Features

- **Real-Time Data**: Fetches live cryptocurrency prices and market data.
- **User-Friendly Interface**: Intuitive design for easy navigation and information access.
- **Customizable Watchlist**: Allows users to track their favorite cryptocurrencies.
- **Detailed Views**: Provides in-depth information on individual cryptocurrencies.

---

## 🛠️ Technologies Used

- **Swift**: Primary programming language for iOS development.
- **UIKit**: Framework for building the user interface.
- **CoinGecko API**: Source for real-time cryptocurrency data.

---

## 📂 Project Structure

```
crypto_market/
├── Crypto Market.xcodeproj      # Xcode project file
├── Crypto Market/               # Source code directory
│   ├── AppDelegate.swift        # Application lifecycle management
│   ├── ViewController.swift     # Main view controller
│   ├── Models/                  # Data models
│   ├── Views/                   # UI components
│   └── Services/                # API services
├── Assets.xcassets/             # Asset catalog
├── Info.plist                   # App configuration
└── README.md                    # Project documentation
```

---

## 🚀 Getting Started

### Prerequisites

- **Xcode 12.0** or later
- **iOS 14.0** or later

### Installation

1. **Clone the repository:**

   ```bash
   git clone https://github.com/AnakinHuang/crypto_market.git
   ```

2. **Open the project in Xcode:**

   ```bash
   open "crypto_market/Crypto Market.xcodeproj"
   ```

3. **Build and run the app:**

   - Select the desired simulator or connected device.
   - Press `Cmd + R` or click the **Run** button in Xcode.

---

## 🔑 API Integration

The app integrates with the [CoinGecko API](https://www.coingecko.com/en/api) to fetch real-time cryptocurrency data. No API key is required for basic usage, but be mindful of the rate limits imposed by CoinGecko.

---

## 📄 License

This project is licensed under the BSD 3-Clause License. See the [LICENSE](LICENSE) file for details.

---

## 👤 Author

- **Yuesong Huang** (yhu116@u.rochester.edu)

---
