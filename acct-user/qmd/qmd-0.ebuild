# Copyright 2026 Ilya Merkulov
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit acct-user

DESCRIPTION="Service user for QMD"
ACCT_USER_ID=-1
ACCT_USER_HOME=/var/lib/qmd
ACCT_USER_HOME_PERMS=0770
ACCT_USER_GROUPS=( qmd )

acct-user_add_deps
