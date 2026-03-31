#!/usr/bin/env bash
# ============================================================
#  branch-replay.sh
#  Riporta tutti i commit di un branch su un nuovo branch,
#  partendo dal punto in cui il branch è stato creato.
# ============================================================
#
#  USO:
#    ./branch-replay.sh [opzioni]
#
#  OPZIONI:
#    -s, --source   <branch>   Branch sorgente  (obbligatorio)
#    -t, --target   <branch>   Nuovo branch destinazione (obbligatorio)
#    -b, --base     <ref>      Base da cui creare il nuovo branch
#                              (default: main)
#    -r, --remote   <nome>     Nome del remote (default: origin)
#    -P, --pattern  <regex>    Pattern obbligatorio per i nomi branch
#                              (default: "^[a-z]+/.+$"  →  tipo: ci/xxx)
#    -p, --push                Fai push del nuovo branch al remote
#    -d, --dry-run             Mostra i commit senza applicarli
#    -h, --help                Mostra questo aiuto
#
#  FORMATO BRANCH (default):
#    I nomi branch devono rispettare il pattern:  <prefisso>/<nome>
#    Esempi validi  : ci/fix-pipeline  feature/login  hotfix/crash-123
#    Esempi invalidi: mybranch  fix_thing  CI/uppercase
#    Puoi sovrascrivere il pattern con -P '...' (regex ERE bash).
#
#  ESEMPI:
#    # Replay dei commit di ci/foo su un nuovo branch ci/bar
#    ./branch-replay.sh -s ci/foo -t ci/bar
#
#    # Usa develop come base, fai push automatico
#    ./branch-replay.sh -s ci/foo -t ci/bar -b develop -p
#
#    # Pattern personalizzato: solo prefissi ci/ o deploy/
#    ./branch-replay.sh -s ci/foo -t ci/bar -P '^(ci|deploy)/.+'
#
#    # Dry-run: vedi cosa verrebbe applicato senza toccare niente
#    ./branch-replay.sh -s ci/foo -t ci/bar -d
# ============================================================

set -euo pipefail

# ── Colori ──────────────────────────────────────────────────
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

log()    { echo -e "${CYAN}[INFO]${NC}  $*"; }
ok()     { echo -e "${GREEN}[OK]${NC}    $*"; }
warn()   { echo -e "${YELLOW}[WARN]${NC}  $*"; }
err()    { echo -e "${RED}[ERROR]${NC} $*" >&2; }
die()    { err "$*"; exit 1; }

usage() {
  grep '^#  ' "$0" | sed 's/^#  //'
  exit 0
}

# ── Valori default ───────────────────────────────────────────
SOURCE_BRANCH=""
TARGET_BRANCH=""
BASE_REF="main"
REMOTE="origin"
BRANCH_PATTERN="^[a-z]+/.+"   # es: ci/xxx  feature/yyy  hotfix/zzz
DO_PUSH=false
DRY_RUN=false

# ── Parsing argomenti ────────────────────────────────────────
while [[ $# -gt 0 ]]; do
  case "$1" in
    -s|--source)  SOURCE_BRANCH="$2"; shift 2 ;;
    -t|--target)  TARGET_BRANCH="$2"; shift 2 ;;
    -b|--base)    BASE_REF="$2";      shift 2 ;;
    -r|--remote)  REMOTE="$2";        shift 2 ;;
    -P|--pattern) BRANCH_PATTERN="$2"; shift 2 ;;
    -p|--push)    DO_PUSH=true;       shift   ;;
    -d|--dry-run) DRY_RUN=true;       shift   ;;
    -h|--help)    usage ;;
    *) die "Opzione sconosciuta: $1. Usa -h per l'aiuto." ;;
  esac
done

# ── Validazione ──────────────────────────────────────────────
[[ -z "$SOURCE_BRANCH" ]] && die "Branch sorgente (-s) obbligatorio."
[[ -z "$TARGET_BRANCH" ]] && die "Branch destinazione (-t) obbligatorio."

# Controlla che siamo in un repo git
git rev-parse --git-dir &>/dev/null || die "Non sei dentro un repository git."

# ── Validazione formato branch ───────────────────────────────
validate_branch_name() {
  local branch="$1"
  local role="$2"   # "sorgente" o "destinazione"

  if [[ ! "$branch" =~ $BRANCH_PATTERN ]]; then
    err "Il branch ${role} '${branch}' non rispetta il formato richiesto."
    err "Pattern atteso : ${BRANCH_PATTERN}"
    err "Esempi validi  : ci/fix-pipeline  feature/login  hotfix/crash-123"
    err ""
    err "Usa -P '<regex>' per cambiare il pattern se necessario."
    exit 1
  fi
}

validate_branch_name "$SOURCE_BRANCH" "sorgente"
validate_branch_name "$TARGET_BRANCH" "destinazione"

