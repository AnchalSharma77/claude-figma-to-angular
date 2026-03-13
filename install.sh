#!/bin/bash

# figma-to-angular skill installer
# Usage: curl -fsSL https://raw.githubusercontent.com/YOUR_USERNAME/figma-to-angular-skill/main/install.sh | bash

set -e

SKILL_NAME="figma-to-angular"
REPO_RAW="https://raw.githubusercontent.com/AnchalSharma77/claude-figma-to-angular/main"
INSTALL_DIR="$HOME/.claude/skills/$SKILL_NAME"

echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  Installing $SKILL_NAME skill for Claude Code"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""

# Check if Claude Code is installed
if ! command -v claude &> /dev/null; then
  echo "⚠️  Warning: 'claude' CLI not found."
  echo "   Make sure Claude Code is installed: https://claude.ai/code"
  echo "   The skill will still be installed and will work once Claude Code is set up."
  echo ""
fi

# Create skills directory
mkdir -p "$INSTALL_DIR"

# Download SKILL.md
echo "📥 Downloading SKILL.md..."
curl -fsSL "$REPO_RAW/$SKILL_NAME/SKILL.md" -o "$INSTALL_DIR/SKILL.md"

echo ""
echo "✅ Skill installed successfully!"
echo ""
echo "📁 Location: $INSTALL_DIR"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "  How to use"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "  In Claude Code, run:"
echo ""
echo "  /figma-to-angular https://www.figma.com/design/..."
echo ""
echo "  Claude will ask for your Angular project path,"
echo "  then generate matching .ts, .html, and .css files."
echo ""
