# bit0rez Gentoo Overlay

Персональный Gentoo-оверлей с пакетами, которых нет в основном дереве Gentoo,
или с более свежими версиями приложений.

Это неофициальный репозиторий. Ebuild-файлы для сторонних приложений не
поддерживаются Gentoo или разработчиками этих приложений.

## Пакеты

| Пакет | Описание |
| --- | --- |
| `app-misc/agent-lsp` | MCP-сервер, объединяющий языковые серверы в рабочие процессы для AI-агентов |
| `app-misc/beads` | Распределённый issue tracker и постоянная память для AI-агентов |
| `app-misc/graphify` | Локальный граф знаний и MCP-сервер по исходному коду и документации |
| `app-misc/qmd` | Локальный поисковый движок и MCP-сервер для AI-агентов; включает модель EmbeddingGemma |
| `app-misc/qmd-mcp` | OpenRC-сервис QMD MCP с общим системным индексом |
| `app-misc/zeroclaw` | CLI, TUI, веб-интерфейс и опциональное desktop-приложение ZeroClaw |
| `dev-db/clickhouse-client` | Клиент ClickHouse |
| `dev-db/clickhouse-common-static` | Статические компоненты ClickHouse |
| `dev-util/chatgpt-bin` | Официальное desktop-приложение ChatGPT с поддержкой Codex |
| `dev-util/codex` | Codex CLI со сборкой из исходников |
| `dev-util/codex-bin` | Готовый бинарный пакет Codex CLI из официальных GitHub Releases |
| `media-sound/yandex-music` | Официальное desktop-приложение Яндекс Музыки |
| `net-im/max` | Официальное desktop-приложение MAX |
| `net-proxy/tun2socks` | Перенаправление трафика TUN-интерфейса через прокси в userspace |
| `virtual/codex` | Выбор бинарного Codex CLI или сборки из исходников через USE-флаг `binary` |

Системные пользователь и группа для QMD устанавливаются автоматически через
`acct-user/qmd` и `acct-group/qmd`.

## Подключение

Установите `eselect-repository`, если он ещё не установлен:

```sh
emerge --ask app-eselect/eselect-repository
```

Добавьте репозиторий и синхронизируйте его:

```sh
eselect repository add bit0rez git \
  https://github.com/bit0rez/gentoo_overlay.git
emaint sync -r bit0rez
```

```sh
eselect repository add bit0rez git \
  https://git@git.sourcecraft.dev/bit0rez/gentoo-overlay.git
emaint sync -r bit0rez
```

Проверить подключение можно командой:

```sh
eselect repository list
```

## Установка

Например:

```sh
emerge --ask app-misc/agent-lsp
emerge --ask app-misc/beads
emerge --ask app-misc/graphify
emerge --ask app-misc/qmd
emerge --ask app-misc/qmd-mcp
emerge --ask app-misc/zeroclaw
emerge --ask dev-util/chatgpt-bin
emerge --ask media-sound/yandex-music
emerge --ask net-im/max
emerge --ask net-proxy/tun2socks
```

`app-misc/agent-lsp` устанавливает MCP-сервер, но не сами языковые серверы.
Установите нужные серверы для своих языков, затем запустите настройку:

```sh
agent-lsp init
agent-lsp doctor
```

Перед запуском `net-proxy/tun2socks` укажите прокси и параметры TUN-интерфейса
в `/etc/tun2socks/config.yaml`. Затем добавьте сервис в автозагрузку и запустите
его:

```sh
rc-update add tun2socks default
rc-service tun2socks start
```

По умолчанию используется `socks5://127.0.0.1:1080`. Сервис не изменяет
системные маршруты, если команды настройки маршрутизации не заданы явно.

`app-misc/graphify` устанавливает локальный CLI, MCP-сервер и грамматические
модули tree-sitter для Go, Rust, TypeScript, Lua, JavaScript, Kotlin, C, C++,
Java, Python, SQL и YAML. Запустить MCP-сервер для готового графа можно так:

```sh
graphify-mcp graphify-out/graph.json --transport stdio
```

ZeroClaw Desktop доступен на `amd64` с glibc и устанавливается с USE-флагом
`desktop`:

```sh
USE=desktop emerge --ask app-misc/zeroclaw
```

Стабильные keyword'ы определены непосредственно в ebuild. Для архитектур,
помеченных `~arch`, потребуется соответствующая запись в
`/etc/portage/package.accept_keywords`.

Для Codex CLI установите `virtual/codex`. По умолчанию включён USE-флаг
`binary`, выбирающий `dev-util/codex-bin`; `-binary` выбирает `dev-util/codex`:

```sh
emerge --ask virtual/codex
USE="-binary" emerge --ask virtual/codex
```

Для постоянного выбора сборки из исходников добавьте `virtual/codex -binary`
в `/etc/portage/package.use`. Пакеты доступны с keyword'ами `~amd64` и
`~arm64`. Полный бинарный пакет требует glibc >= 2.38 для включённых
голосового компонента и zsh. Исходная и бинарная реализации конфликтуют,
поскольку устанавливают одинаковые команды и каталог ресурсов.

Если реализация ранее была установлена напрямую и записана в `@world`,
перед переходом на виртуальный пакет уберите её из выбранных пакетов:

```sh
emerge --deselect dev-util/codex dev-util/codex-bin
emerge --ask virtual/codex
```

`--deselect` не удаляет установленный пакет; Portage заменит конфликтующую
реализацию при установке выбранного варианта через `virtual/codex`.

## QMD MCP

QMD хранит общий индекс, конфигурацию и модель в `/var/lib/qmd`. Для выполнения
административных команд используйте системного пользователя `qmd`:

```sh
doas -u qmd qmd status
```

После установки `app-misc/qmd-mcp` проверьте настройки сервиса:

```sh
${EDITOR} /etc/conf.d/qmd-mcp
```

Затем добавьте сервис в автозагрузку и запустите его:

```sh
rc-update add qmd-mcp default
rc-service qmd-mcp start
```

По умолчанию MCP-сервер слушает `127.0.0.1:8181`.

## Обновление

Чтобы получить новые версии пакетов:

```sh
emaint sync -r bit0rez
emerge --ask --update --deep --newuse @world
```

## Разработка

После добавления или обновления ebuild пересоздайте `Manifest` пакета:

```sh
ebuild category/package/package-version.ebuild manifest
```

Оверлей публикует metadata cache в формате `md5-dict`. После изменения ebuild
обновите cache и запустите проверки:

```sh
egencache --repo=bit0rez --update
pkgcheck scan
git diff --check
```

## Лицензии

Каждый пакет распространяется на условиях лицензии соответствующего upstream.
Актуальное значение указано в поле `LICENSE` его ebuild.
