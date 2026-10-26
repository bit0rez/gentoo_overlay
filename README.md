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
| `app-misc/qmd` | Гибридный поиск по Markdown и MCP-сервер tobi/qmd; модели загружаются отдельно |
| `app-misc/qmd-mcp` | OpenRC-сервис QMD MCP с общим системным индексом |
| `app-misc/rtk` | CLI-прокси, сокращающий расход токенов AI-агентов за счёт фильтрации вывода команд |
| `app-misc/zeroclaw` | CLI, TUI, веб-интерфейс и опциональное desktop-приложение ZeroClaw |
| `app-office/obsidian` | Obsidian — база знаний на основе Markdown, включая Obsidian CLI |
| `dev-db/clickhouse-client` | Клиент ClickHouse |
| `dev-db/clickhouse-common-static` | Статические компоненты ClickHouse |
| `dev-util/chatgpt-bin` | Официальное desktop-приложение ChatGPT с поддержкой Codex |
| `dev-util/codex` | Codex CLI со сборкой из исходников |
| `dev-util/codex-bin` | Готовый бинарный пакет Codex CLI из официальных GitHub Releases |
| `dev-util/github-cli` | Официальный GitHub CLI (`gh`) |
| `dev-util/openknowledge-bin` | OpenKnowledge: проверка и поиск знаний в Git, MCP runtime; команды `openknowledge` и `okn` |
| `dev-util/sourcecraft-cli` | CLI платформы SourceCraft (`src`) |
| `media-sound/yandex-music` | Официальное desktop-приложение Яндекс Музыки |
| `net-im/ktalk` | Desktop-приложение Контур.Толк |
| `net-im/max` | Официальное desktop-приложение MAX |
| `net-misc/restish` | CLI для REST API с поддержкой OpenAPI |
| `net-proxy/tun2socks` | Перенаправление трафика TUN-интерфейса через прокси в userspace |
| `virtual/codex` | Выбор бинарного Codex CLI или сборки из исходников через USE-флаг `binary` |

Системные пользователь и группа для QMD устанавливаются автоматически через
`acct-user/qmd` и `acct-group/qmd`.

## Подключение

Установите `eselect-repository`, если он ещё не установлен:

```sh
emerge --ask app-eselect/eselect-repository
```

Добавьте репозиторий из одного из источников и синхронизируйте его. GitHub:

```sh
eselect repository add bit0rez git \
  https://github.com/bit0rez/gentoo_overlay.git
emaint sync -r bit0rez
```

Или SourceCraft:

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
emerge --ask dev-util/openknowledge-bin
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

`dev-util/openknowledge-bin` устанавливает готовые бинарники OpenKnowledge
для `amd64` и `arm64` со стабильными keyword'ами. Доступны две команды:
`openknowledge` и его алиас `okn`. Проверить версию и начать настройку базы
знаний можно так:

```sh
okn version
okn setup
```

Документация и уведомления о лицензиях устанавливаются в
`/usr/share/doc/openknowledge-bin-<версия>/`.

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
Java, Python, SQL, YAML, Ruby, C#, Scala, PHP, Swift, Zig, PowerShell,
Elixir, Objective-C, Julia, Verilog, Fortran и Groovy. Запустить MCP-сервер
для готового графа можно так:

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
в `/etc/portage/package.use`. Пакеты доступны со стабильными keyword'ами
`amd64` и `arm64`. Актуальный бинарный пакет требует glibc >= 2.28 для
голосового компонента; начиная с 0.163.0 zsh в него не входит. Исходная и
бинарная реализации конфликтуют, поскольку устанавливают одинаковые
команды и каталог ресурсов.

Если реализация ранее была установлена напрямую и записана в `@world`,
перед переходом на виртуальный пакет уберите её из выбранных пакетов:

```sh
emerge --deselect dev-util/codex dev-util/codex-bin
emerge --ask virtual/codex
```

`--deselect` не удаляет установленный пакет; Portage заменит конфликтующую
реализацию при установке выбранного варианта через `virtual/codex`.

## QMD MCP

Начиная с 2.8.3 пакет использует `tobi/qmd`. Прежний Rust-пакет
`qntx-labs/qmd` имеет другой формат конфигурации и индекса: коллекции нужно
добавить заново и переиндексировать. Автоматической миграции нет; старое
состояние сохраняется.

Обычный CLI использует XDG-каталоги вызывающего пользователя. OpenRC-сервис
работает от пользователя `qmd` и хранит отдельное состояние в
`/var/lib/qmd/tobi`. Модели не включены в пакет: их загружает `qmd pull`.
В overlay поставляется CPU-бэкенд для `amd64` с glibc.

После установки `app-misc/qmd-mcp` создайте каталоги от root и откройте
оболочку пользователя сервиса:

```sh
install -d -o qmd -g qmd -m 0770 /var/lib/qmd/tobi/cache \
  /var/lib/qmd/tobi/config/qmd
su -s /bin/sh qmd
```

В этой оболочке задайте окружение сервиса и подготовьте индекс. Пользователь
`qmd` должен иметь доступ на чтение к выбранным документам:

```sh
export XDG_CACHE_HOME=/var/lib/qmd/tobi/cache
export XDG_CONFIG_HOME=/var/lib/qmd/tobi/config
export QMD_CONFIG_DIR=/var/lib/qmd/tobi/config/qmd
cd /var/lib/qmd/tobi
qmd collection add /absolute/path/to/documents --name documents
qmd pull
qmd embed
qmd status
exit
```

От root проверьте настройки сервиса и запустите его:

```sh
${EDITOR} /etc/conf.d/qmd-mcp
rc-update add qmd-mcp default
rc-service qmd-mcp start
```

MCP endpoint по умолчанию — `http://127.0.0.1:8181/mcp`.
В новой конфигурации `QMD_EMBED_MODEL` заменяет прежний `QMD_MODEL_PATH`.
При обновлении проверьте изменения CONFIG_PROTECT в `/etc/conf.d/qmd-mcp`;
пакет не перезапускает сервис автоматически. Подробности миграции находятся
в `/usr/share/doc/qmd-mcp-<версия>/README.Gentoo*`.

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
