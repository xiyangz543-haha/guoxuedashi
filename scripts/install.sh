#!/usr/bin/env bash
set -euo pipefail

REPO_URL="https://github.com/xiyangz543-haha/guoxuedashi.git"

usage() {
  echo "Usage: $0 --target {codex|claude|openclaw}"
  echo ""
  echo "Install 国学大师 (guoxuedashi) Skill."
  echo ""
  echo "  --target codex     Install to ~/.codex/skills/guoxuedashi/"
  echo "  --target claude    Install to ~/.claude/skills/国学大师/"
  echo "  --target openclaw  Install to ~/skills/guoxuedashi/"
  exit 1
}

TARGET=""
while [[ $# -gt 0 ]]; do
  case "$1" in
    --target) TARGET="$2"; shift 2 ;;
    *) usage ;;
  esac
done

if [[ -z "$TARGET" ]]; then
  usage
fi

case "$TARGET" in
  codex)
    DEST="$HOME/.codex/skills/guoxuedashi"
    ;;
  claude)
    DEST="$HOME/.claude/skills/国学大师"
    ;;
  openclaw)
    DEST="$HOME/skills/guoxuedashi"
    ;;
  *)
    echo "Unknown target: $TARGET"
    usage
    ;;
esac

if [[ -d "$DEST" ]]; then
  echo "Removing existing installation at $DEST..."
  rm -rf "$DEST"
fi

echo "Cloning 国学大师 to $DEST..."
git clone "$REPO_URL" "$DEST"

echo ""
echo "Done! Restart your agent to reload skill metadata."
echo "In Claude Code, activate with: /国学大师"
