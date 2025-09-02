#!/bin/bash

# Universal Context Engineering Framework
# Task Status Update Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKS_DIR="$CONTX_DIR/tasks"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Function to display usage
usage() {
    echo "Usage: $0 [task-id] [status] [optional: progress-percentage]"
    echo ""
    echo "Parameters:"
    echo "  task-id    : Task identifier (e.g., AUTH-001, API-042)"
    echo "  status     : not_started | in_progress | blocked | completed | on_hold"
    echo "  progress   : Optional progress percentage (0-100)"
    echo ""
    echo "Examples:"
    echo "  $0 AUTH-001 in_progress 25"
    echo "  $0 API-042 completed"
    echo "  $0 NOTIF-001 blocked"
    echo ""
    exit 1
}

# Check parameters
if [[ $# -lt 2 || $# -gt 3 ]]; then
    echo -e "${RED}❌ Error: Incorrect number of parameters${NC}"
    echo ""
    usage
fi

TASK_ID="$1"
NEW_STATUS="$2"
PROGRESS="${3:-}"

# Validate status
if [[ ! "$NEW_STATUS" =~ ^(not_started|in_progress|blocked|completed|on_hold)$ ]]; then
    echo -e "${RED}❌ Error: Invalid status. Must be one of: not_started, in_progress, blocked, completed, on_hold${NC}"
    echo ""
    usage
fi

# Validate progress if provided
if [[ -n "$PROGRESS" ]]; then
    if [[ ! "$PROGRESS" =~ ^[0-9]+$ ]] || [[ "$PROGRESS" -lt 0 ]] || [[ "$PROGRESS" -gt 100 ]]; then
        echo -e "${RED}❌ Error: Progress must be a number between 0 and 100${NC}"
        exit 1
    fi
fi

# Find task folder
TASK_FOLDER=""
for dir in "$TASKS_DIR"/task-${TASK_ID}-*; do
    if [[ -d "$dir" ]]; then
        if [[ -n "$TASK_FOLDER" ]]; then
            echo -e "${RED}❌ Error: Multiple tasks found with ID $TASK_ID${NC}"
            echo "Found:"
            echo "  - $(basename "$TASK_FOLDER")"
            echo "  - $(basename "$dir")"
            echo "Please use the full task folder name or be more specific."
            exit 1
        fi
        TASK_FOLDER="$dir"
    fi
done

if [[ -z "$TASK_FOLDER" ]]; then
    echo -e "${RED}❌ Error: No task found with ID $TASK_ID${NC}"
    echo ""
    echo "Available tasks:"
    if [[ -d "$TASKS_DIR" ]]; then
        for dir in "$TASKS_DIR"/task-*; do
            if [[ -d "$dir" ]]; then
                folder_name=$(basename "$dir")
                task_id="${folder_name#task-}"
                task_id="${task_id%%-*}"
                echo "  - $task_id ($(basename "$dir"))"
            fi
        done
    else
        echo "  No tasks found. Create one with: ./scripts/create-task-workspace.sh"
    fi
    exit 1
fi

TASK_NAME=$(basename "$TASK_FOLDER")
METADATA_FILE="$TASK_FOLDER/task-metadata.json"
PROGRESS_FILE="$TASK_FOLDER/progress.md"

echo -e "${BLUE}🔄 Updating task status${NC}"
echo "Task: $TASK_NAME"
echo "New Status: $NEW_STATUS"
if [[ -n "$PROGRESS" ]]; then
    echo "Progress: $PROGRESS%"
fi
echo ""

# Update metadata file
if [[ -f "$METADATA_FILE" ]]; then
    # Create backup
    cp "$METADATA_FILE" "$METADATA_FILE.backup"
    
    # Update status and timestamp
    sed -i.tmp "s/\"status\": *\"[^\"]*\"/\"status\": \"$NEW_STATUS\"/" "$METADATA_FILE"
    sed -i.tmp "s/\"updatedAt\": *\"[^\"]*\"/\"updatedAt\": \"$(date -u +"%Y-%m-%dT%H:%M:%SZ")\"/" "$METADATA_FILE"
    
    # Clean up temp file
    rm -f "$METADATA_FILE.tmp"
    
    echo -e "${GREEN}✅ Updated metadata file${NC}"
else
    echo -e "${YELLOW}⚠️  Metadata file not found, creating new one${NC}"
    cat > "$METADATA_FILE" << EOF
{
  "taskId": "$TASK_ID",
  "status": "$NEW_STATUS",
  "updatedAt": "$(date -u +"%Y-%m-%dT%H:%M:%SZ")",
  "progress": ${PROGRESS:-0}
}
EOF
fi

# Update progress file
if [[ -f "$PROGRESS_FILE" ]]; then
    # Add new session entry
    {
        echo ""
        echo "### Session Update - $(date)"
        echo "- **Status Changed**: $NEW_STATUS"
        if [[ -n "$PROGRESS" ]]; then
            echo "- **Progress**: $PROGRESS%"
        fi
        echo "- **Updated By**: Automated status update"
        echo "- **Notes**: [Add any additional notes about this status change]"
    } >> "$PROGRESS_FILE"
    
    # Update current status section
    if grep -q "## Current Status" "$PROGRESS_FILE"; then
        # Create a temporary file with updated status
        awk -v status="$NEW_STATUS" -v progress="$PROGRESS" '
        /^## Current Status/ { in_status = 1; print; next }
        /^## / && in_status { in_status = 0 }
        in_status && /^- \*\*Status\*\*:/ { 
            print "- **Status**: " status; next 
        }
        in_status && /^- \*\*Progress\*\*:/ && progress != "" { 
            print "- **Progress**: " progress "%"; next 
        }
        in_status && /^- \*\*Last Updated\*\*:/ { 
            print "- **Last Updated**: " strftime("%Y-%m-%d %H:%M:%S"); next 
        }
        { print }
        ' "$PROGRESS_FILE" > "$PROGRESS_FILE.tmp" && mv "$PROGRESS_FILE.tmp" "$PROGRESS_FILE"
    fi
    
    echo -e "${GREEN}✅ Updated progress file${NC}"
else
    echo -e "${YELLOW}⚠️  Progress file not found${NC}"
fi

# Update completion checklist for completed tasks
if [[ "$NEW_STATUS" == "completed" && -f "$PROGRESS_FILE" ]]; then
    echo -e "${BLUE}🎯 Marking completion checklist${NC}"
    
    # Mark all checklist items as completed
    sed -i.tmp 's/^- \[ \]/- [x]/' "$PROGRESS_FILE"
    rm -f "$PROGRESS_FILE.tmp"
    
    echo -e "${GREEN}✅ Marked all checklist items as completed${NC}"
fi

# Show status-specific guidance
case "$NEW_STATUS" in
    "in_progress")
        echo ""
        echo -e "${BLUE}💡 Task is now in progress${NC}"
        echo "Consider:"
        echo "- Update progress.md with current session focus"
        echo "- Document any decisions in decisions.md"
        echo "- Track time spent in the session log"
        ;;
    "blocked")
        echo ""
        echo -e "${YELLOW}⚠️  Task is now blocked${NC}"
        echo "Consider:"
        echo "- Document the blocker in progress.md"
        echo "- Identify who can help resolve the blocker"
        echo "- Set a follow-up date to check on the blocker"
        echo "- Update next-steps.md with alternative work"
        ;;
    "completed")
        echo ""
        echo -e "${GREEN}🎉 Task completed!${NC}"
        echo "Consider:"
        echo "- Update final time tracking in progress.md"
        echo "- Document lessons learned"
        echo "- Update global context with new patterns"
        echo "- Archive or clean up temporary files"
        ;;
    "on_hold")
        echo ""
        echo -e "${CYAN}⏸️  Task is on hold${NC}"
        echo "Consider:"
        echo "- Document reason for hold in progress.md"
        echo "- Set a review date in next-steps.md"
        echo "- Preserve current context for future resumption"
        ;;
esac

echo ""
echo -e "${BLUE}📁 Task Location:${NC} $TASK_FOLDER"
echo -e "${BLUE}📋 View Progress:${NC} cat $PROGRESS_FILE"
echo -e "${BLUE}📝 Edit Progress:${NC} edit $PROGRESS_FILE"
echo ""
echo -e "${GREEN}✅ Task status updated successfully!${NC}"
EOF
