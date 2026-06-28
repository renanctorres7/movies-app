# Movies App

App Flutter de busca de filmes usando a [API do TMDB](https://developers.themoviedb.org/3), construído com **Clean Architecture**, **GetIt**, **GetX** e testes unitários por camada.

## Estrutura do repositório

```
movies-app/          ← repositório Git (origin: renanctorres7/movies-app)
├── movies/          ← app Flutter
├── .vscode/
└── README.md
```

> A pasta `agenda-consultorio/` acima é apenas um diretório local de organização — o Git está em `movies-app/`.

## Configuração

```bash
cd movies
cp dart_defines.example.json dart_defines.json
# Edite dart_defines.json com sua chave TMDB
flutter pub get
flutter run --dart-define-from-file=dart_defines.json
```

## Testes

```bash
cd movies
flutter analyze --no-fatal-infos
flutter test
```

## Pré-requisitos nativos

- Flutter stable recente (Dart 3.3+)
- **Android:** JDK 17, Android SDK compatível com Gradle 8 / AGP 8
- **iOS:** Xcode com deployment target **13.0+**; o app usa **UIScene lifecycle** (`FlutterImplicitEngineDelegate`)

## Build nativo (verificação)

```bash
cd movies
flutter build apk --dart-define-from-file=dart_defines.json
flutter build ios --no-codesign --dart-define-from-file=dart_defines.json
```

## Arquitetura

- `domain/` — entities, failures, use cases, contratos
- `infra/` — models, repositories, contratos de datasource
- `external/` — TMDB HTTP, config, image builder
- `presenter/` — pages, widgets, store (GetX)
- `core/` — DI (GetIt), rotas, tema

## Decisões técnicas

- `Either<Failure, T>` para erros funcionais
- Models com `toEntity()` — separação JSON/domain
- `ImageUrlBuilder` — presenter desacoplado de endpoints TMDB
- `MovieDetailsArgs` — navegação via argumentos de rota
