# Contributing to Shad UI Flutter

Thank you for your interest in contributing to Shad UI Flutter! This document provides guidelines and information for contributors.

## 🤝 How to Contribute

### Reporting Issues

Before creating an issue, please:

1. **Search existing issues** to see if your problem has already been reported
2. **Check the documentation** to ensure you're using the component correctly
3. **Provide a minimal reproduction** - create a simple example that demonstrates the issue

When creating an issue, please include:

- **Flutter version** (`flutter --version`)
- **Package version** (from `pubspec.lock`)
- **Platform** (iOS, Android, Web, Desktop)
- **Steps to reproduce**
- **Expected behavior**
- **Actual behavior**
- **Screenshots** (if applicable)

### Feature Requests

We welcome feature requests! Please:

1. **Search existing issues** to see if the feature has already been requested
2. **Explain the use case** - why is this feature needed?
3. **Provide examples** - how would you use this feature?
4. **Consider alternatives** - is there already a way to achieve this?

### Pull Requests

We love pull requests! Here's how to contribute:

#### 1. Fork and Clone

```bash
git clone https://github.com/your-username/shad_ui_flutter.git
cd shad_ui_flutter
```

#### 2. Create a Branch

```bash
git checkout -b feature/your-feature-name
# or
git checkout -b fix/your-fix-name
```

#### 3. Make Your Changes

- Follow the existing code style and patterns
- Add tests for new functionality
- Update documentation if needed
- Ensure all tests pass

#### 4. Test Your Changes

```bash
# Run tests
flutter test

# Run the example app
cd example
flutter run

# Check for linting issues
flutter analyze
```

#### 5. Commit Your Changes

Use conventional commit messages:

```
feat: add new component
fix: resolve issue with button
docs: update README
test: add tests for component
refactor: improve code structure
```

#### 6. Push and Create PR

```bash
git push origin feature/your-feature-name
```

Then create a pull request on GitHub.

## 📋 Development Guidelines

### Code Style

- Follow the existing code style and patterns
- Use meaningful variable and function names
- Add comments for complex logic
- Keep functions small and focused
- Use proper TypeScript/Flutter types

### Component Guidelines

When creating new components:

1. **Follow the existing pattern** - look at similar components
2. **Include all variants** - default, outline, ghost, etc.
3. **Add size options** - sm, md, lg
4. **Support theming** - use ShadTheme tokens
5. **Add animations** - smooth transitions
6. **Ensure accessibility** - proper semantics
7. **Create comprehensive demos** - showcase all features

### Testing

- Write unit tests for component logic
- Write widget tests for component behavior
- Test all variants and states
- Test accessibility features
- Test responsive behavior

### Documentation

- Add dartdoc comments to all public APIs
- Update README.md if needed
- Add examples to the demo app
- Update CHANGELOG.md for new features

## 🏗️ Project Structure

```
shad_ui_flutter/
├── lib/
│   ├── src/
│   │   ├── components/     # All UI components
│   │   ├── theme/         # Theme system
│   │   └── tokens/        # Design tokens
│   └── shad_ui_flutter.dart  # Main export file
├── example/               # Demo app
├── test/                 # Tests
├── README.md             # Package documentation
├── CHANGELOG.md          # Version history
├── LICENSE               # MIT License
└── CONTRIBUTING.md       # This file
```

## 🚀 Getting Started

### Prerequisites

- Flutter 3.19+
- Dart 3.8+
- Git

### Setup

1. **Clone the repository**

   ```bash
   git clone https://github.com/your-username/shad_ui_flutter.git
   cd shad_ui_flutter
   ```

2. **Install dependencies**

   ```bash
   flutter pub get
   ```

3. **Run tests**

   ```bash
   flutter test
   ```

4. **Run the example app**
   ```bash
   cd example
   flutter run
   ```

## 📝 Commit Message Format

We use [Conventional Commits](https://www.conventionalcommits.org/):

- `feat:` - New features
- `fix:` - Bug fixes
- `docs:` - Documentation changes
- `style:` - Code style changes (formatting, etc.)
- `refactor:` - Code refactoring
- `test:` - Adding or updating tests
- `chore:` - Maintenance tasks

## 🎯 Areas for Contribution

We're always looking for help with:

- **New components** - Check the roadmap
- **Bug fixes** - Look at open issues
- **Documentation** - Improve examples and guides
- **Tests** - Add more test coverage
- **Performance** - Optimize existing components
- **Accessibility** - Improve a11y features

## 📞 Questions?

- **Issues**: [GitHub Issues](https://github.com/your-username/shad_ui_flutter/issues)
- **Discussions**: [GitHub Discussions](https://github.com/your-username/shad_ui_flutter/discussions)
- **Email**: support@shadui.dev

## 🙏 Thank You

Thank you for contributing to Shad UI Flutter! Your contributions help make this library better for everyone.