# ── Fetch remote ─────────────────────────────────────────────
log "Fetch da '$REMOTE'..."
git fetch "$REMOTE" --quiet 2>/dev/null || warn "Fetch fallito, continuo con dati locali."

# ── Trova il merge-base (punto di nascita del branch) ────────
REMOTE_SOURCE="${REMOTE}/${SOURCE_BRANCH}"
REMOTE_BASE="${REMOTE}/${BASE_REF}"

# Preferisci il tracking remoto, fallback su locale
SRC_REF=$(git rev-parse --verify "$REMOTE_SOURCE" 2>/dev/null \
          || git rev-parse --verify "$SOURCE_BRANCH" \
          || die "Branch sorgente '$SOURCE_BRANCH' non trovato.")

BASE_FULL=$(git rev-parse --verify "$REMOTE_BASE" 2>/dev/null \
            || git rev-parse --verify "$BASE_REF" \
            || die "Base '$BASE_REF' non trovata.")

FORK_POINT=$(git merge-base "$BASE_FULL" "$SRC_REF" \
             || die "Impossibile trovare il fork-point tra '$BASE_REF' e '$SOURCE_BRANCH'.")

log "Fork-point trovato: ${FORK_POINT:0:10}"

# ── Raccoglie i commit dal fork-point alla cima del branch ───
# Lista in ordine cronologico (dal più vecchio al più nuovo)
mapfile -t COMMITS < <(git log --reverse --pretty=format:"%H" \
                        "${FORK_POINT}..${SRC_REF}")

TOTAL=${#COMMITS[@]}

if [[ $TOTAL -eq 0 ]]; then
  warn "Nessun commit trovato su '$SOURCE_BRANCH' rispetto a '$BASE_REF'."
  exit 0
fi

log "Trovati ${BOLD}${TOTAL}${NC} commit da applicare:"
echo ""
git log --reverse --oneline "${FORK_POINT}..${SRC_REF}" | \
  while read -r line; do echo "   • $line"; done
echo ""

# ── Dry-run: esce qui ────────────────────────────────────────
if $DRY_RUN; then
  warn "Modalità DRY-RUN: nessuna modifica effettuata."
  exit 0
fi

# ── Controlla che il branch destinazione non esista già ──────
if git rev-parse --verify "$TARGET_BRANCH" &>/dev/null || \
   git rev-parse --verify "${REMOTE}/${TARGET_BRANCH}" &>/dev/null; then
  die "Il branch '$TARGET_BRANCH' esiste già. Scegli un altro nome o eliminalo prima."
fi

# ── Crea il nuovo branch dalla base ─────────────────────────
CURRENT_BRANCH=$(git rev-parse --abbrev-ref HEAD)
log "Creo il branch '$TARGET_BRANCH' da '$BASE_REF'..."
git checkout -b "$TARGET_BRANCH" "$BASE_FULL"

# ── Cherry-pick dei commit ───────────────────────────────────
log "Inizio cherry-pick di $TOTAL commit..."
echo ""

APPLIED=0
FAILED=0

for COMMIT in "${COMMITS[@]}"; do
  SHORT="${COMMIT:0:10}"
  MSG=$(git log --format="%s" -n 1 "$COMMIT")

  if git cherry-pick --ff "$COMMIT" --quiet 2>/dev/null; then
    ok "${SHORT} — ${MSG}"
    (( APPLIED++ )) || true
  else
    err "${SHORT} — CONFLITTO: ${MSG}"
    warn "Cherry-pick in conflitto. Risolvi manualmente poi esegui:"
    warn "  git cherry-pick --continue"
    warn "oppure annulla tutto con:"
    warn "  git cherry-pick --abort && git checkout ${CURRENT_BRANCH} && git branch -D ${TARGET_BRANCH}"
    (( FAILED++ )) || true
    exit 1
  fi
done

echo ""
ok "Cherry-pick completato: ${APPLIED}/${TOTAL} commit applicati su '${TARGET_BRANCH}'."

# ── Push opzionale ───────────────────────────────────────────
if $DO_PUSH; then
  log "Push di '${TARGET_BRANCH}' su '${REMOTE}'..."
  git push -u "$REMOTE" "$TARGET_BRANCH"
  ok "Branch pubblicato su ${REMOTE}/${TARGET_BRANCH}"
fi

echo ""
echo -e "${BOLD}${GREEN}✔ Fatto!${NC}"
echo -e "  Sorgente : ${CYAN}${SOURCE_BRANCH}${NC} (${TOTAL} commit)"
echo -e "  Base     : ${CYAN}${BASE_REF}${NC}"
echo -e "  Nuovo    : ${CYAN}${TARGET_BRANCH}${NC}"
$DO_PUSH && echo -e "  Remote   : ${CYAN}${REMOTE}/${TARGET_BRANCH}${NC}"
