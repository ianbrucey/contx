#!/bin/bash

# Universal Context Engineering Framework
# Task Phase Management Script

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CONTX_DIR="$(cd "$SCRIPT_DIR/.." && pwd)"
PROJECT_ROOT="$(cd "$CONTX_DIR/.." && pwd)"
TASKS_DIR="$PROJECT_ROOT/.augment/tasks"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🔄 Task Phase Management${NC}"
echo "=============================================="
echo ""

# Function to display usage
usage() {
    echo "Usage: $0 [task-folder] [phase] [status]"
    echo ""
    echo "Parameters:"
    echo "  task-folder : Task folder name (e.g., task-AUTH-001-user-login)"
    echo "  phase       : Phase number (01, 02, 03, 04)"
    echo "  status      : Phase status (start, complete, block)"
    echo ""
    echo "Examples:"
    echo "  $0 task-AUTH-001-user-login 01 complete"
    echo "  $0 task-AUTH-001-user-login 02 start"
    echo "  $0 task-AUTH-001-user-login 03 block"
    echo ""
    echo "Available phases:"
    echo "  01 - Problem Definition"
    echo "  02 - Research"
    echo "  03 - Implementation Plan"
    echo "  04 - Implementation"
    echo ""
    exit 1
}

# Check parameters
if [[ $# -ne 3 ]]; then
    echo -e "${RED}❌ Error: Incorrect number of parameters${NC}"
    echo ""
    usage
fi

TASK_FOLDER="$1"
PHASE="$2"
STATUS="$3"

# Validate phase
if [[ ! "$PHASE" =~ ^(01|02|03|04)$ ]]; then
    echo -e "${RED}❌ Error: Phase must be '01', '02', '03', or '04'${NC}"
    echo ""
    usage
fi

# Validate status
if [[ ! "$STATUS" =~ ^(start|complete|block)$ ]]; then
    echo -e "${RED}❌ Error: Status must be 'start', 'complete', or 'block'${NC}"
    echo ""
    usage
fi

TASK_PATH="$TASKS_DIR/$TASK_FOLDER"

# Check if task exists
if [[ ! -d "$TASK_PATH" ]]; then
    echo -e "${RED}❌ Error: Task workspace not found: $TASK_FOLDER${NC}"
    echo "Available tasks:"
    ls -1 "$TASKS_DIR" 2>/dev/null | grep "^task-" || echo "  No tasks found"
    exit 1
fi

# Check if metadata file exists
METADATA_FILE="$TASK_PATH/task-metadata.json"
if [[ ! -f "$METADATA_FILE" ]]; then
    echo -e "${RED}❌ Error: Task metadata file not found${NC}"
    exit 1
fi

# Get phase names
case $PHASE in
    "01") PHASE_NAME="Problem Definition" ;;
    "02") PHASE_NAME="Research" ;;
    "03") PHASE_NAME="Implementation Plan" ;;
    "04") PHASE_NAME="Implementation" ;;
esac

# Update phase status
echo -e "${BLUE}📋 Updating Phase $PHASE: $PHASE_NAME${NC}"
echo -e "${BLUE}📁 Task: $TASK_FOLDER${NC}"
echo -e "${BLUE}🔄 Status: $STATUS${NC}"
echo ""

# Create timestamp
TIMESTAMP=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Update metadata file based on status
case $STATUS in
    "start")
        echo -e "${GREEN}▶️  Starting Phase $PHASE: $PHASE_NAME${NC}"
        # Update JSON to mark phase as in_progress and set startedAt
        python3 -c "
import json
import sys

with open('$METADATA_FILE', 'r') as f:
    data = json.load(f)

data['currentPhase'] = '${PHASE}-${PHASE_NAME,,}'.replace(' ', '-')
data['updatedAt'] = '$TIMESTAMP'
data['phases']['$PHASE-${PHASE_NAME,,}'.replace(' ', '-')] = {
    'status': 'in_progress',
    'startedAt': '$TIMESTAMP',
    'completedAt': None
}

with open('$METADATA_FILE', 'w') as f:
    json.dump(data, f, indent=2)
"
        ;;
    "complete")
        echo -e "${GREEN}✅ Completing Phase $PHASE: $PHASE_NAME${NC}"
        # Update JSON to mark phase as complete and set completedAt
        python3 -c "
