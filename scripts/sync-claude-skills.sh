#!/bin/sh
# ABOUTME: Mirror all Claude skill directories into .codex/skills as symlinks.
# ABOUTME: Keeps one source of truth in .claude/skills for both Claude and Codex.

set -e

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
CLAUDE_SKILLS_DIR="$ROOT_DIR/.claude/skills"
CODEX_SKILLS_DIR="$ROOT_DIR/.codex/skills"

if [ ! -d "$CLAUDE_SKILLS_DIR" ]; then
  echo "Claude skills directory not found: $CLAUDE_SKILLS_DIR"
  exit 1
fi

mkdir -p "$CODEX_SKILLS_DIR"

linked_count=0

for skill_dir in "$CLAUDE_SKILLS_DIR"/*; do
  [ -d "$skill_dir" ] || continue

  skill_name="$(basename "$skill_dir")"
  target_link="$CODEX_SKILLS_DIR/$skill_name"

  ln -sfn "../../.claude/skills/$skill_name" "$target_link"
  linked_count=$((linked_count + 1))
  echo "Linked: .codex/skills/$skill_name -> ../../.claude/skills/$skill_name"
done

echo "Done. Synced $linked_count skill(s)."
