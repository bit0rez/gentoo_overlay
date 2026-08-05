# bit0rez Gentoo Overlay

Персональный Gentoo-оверлей с пакетами, которых нет в основном дереве Gentoo,
или с более свежими версиями приложений.

Это неофициальный репозиторий. Ebuild-файлы для сторонних приложений не
поддерживаются Gentoo или разработчиками этих приложений.

## Пакеты

| Пакет | Описание |
| --- | --- |
| `app-misc/qmd` | Локальный поисковый движок и MCP-сервер для AI-агентов; включает модель EmbeddingGemma |
| `app-misc/qmd-mcp` | OpenRC-сервис QMD MCP с общим системным индексом |
| `app-misc/zeroclaw` | CLI, TUI, веб-интерфейс и опциональное desktop-приложение ZeroClaw |
| `dev-db/clickhouse-client` | Клиент ClickHouse |
| `dev-db/clickhouse-common-static` | Статические компоненты ClickHouse |
| `media-sound/yandex-music` | Официальное desktop-приложение Яндекс Музыки |
| `net-im/max` | Официальное desktop-приложение MAX |

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
emerge --ask app-misc/qmd
emerge --ask app-misc/qmd-mcp
emerge --ask app-misc/zeroclaw
emerge --ask media-sound/yandex-music
emerge --ask net-im/max
```

ZeroClaw Desktop доступен на `amd64` с glibc и устанавливается с USE-флагом
`desktop`:

```sh
USE=desktop emerge --ask app-misc/zeroclaw
```

Стабильные keyword'ы определены непосредственно в ebuild. Для архитектур,
помеченных `~arch`, потребуется соответствующая запись в
`/etc/portage/package.accept_keywords`.

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
