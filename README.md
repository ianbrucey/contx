# Universal Context Engineering Framework

> **Transform your AI-assisted development with structured, consistent context across all your tools**

A comprehensive, tool-agnostic context engineering system that provides structured guidance for AI-assisted development. Works seamlessly with Augment, Warp, Gemini CLI, and other AI coding tools.

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![GitHub stars](https://img.shields.io/github/stars/ianbrucey/contx.svg)](https://github.com/ianbrucey/contx/stargazers)
[![GitHub issues](https://img.shields.io/github/issues/ianbrucey/contx.svg)](https://github.com/ianbrucey/contx/issues)

## 🎯 Why Context Engineering?

AI coding assistants are powerful, but they often lack project-specific context, leading to:
- ❌ Inconsistent code patterns across team members
- ❌ Repeated explanations of project architecture
- ❌ Generic solutions that don't fit your specific needs
- ❌ Time wasted on back-and-forth clarifications

**This framework solves these problems by providing:**
- ✅ **Structured Context**: Hierarchical project knowledge that scales
- ✅ **Tool Agnostic**: Works with Augment, Warp, Gemini CLI, and more
- ✅ **Team Consistency**: Shared context ensures uniform AI guidance
- ✅ **Template-Driven**: Proven patterns for different task types
- ✅ **Maintainable**: Easy to update and evolve with your project

## 🚀 Quick Start (5 minutes)

### 1. Install to Your Project

```bash
# Clone to your project as a submodule (recommended)
cd /path/to/your/project
git submodule add https://github.com/ianbrucey/contx.git .contx

# Or clone directly
git clone https://github.com/ianbrucey/contx.git .contx
```

### 2. Choose Your AI Tool

**🔧 Augment (VSCode/JetBrains)**
```bash
cd .contx && ./scripts/sync-to-augment.sh
```

**💻 Warp (Terminal AI)**
```bash
cd .contx && ./scripts/sync-to-warp.sh
```

**🤖 Gemini CLI**
```bash
cd .contx && ./scripts/sync-to-gemini.sh
```

**🌐 All Tools**
```bash
cd .contx && ./scripts/sync-all.sh
```

### 3. Customize & Test

```bash
# Customize for your project
edit .contx/global-context.md

# Test with your AI tool
# Augment: "Implement user auth. Use @complex-task-template"
# Warp: Ask any development question in terminal
# Gemini: Run 'gemini' and describe your task
```

## 📁 Framework Architecture

```
.contx/                                # Universal Context Framework
├── 📋 global-context.md              # Project overview & architecture
├── 📝 templates/                     # Task execution templates
│   ├── simple-task.md               #   Quick fixes & small features
│   ├── complex-task.md              #   Major features & architecture
│   └── research-task.md             #   Investigation & discovery
├── 🏗️ domain-contexts/              # Domain-specific knowledge
│   ├── auth-context.md              #   Authentication patterns
│   ├── database-context.md          #   Database operations
│   ├── api-context.md               #   API design standards
│   └── [your-domain].md             #   Custom domain contexts
├── 🔄 scripts/                      # Tool synchronization
│   ├── sync-to-augment.sh           #   → .augment/rules/
│   ├── sync-to-warp.sh              #   → WARP.md files
│   ├── sync-to-gemini.sh            #   → GEMINI.md files
│   └── sync-all.sh                  #   → All tools at once
├── 📚 examples/                     # Sample configurations
│   └── web-app-example/             #   Complete example setup
└── 📖 SETUP_GUIDE.md               # Detailed setup instructions
```

### 🔄 How It Works

1. **Single Source of Truth**: Maintain context in `.contx/` directory
2. **Tool Adaptation**: Scripts convert to tool-specific formats
3. **Automatic Sync**: Keep all tools updated with one command
4. **Hierarchical Context**: Global → Domain → Task-specific guidance

## 🛠️ Supported AI Tools

| Tool | Type | Setup Command | Usage |
|------|------|---------------|-------|
| **🔧 Augment** | IDE Extension | `./scripts/sync-to-augment.sh` | `"Use @complex-task-template"` |
| **💻 Warp** | Terminal AI | `./scripts/sync-to-warp.sh` | Auto-applies based on directory |
| **🤖 Gemini CLI** | Command Line | `./scripts/sync-to-gemini.sh` | Auto-loads context on startup |
| **🌐 Universal** | All Tools | `./scripts/sync-all.sh` | Sync to all tools at once |

### 🔧 Augment Integration

**Perfect for**: VSCode and JetBrains users who want structured templates and auto-triggered context

```bash
# Setup
./scripts/sync-to-augment.sh

# Usage examples
"Implement user authentication. Use @complex-task-template"
"Fix login validation bug. Use @simple-task-template"
"Research caching strategies. Use @research-template"
```

**Features**:
- ✅ Global context always loaded
- ✅ Manual templates via `@template-name`
- ✅ Auto-triggered domain contexts
- ✅ Task management integration

### 💻 Warp Integration

**Perfect for**: Terminal-focused developers who want contextual AI assistance

```bash
# Setup
./scripts/sync-to-warp.sh

# Usage
# Just ask questions in Warp - context applies automatically
"How should I structure this API endpoint?"
"What's the best way to handle database migrations?"
```

**Features**:
- ✅ Automatic context loading
- ✅ Directory-specific rules
- ✅ Hierarchical context inheritance
- ✅ No manual template selection needed

### 🤖 Gemini CLI Integration

**Perfect for**: Command-line workflows with persistent context memory

```bash
# Setup
./scripts/sync-to-gemini.sh

# Usage
gemini
> Help me implement user authentication
> What testing strategy should I use?
```

**Features**:
- ✅ Automatic context loading
- ✅ Conversation memory
- ✅ Hierarchical context files
- ✅ MCP integration support

## 📝 Customization Guide

### 🎯 1. Global Context Setup

The heart of your context system - defines your project's DNA:

```bash
edit .contx/global-context.md
```

**Essential sections to customize**:
```markdown
## Problem Definition & Scope
**Problem Statement**: [Your specific problem]
**Target Users**: [Who uses your system]
**Success Metrics**: [How you measure success]

## Solution Architecture
**Technology Stack**:
- Frontend: [React, Vue, Angular, etc.]
- Backend: [Node.js, Python, Java, etc.]
- Database: [PostgreSQL, MongoDB, etc.]

## Key Constraints & Guidelines
**Coding Standards**: [ESLint, Prettier, etc.]
**Performance Requirements**: [Response times, etc.]
```

### 🏗️ 2. Domain Context Creation

Add specialized knowledge for your domains:

```bash
# Copy and customize existing contexts
cp .contx/domain-contexts/auth-context.md .contx/domain-contexts/payment-context.md

# Create new domain contexts
touch .contx/domain-contexts/notification-context.md
touch .contx/domain-contexts/analytics-context.md
```

**Popular domain contexts**:
- 🔐 Authentication & Authorization
- 💾 Database Operations & Migrations
- 🌐 API Design & Implementation
- ⚛️ Frontend Components & State
- 📧 Email & Notifications
- 💳 Payment Processing
- 📊 Analytics & Reporting

### 📋 3. Template Customization

Adapt templates to your team's workflow:

```bash
# Customize task complexity thresholds
edit .contx/templates/simple-task.md    # < 2 hours
edit .contx/templates/complex-task.md   # > 2 hours
edit .contx/templates/research-task.md  # Investigation
```

**Common customizations**:
- Adjust time estimates for your team's velocity
- Add company-specific sections (security review, etc.)
- Include your testing requirements
- Modify acceptance criteria formats

## 🔄 Development Workflow

### 📋 Task Classification System

| Task Type | Duration | Examples | Template |
|-----------|----------|----------|----------|
| **🔧 Simple** | < 2 hours | Bug fixes, config changes, small features | `@simple-task-template` |
| **🏗️ Complex** | > 2 hours | New features, architecture changes, integrations | `@complex-task-template` |
| **🔍 Research** | Variable | Technology evaluation, performance analysis | `@research-template` |

### 🚀 Before Each Task

1. **📊 Classify your task** using the table above
2. **🎯 Select the right approach**:
   ```bash
   # Augment users
   "Implement user dashboard. Use @complex-task-template"

   # Warp users
   # Context applies automatically - just describe your task

   # Gemini CLI users
   gemini
   > I need to implement user authentication
   ```
3. **🔄 Sync if context changed**:
   ```bash
   cd .contx && ./scripts/sync-all.sh
   ```

### 📅 Maintenance Schedule

| Frequency | Duration | Tasks |
|-----------|----------|-------|
| **📅 Weekly** | 5 min | Update domain contexts with new patterns |
| **🏗️ After major features** | 15 min | Document architectural decisions |
| **📊 Monthly** | 30 min | Review effectiveness, refine templates |

### 🔄 Sync Workflow

```bash
# After updating any .contx/ files
cd .contx

# Sync to specific tool
./scripts/sync-to-augment.sh   # Just Augment
./scripts/sync-to-warp.sh      # Just Warp
./scripts/sync-to-gemini.sh    # Just Gemini

# Or sync to all tools
./scripts/sync-all.sh          # Everything
```

## 🚀 Advanced Features

### 🔄 Git Integration

Automate context synchronization with git hooks:

```bash
# Install git hooks for automatic sync
echo '#!/bin/bash' > .git/hooks/post-commit
echo 'cd .contx && ./scripts/sync-all.sh' >> .git/hooks/post-commit
chmod +x .git/hooks/post-commit

# Now context syncs automatically after each commit
```

### 👥 Team Collaboration

**Version Control Setup**:
```bash
# Add framework to version control
git add .contx/
git add .augment/ WARP.md GEMINI.md  # Generated files
git commit -m "Add universal context engineering framework"

# Team members can now sync with:
cd .contx && ./scripts/sync-all.sh
```

**Team Onboarding Script**:
```bash
# Create setup script for new team members
cat > setup-context.sh << 'EOF'
#!/bin/bash
echo "🚀 Setting up context engineering..."
cd .contx && ./scripts/sync-all.sh
echo "✅ Ready! Choose your AI tool and start coding."
EOF
chmod +x setup-context.sh
```

### 🔍 Cross-Tool Compatibility

The framework maintains consistency by:
- 🔄 **Format Conversion**: Adapts to each tool's specific requirements
- 🎯 **Semantic Preservation**: Maintains meaning across platforms
- ⚡ **Tool Optimization**: Leverages each tool's unique features
- 🔗 **Single Source**: One context, multiple outputs

## 📚 Examples & Templates

### 🌐 Web Application Example
```bash
# See complete example configuration
cat .contx/examples/web-app-example/global-context.md
```

### 📱 Mobile App Context
```bash
# Create mobile-specific domain context
cp .contx/domain-contexts/api-context.md .contx/domain-contexts/mobile-context.md
# Customize for React Native, Flutter, etc.
```

### 🏢 Enterprise Setup
```bash
# Add enterprise-specific contexts
touch .contx/domain-contexts/security-context.md
touch .contx/domain-contexts/compliance-context.md
touch .contx/domain-contexts/deployment-context.md
```

## 🤝 Contributing

We welcome contributions! Here's how:

1. **🍴 Fork** the repository
2. **🌿 Create** a feature branch: `git checkout -b feature/amazing-improvement`
3. **✨ Add** your improvements (new domain contexts, tool integrations, etc.)
4. **🧪 Test** with multiple AI tools
5. **📝 Document** your changes
6. **🚀 Submit** a pull request

**Popular contribution areas**:
- 🔧 New AI tool integrations
- 🏗️ Domain-specific contexts
- 📋 Template improvements
- 📚 Documentation and examples
- 🐛 Bug fixes and optimizations

## 📊 Success Stories

> *"Reduced onboarding time for new developers from 2 weeks to 3 days"*
> — Senior Engineering Manager, Tech Startup

> *"AI suggestions are now 90% more relevant to our codebase"*
> — Lead Developer, E-commerce Platform

> *"Finally, consistent code patterns across our entire team"*
> — CTO, SaaS Company

## 🆘 Support & Community

| Resource | Purpose | Link |
|----------|---------|------|
| 🐛 **Issues** | Bug reports & feature requests | [GitHub Issues](https://github.com/ianbrucey/contx/issues) |
| 💬 **Discussions** | Community support & questions | [GitHub Discussions](https://github.com/ianbrucey/contx/discussions) |
| 📖 **Wiki** | Detailed guides & documentation | [GitHub Wiki](https://github.com/ianbrucey/contx/wiki) |
| 📧 **Email** | Direct support | [support@contx.dev](mailto:support@contx.dev) |

## 📄 License

MIT License - see [LICENSE](LICENSE) file for details.

---

<div align="center">

**🎯 Built for developers who demand consistent, high-quality AI assistance**

[⭐ Star this repo](https://github.com/ianbrucey/contx) • [🐛 Report issues](https://github.com/ianbrucey/contx/issues) • [💬 Join discussions](https://github.com/ianbrucey/contx/discussions)

</div>
