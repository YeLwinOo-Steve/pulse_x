### Pulse-X State Management
----

![Pulse-X Logo](assets/pulse_x_long.png)

- [Why Pulse-X?](#why-Pulse-x?)
- [Documentation](#documentation)
- [Example](#example)
- [Installing Pulse-X](#installing-Pulse-x)
- [Features](#features)
- [Usage](#usage)


# Why Pulse-X?

### **Pulse-X** is a light weight state management solution for your Flutter project. 

#### **🏹 Pulse-X's 3 Main Targets**

### 🚀   PRODUCTIVITY       |       ⚖️   SCALABILITY       |       🧩   MODULARITY


> **🎯** **PRODUCTIVITY**
> 
> **Pulse-X** is aimed to help you make your productivity high. It's intuitive and it won't take you long to build MVVM structure. You can write cleaner, more structural and more maintainable code.

> 🎯 **SCALABILITY**
> 
> **Pulse-X** is here to make your program's architecture highly scalable. You can easily make layer based architecture or feature based architecture. You can add new features or remove old features without worrying much about code duplication and complexity.

> 🎯**MODULARITY**
> 
> **Without Modules,** you can get headache and will probably end up in writing spaghetti code. Modules are easily attachable, detachable and switchable. But making modules isn't an easy task. But don't worry! **Pulse-X** will reduce your burden a lot. **Pulse-X** has built-in service locator. Therefore, you can inject your view models on your need so that your code can become less coupling and more cohesive. Pretty easy, right? 😉


# Documentation

> For more complete documentation, you can  read here👉🏻 [Pulse-X Documentation](https://ye-lwin-oo-1.gitbook.io/pulse-x-state-management/)


# Example

> Source code of this example project can be found in `example` folder. More and more examples are coming....

![Pulse-X Example](assets/pulse_example.gif)

# Installing Pulse-X

##### 🚧🚧 Currently, Pulse-X is under construction. 

### To use [Pulse-X from Pub](https://pub.dev/packages/pulse_x),

### Depend on it

Run this command:

With Flutter:

```shell
 $ flutter pub add pulse_x
```

This will add a line like this to your package's `pubspec.yaml` (and run an implicit `flutter pub get`):

```yaml
dependencies:
  pulse_x: ^1.0.2
```

Alternatively, your editor might support `flutter pub get`. Check the docs for your editor to learn more.

##### Import it

Now in your Dart code, you can use:

```dart
import 'package:pulse_x/pulse_x.dart';
```


##### If you wanna manually use it from GitHub. Here's the guide.

> In your project's `pubspec.yaml` file, under `dependencies:` section, use like this.

```yaml
dependencies:
    pulse_x:
    git:
      url: https://github.com/YeLwinOo-Steve/pulse_x.git
      ref: master # master branch
```

# Features

#### __Pulse-X__ is mainly composed of ( 5 ) features.

1. 💡 Simple Data Management
2. 🌊 Stream Management
3. 🔮 Future data Management
4. 💉 Dependency Injection (DI)
5. 🧭 Navigator

## Usage

### 1. Simple data management

##### 🎢 Iteratable data management
- 📃 Documentation → https://ye-lwin-oo-1.gitbook.io/Pulse-X-state-management/state-management/collection-data
- 👾 Example → https://github.com/YeLwinOo-Steve/rand_user

##### 🌊 Stream data management
- 📃 Documentation → https://ye-lwin-oo-1.gitbook.io/Pulse-X-state-management/state-management/stream-data
- 👾 Example → https://github.com/YeLwinOo-Steve/stream_time

##### 🔮 Future data management
- 📃 Documentation → https://ye-lwin-oo-1.gitbook.io/Pulse-X-state-management/state-management/future-data
- 👾 Example → https://github.com/YeLwinOo-Steve/posts


### 🚧 This documentation is under construction!! More are coming...
