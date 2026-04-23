#!/usr/bin/env bash
# One-time (or rare) admin: writes the Vault policy "secrets-full-admin".
# Requires: vault CLI, valid token (e.g. vault login), and VAULT_ADDR / VAULT_NAMESPACE.
# Do not put this in ~/.profile or shell rc files.
set -euo pipefail

vault policy write secrets-full-admin - <<'EOF'
path "lynx/data/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

path "lynx/metadata/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}
EOF
