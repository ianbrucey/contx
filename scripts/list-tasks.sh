#!/bin/bash

# Universal Context Engineering Framework
# Task Listing and Status Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
TASKS_DIR="$CONTX_DIR/tasks"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BLUE}📋 Task Workspace Overview${NC}"
echo "=========================="
echo ""

# Check if tasks directory exists
if [[ ! -d "$TASKS_DIR" ]]; then
    echo -e "${YELLOW}📁 No tasks directory found${NC}"
    echo "Create your first task with: ./scripts/create-task-workspace.sh"
    exit 0
fi

# Check if any tasks exist
if [[ -z "$(ls -A "$TASKS_DIR" 2>/dev/null)" ]]; then
    echo -e "${YELLOW}📝 No tasks found${NC}"
    echo "Create your first task with: ./scripts/create-task-workspace.sh"
    exit 0
fi

# Function to get task status from metadata
get_task_status() {
    local task_dir="$1"
    local metadata_file="$task_dir/task-metadata.json"
    
    if [[ -f "$metadata_file" ]]; then
        # Extract status from JSON (basic parsing)
        grep '"status"' "$metadata_file" | sed 's/.*"status": *"\([^"]*\)".*/\1/'
    else
        echo "unknown"
    fi
}

# Function to get task progress from progress.md
get_task_progress() {
    local task_dir="$1"
    local progress_file="$task_dir/progress.md"
    
    if [[ -f "$progress_file" ]]; then
        # Look for progress percentage
        grep -o "Progress.*: [0-9]*%" "$progress_file" | tail -1 | grep -o "[0-9]*%" || echo "0%"
    else
        echo "0%"
    fi
}

# Function to get last updated date
get_last_updated() {
    local task_dir="$1"
    local progress_file="$task_dir/progress.md"
    
    if [[ -f "$progress_file" ]]; then
        # Get the most recent date from the file
        stat -f "%Sm" -t "%Y-%m-%d" "$progress_file" 2>/dev/null || stat -c "%y" "$progress_file" 2>/dev/null | cut -d' ' -f1 || echo "unknown"
    else
        echo "unknown"
    fi
}

# Function to format status with colors
format_status() {
    local status="$1"
    case "$status" in
        "not_started")
            echo -e "${YELLOW}Not Started${NC}"
            ;;
        "in_progress")
            echo -e "${BLUE}In Progress${NC}"
            ;;
        "blocked")
            echo -e "${RED}Blocked${NC}"
            ;;
        "completed")
            echo -e "${GREEN}Completed${NC}"
            ;;
        "on_hold")
            echo -e "${CYAN}On Hold${NC}"
            ;;
        *)
            echo -e "${YELLOW}Unknown${NC}"
            ;;
    esac
}

# Function to extract task info from folder name
parse_task_folder() {
    local folder_name="$1"
    # Remove "task-" prefix and split on first dash
    local without_prefix="${folder_name#task-}"
    local task_id="${without_prefix%%-*}"
    local description="${without_prefix#*-}"
    echo "$task_id|$description"
}

# Display header
printf "%-15s %-30s %-12s %-10s %-12s\n" "TASK ID" "DESCRIPTION" "STATUS" "PROGRESS" "UPDATED"
printf "%-15s %-30s %-12s %-10s %-12s\n" "-------" "-----------" "------" "--------" "-------"

# List all tasks
for task_dir in "$TASKS_DIR"/task-*; do
    if [[ -d "$task_dir" ]]; then
        folder_name=$(basename "$task_dir")
        task_info=$(parse_task_folder "$folder_name")
        task_id=$(echo "$task_info" | cut -d'|' -f1)
        description=$(echo "$task_info" | cut -d'|' -f2)
        
        # Truncate description if too long
        if [[ ${#description} -gt 28 ]]; then
            description="${description:0:25}..."
        fi
        
        status=$(get_task_status "$task_dir")
        progress=$(get_task_progress "$task_dir")
        updated=$(get_last_updated "$task_dir")
        
        formatted_status=$(format_status "$status")
        
        printf "%-15s %-30s %-20s %-10s %-12s\n" "$task_id" "$description" "$formatted_status" "$progress" "$updated"
    fi
done

echo ""

# Summary statistics
total_tasks=$(find "$TASKS_DIR" -maxdepth 1 -name "task-*" -type d | wc -l | tr -d ' ')
not_started=$(find "$TASKS_DIR" -name "task-metadata.json" -exec grep -l '"status": *"not_started"' {} \; | wc -l | tr -d ' ')
in_progress=$(find "$TASKS_DIR" -name "task-metadata.json" -exec grep -l '"status": *"in_progress"' {} \; | wc -l | tr -d ' ')
completed=$(find "$TASKS_DIR" -name "task-metadata.json" -exec grep -l '"status": *"completed"' {} \; | wc -l | tr -d ' ')
blocked=$(find "$TASKS_DIR" -name "task-metadata.json" -exec grep -l '"status": *"blocked"' {} \; | wc -l | tr -d ' ')

echo -e "${BLUE}📊 Summary${NC}"
echo "----------"
echo -e "Total Tasks: ${CYAN}$total_tasks${NC}"
echo -e "Not Started: ${YELLOW}$not_started${NC}"
echo -e "In Progress: ${BLUE}$in_progress${NC}"
echo -e "Completed: ${GREEN}$completed${NC}"
echo -e "Blocked: ${RED}$blocked${NC}"

echo ""
echo -e "${BLUE}🔧 Commands${NC}"
echo "-----------"
echo "Create new task:    ./scripts/create-task-workspace.sh [task-id] [description] [complexity]"
echo "Update task status: ./scripts/update-task-status.sh [task-id] [status]"
echo "View task details:  cd .contx/tasks/task-[id]-[description]"
echo ""

# Show recent activity
echo -e "${BLUE}📅 Recent Activity${NC}"
echo "------------------"
find "$TASKS_DIR" -name "progress.md" -exec stat -f "%Sm %N" -t "%Y-%m-%d %H:%M" {} \; 2>/dev/null | sort -r | head -5 | while read -r line; do
    date_time=$(echo "$line" | cut -d' ' -f1-2)
    file_path=$(echo "$line" | cut -d' ' -f3-)
    task_folder=$(basename "$(dirname "$file_path")")
    task_info=$(parse_task_folder "$task_folder")
    task_id=$(echo "$task_info" | cut -d'|' -f1)
    echo -e "${CYAN}$date_time${NC} - $task_id"
done 2>/dev/null || echo "No recent activity found"

echo ""
EOF
