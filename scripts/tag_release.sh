#!/usr/bin/env bash
# scripts/tag_release.sh
#
# Crea un tag anotado a partir de la versión en pubspec.yaml.
# Úsalo antes de hacer push a main cuando cambias la versión.
#
# Uso:
#   ./scripts/tag_release.sh            → crea el tag localmente
#   ./scripts/tag_release.sh --push     → crea y hace push del tag

set -euo pipefail

# ── Leer versión desde pubspec.yaml ───────────────────────────────────────────
PUBSPEC="$(dirname "$0")/../pubspec.yaml"

if [[ ! -f "$PUBSPEC" ]]; then
  echo "❌  No se encontró pubspec.yaml en $(realpath "$PUBSPEC")" >&2
  exit 1
fi

VERSION=$(grep '^version:' "$PUBSPEC" | sed 's/version:[[:space:]]*//' | tr -d '[:space:]')

if [[ -z "$VERSION" ]]; then
  echo "❌  No se pudo extraer la versión de pubspec.yaml" >&2
  exit 1
fi

TAG="v${VERSION}"

# ── Comprobar si el tag ya existe ─────────────────────────────────────────────
if git rev-parse "$TAG" >/dev/null 2>&1; then
  echo "⚠️   El tag $TAG ya existe. No se ha creado nada."
  exit 0
fi

# ── Crear tag anotado ─────────────────────────────────────────────────────────
git tag -a "$TAG" -m "Release ${TAG}"
echo "✅  Tag $TAG creado localmente."

# ── Push opcional ─────────────────────────────────────────────────────────────
if [[ "${1:-}" == "--push" ]]; then
  git push origin "$TAG"
  echo "🚀  Tag $TAG publicado en origin."
else
  echo "ℹ️   Para publicarlo: git push origin $TAG"
  echo "    O ejecuta:        ./scripts/tag_release.sh --push"
fi