import json
import sys

with open('$METADATA_FILE', 'r') as f:
    data = json.load(f)

data['updatedAt'] = '$TIMESTAMP'
phase_key = '${PHASE}-${PHASE_NAME,,}'.replace(' ', '-')
if phase_key in data['phases']:
    data['phases'][phase_key]['status'] = 'complete'
    data['phases'][phase_key]['completedAt'] = '$TIMESTAMP'

# Auto-start next phase if available
next_phases = {'01': '02', '02': '03', '03': '04'}
if '$PHASE' in next_phases:
    next_phase = next_phases['$PHASE']
    next_phase_names = {'02': 'research', '03': 'plan', '04': 'implementation'}
    next_phase_key = next_phase + '-' + next_phase_names[next_phase]
    if next_phase_key in data['phases']:
        data['currentPhase'] = next_phase_key
        print(f'Auto-starting next phase: {next_phase}')

with open('$METADATA_FILE', 'w') as f:
    json.dump(data, f, indent=2)
"
        ;;
    "block")
        echo -e "${YELLOW}🚫 Blocking Phase $PHASE: $PHASE_NAME${NC}"
        # Update JSON to mark phase as blocked
        python3 -c "
import json
import sys

with open('$METADATA_FILE', 'r') as f:
    data = json.load(f)

data['updatedAt'] = '$TIMESTAMP'
phase_key = '${PHASE}-${PHASE_NAME,,}'.replace(' ', '-')
if phase_key in data['phases']:
    data['phases'][phase_key]['status'] = 'blocked'

with open('$METADATA_FILE', 'w') as f:
    json.dump(data, f, indent=2)
"
        ;;
esac

# Update progress.md file
echo -e "${BLUE}📝 Updating progress tracking${NC}"
case $STATUS in
    "start")
        echo "### Phase $PHASE: $PHASE_NAME - Started $(date)" >> "$TASK_PATH/progress.md"
        echo "- **Status**: In Progress" >> "$TASK_PATH/progress.md"
        echo "- **Started**: $(date)" >> "$TASK_PATH/progress.md"
        echo "" >> "$TASK_PATH/progress.md"
        ;;
    "complete")
        echo "### Phase $PHASE: $PHASE_NAME - Completed $(date)" >> "$TASK_PATH/progress.md"
        echo "- **Status**: Complete" >> "$TASK_PATH/progress.md"
        echo "- **Completed**: $(date)" >> "$TASK_PATH/progress.md"
        echo "" >> "$TASK_PATH/progress.md"
        ;;
    "block")
        echo "### Phase $PHASE: $PHASE_NAME - Blocked $(date)" >> "$TASK_PATH/progress.md"
        echo "- **Status**: Blocked" >> "$TASK_PATH/progress.md"
        echo "- **Blocked**: $(date)" >> "$TASK_PATH/progress.md"
        echo "- **Reason**: [Add blocker reason]" >> "$TASK_PATH/progress.md"
        echo "" >> "$TASK_PATH/progress.md"
        ;;
esac

echo -e "${GREEN}✅ Phase status updated successfully!${NC}"
echo ""
echo -e "${BLUE}📋 Next Steps:${NC}"
case $STATUS in
    "start")
        echo "1. Work on ${PHASE}-*.md file for this phase"
        echo "2. Complete phase deliverables"
        echo "3. Run: $0 $TASK_FOLDER $PHASE complete"
        ;;
    "complete")
        case $PHASE in
            "01") echo "1. Start Research phase: $0 $TASK_FOLDER 02 start" ;;
            "02") echo "1. Start Implementation Plan phase: $0 $TASK_FOLDER 03 start" ;;
            "03") echo "1. Start Implementation phase: $0 $TASK_FOLDER 04 start" ;;
            "04") echo "1. Task is complete! Review and finalize documentation" ;;
        esac
        ;;
    "block")
        echo "1. Resolve blocker documented in progress.md"
        echo "2. Update blocker reason in progress.md"
        echo "3. When resolved, run: $0 $TASK_FOLDER $PHASE start"
        ;;
esac

echo ""
echo -e "${BLUE}📁 Task Location:${NC} $TASK_PATH"
echo -e "${BLUE}📋 Current Status:${NC} Phase $PHASE ($PHASE_NAME) - $STATUS"
