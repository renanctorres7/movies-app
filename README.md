# Movies App

App Flutter de busca de filmes usando a [API do TMDB](https://developers.themoviedb.org/3), construído com **Clean Architecture**, **GetIt**, **flutter_bloc** e testes unitários por camada.

## Estrutura do repositório

```
movies-app/          ← repositório Git
├── movies/          ← app Flutter
├── .vscode/
└── README.md
```

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

Organização **feature-first**:

```
lib/app/
├── core/
│   ├── errors/              # FailureError, NullError, DataSourceError, DomainError, ApiError
│   ├── endpoints/           # URLs TMDB
│   ├── environments/        # apiKey via dart-define
│   ├── routes/              # MaterialApp + onGenerateRoute
│   ├── theme/
│   ├── utils/               # DI (GetIt), LoadingStatus
│   └── widgets/             # widgets universais reutilizáveis
└── features/
    ├── search/
    │   ├── domain/          # entities, repository (contratos), usecases
    │   ├── infra/           # datasources (contratos), models, repository (impl)
    │   ├── data/            # datasource TMDB (http)
    │   └── presenter/
    │       ├── components/  # UI específica da feature (search/, details/)
    │       ├── models/
    │       ├── pages/
    │       └── stores/      # SearchBloc, SearchEvent, SearchState
    └── genres/
        ├── domain/
        ├── infra/
        └── data/
```

### Camada de UI

| Pasta | Responsabilidade | Exemplos |
|-------|------------------|----------|
| `core/widgets/` | Componentes genéricos, sem Bloc | `SearchBox`, `BigPosterWidget`, `SelectableChipTabBar`, `LoadingSliver` |
| `presenter/components/` | Composição específica da feature | `SearchHeaderDelegate`, `SearchResultsSliver`, `DetailsContent` |
| `presenter/pages/` | Orquestração fina das telas | `SearchPage`, `DetailsPage` |

### Estrutura de testes

```
test/
├── mocks/                   # fixtures JSON reutilizáveis
└── app/features/
    ├── search/              # espelha domain, infra, data, presenter
    └── genres/
```

### Convenções de nomenclatura

| Artefato | Padrão | Exemplo |
|----------|--------|---------|
| Entity | `<nome>_entity.dart` | `search_results_entity.dart` |
| Repository (contrato) | `<verbo>_<substantivo>_repository.dart` | `search_by_text_repository.dart` |
| Repository (impl) | `<verbo>_<substantivo>_repository_impl.dart` | `search_by_text_repository_impl.dart` |
| Use case | `<verbo>_<substantivo>_usecase.dart` + `*UsecaseImpl` | `get_popular_movies_usecase.dart` |
| Datasource (contrato) | `infra/datasources/` | `search_by_text_datasource.dart` |
| Datasource (impl) | `data/datasource/tmdb_*` | `tmdb_search_by_text_datasource.dart` |
| Model | `extends Entity` + `fromEntity()` | `search_results_model.dart` |
| Bloc | `<feature>_bloc.dart` + event/state | `search_bloc.dart` |

### Fluxo de dados

```
Presenter (Bloc) → UseCase → Repository (domain)
                                ↓
                         RepositoryImpl (infra)
                                ↓
                         Datasource (infra contrato)
                                ↓
                         Tmdb*Datasource (data)
```

Erros funcionais via `Either<FailureError, T>` com `NullError`, `DataSourceError`, `DomainError` e `ApiError`.

## Decisões técnicas

- `Either<FailureError, T>` para erros funcionais
- Models estendem entities — sem `toEntity()` nos repositórios
- Um repository e um use case por operação
- `ImageUrlBuilder` injetado via `SearchBloc` — pages não acessam infra diretamente
- Widgets universais em `core/widgets/`; UI da feature em `presenter/components/`
- Camada `presenter/` com **flutter_bloc** para estado; navegação via `Navigator` / `onGenerateRoute`
- DI de use cases e datasources com **GetIt**; `BlocProvider` cria o `SearchBloc` por rota
