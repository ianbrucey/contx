#!/bin/bash

# Universal Context Engineering Framework
# Universal Sync Script - Converts context to all supported AI tool formats

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "🚀 Universal Context Engineering Framework"
echo "Syncing to all supported AI tools..."
echo ""

# Function to run sync script and handle errors
run_sync() {
    local tool_name="$1"
    local script_path="$2"
    
    echo "🔄 Syncing to $tool_name..."
    
    if [[ -f "$script_path" ]]; then
        if bash "$script_path"; then
            echo "✅ $tool_name sync completed successfully"
        else
            echo "❌ $tool_name sync failed"
            return 1
        fi
    else
        echo "⚠️  $tool_name sync script not found: $script_path"
        return 1
    fi
    
    echo ""
}

# Track success/failure
success_count=0
total_count=0

# Sync to Augment
total_count=$((total_count + 1))
if run_sync "Augment" "$SCRIPT_DIR/sync-to-augment.sh"; then
    success_count=$((success_count + 1))
fi

# Sync to Warp
total_count=$((total_count + 1))
if run_sync "Warp" "$SCRIPT_DIR/sync-to-warp.sh"; then
    success_count=$((success_count + 1))
fi

# Sync to Gemini CLI
total_count=$((total_count + 1))
if run_sync "Gemini CLI" "$SCRIPT_DIR/sync-to-gemini.sh"; then
    success_count=$((success_count + 1))
fi

# Summary
echo "📊 Sync Summary:"
echo "   ✅ Successful: $success_count/$total_count tools"

if [[ $success_count -eq $total_count ]]; then
    echo "   🎉 All tools synced successfully!"
else
    echo "   ⚠️  Some syncs failed - check output above"
fi

echo ""
echo "🔧 Tool-Specific Usage:"
echo ""
echo "📱 Augment (VSCode/JetBrains):"
echo "   - Rules loaded automatically"
echo "   - Use: 'Implement user auth. Use @complex-task-template'"
echo "   - Templates: @simple-task-template, @complex-task-template, @research-template"
echo ""
echo "💻 Warp (Terminal):"
echo "   - Rules apply automatically based on directory"
echo "   - Context changes as you navigate subdirectories"
echo "   - All AI interactions include project context"
echo ""
echo "🤖 Gemini CLI:"
echo "   - Context loaded automatically when starting Gemini"
echo "   - Hierarchical context provides progressive detail"
echo "   - Memory management preserves conversation context"
echo ""
echo "📚 Documentation:"
echo "   - See .contx/README.md for detailed setup instructions"
echo "   - Check individual tool documentation for advanced features"
echo "   - Update context files in .contx/ and re-run this script"
echo ""

# Check if git is available and offer to commit changes
if command -v git &> /dev/null && [[ -d "$(git rev-parse --git-dir 2>/dev/null)" ]]; then
    echo "📝 Git repository detected. Consider committing the generated files:"
    echo "   git add ."
    echo "   git commit -m 'Add universal context engineering framework'"
    echo ""
fi

echo "🎯 Next Steps:"
echo "   1. Test with your preferred AI tool"
echo "   2. Customize .contx/global-context.md for your project"
echo "   3. Add domain-specific contexts as needed"
echo "   4. Share with your team for consistent AI assistance"
echo ""
echo "✨ Happy coding with enhanced AI assistance!"
EOF
