# Example: Web Application Global Context

## Problem Definition & Scope
**Problem Statement**: Build a modern web application for task management that allows teams to collaborate effectively on projects with real-time updates and comprehensive reporting.

**Project Scope**: 
- User authentication and authorization
- Project and task management
- Real-time collaboration features
- Reporting and analytics dashboard
- Mobile-responsive design
- API for third-party integrations

**Target Users**: 
- Small to medium-sized development teams
- Project managers and team leads
- Remote and distributed teams

**Success Metrics**: 
- User adoption rate > 80% within 3 months
- Task completion time reduced by 30%
- User satisfaction score > 4.5/5
- 99.9% uptime availability

## Solution Architecture
**Architecture Pattern**: Microservices with API Gateway

**Technology Stack**:
- Frontend: React 18 with TypeScript, Tailwind CSS
- Backend: Node.js with Express, TypeScript
- Database: PostgreSQL with Redis for caching
- Infrastructure: AWS (ECS, RDS, ElastiCache, CloudFront)

**Key Architectural Decisions**:
- Microservices: Enables independent scaling and deployment
- TypeScript: Provides type safety across frontend and backend
- PostgreSQL: ACID compliance for critical business data
- Redis: High-performance caching for real-time features
- AWS: Proven scalability and reliability

## Module Breakdown & Responsibilities
**Core Modules**:
1. **Authentication Service**: User registration, login, JWT management, password reset
2. **User Management Service**: User profiles, preferences, team membership
3. **Project Service**: Project CRUD, permissions, team assignments
4. **Task Service**: Task CRUD, status tracking, dependencies, assignments
5. **Notification Service**: Real-time notifications, email alerts, push notifications
6. **Reporting Service**: Analytics, dashboards, export functionality
7. **API Gateway**: Request routing, rate limiting, authentication middleware

**Integration Points**: 
- Services communicate via REST APIs
- Real-time updates via WebSocket connections
- Event-driven architecture with message queues

**Shared Dependencies**: 
- JWT authentication library
- Database connection pooling
- Logging and monitoring utilities
- Validation schemas

## Project Acceptance Criteria
- [ ] Users can register, login, and manage their profiles
- [ ] Teams can create projects and invite members
- [ ] Tasks can be created, assigned, and tracked through completion
- [ ] Real-time updates appear instantly across all connected clients
- [ ] System handles 1000+ concurrent users with <200ms response time
- [ ] All data is encrypted in transit and at rest
- [ ] Mobile-responsive design works on all major devices
- [ ] Comprehensive test coverage >90% for critical paths

## Key Constraints & Guidelines
**Technical Constraints**:
- Must support modern browsers (Chrome, Firefox, Safari, Edge)
- Database queries must complete within 100ms for 95th percentile
- API responses must be under 200ms for 95th percentile

**Business Constraints**:
- Launch deadline: 6 months from project start
- Budget: $200k development budget
- Team: 4 developers, 1 designer, 1 product manager

**Coding Standards**:
- ESLint and Prettier for code formatting
- Conventional Commits for git messages
- Test-driven development for critical features
- Code review required for all changes
- TypeScript strict mode enabled

## Context Engineering Workflow
When assigned a new task, AI assistants should:

1. **Reference Global Context**: Always start by reviewing this document
2. **Select Template**: Choose appropriate task template based on complexity
   - Simple tasks (< 2 hours): Use simple task template
   - Complex tasks (> 2 hours): Use complex task template
   - Research tasks: Use research template
3. **Gather Domain Context**: Apply relevant domain-specific knowledge
4. **Structure Planning**: Follow Problem → Solution → Rationale → Research → Plan
5. **Create Task Management**: Use structured planning for complex multi-step work
6. **Document Decisions**: Update decision logs during implementation
7. **Suggest Testing**: Always recommend testing after implementation

## Available Templates & Contexts
**Task Templates**:
- Simple Task Template: For straightforward implementations
- Complex Task Template: For multi-step architectural changes
- Research Template: For investigation and discovery tasks

**Domain Contexts**: Automatically applied based on task relevance:
- Authentication & authorization (JWT, sessions, OAuth)
- Database operations (PostgreSQL, migrations, queries)
- API design (REST, validation, error handling)
- Frontend components (React, TypeScript, state management)
- Real-time features (WebSockets, notifications)
- Testing strategies (unit, integration, e2e)

## Decision History
**2024-01-15**: Chose React over Vue for frontend - Better TypeScript support and larger ecosystem
**2024-01-20**: Selected PostgreSQL over MongoDB - ACID compliance needed for financial data
**2024-01-25**: Decided on microservices architecture - Enables independent team scaling
**2024-02-01**: Chose AWS over Google Cloud - Team has more AWS experience

## Notes & Updates
**Last Updated**: 2024-02-01
**Updated By**: Development Team Lead
**Changes**: Added real-time notification requirements, updated technology stack decisions

---

## Tool-Specific Instructions

### For Augment Users
- Reference this context with @global-context
- Use @simple-task-template, @complex-task-template, or @research-template
- Domain contexts will auto-trigger based on keywords

### For Warp Users
- This context is automatically applied via WARP.md
- Subdirectory-specific rules provide additional context
- All terminal AI interactions include this guidance

### For Gemini CLI Users
- This context is loaded via GEMINI.md
- Context hierarchy provides progressive detail
- Memory management preserves conversation context

### Universal Guidelines
- Always include explicit acceptance criteria
- Document architectural decisions in decision logs
- Consider forward compatibility and technical debt
- Update context documents when making architectural changes
- Use task management tools for complex multi-step work
- Suggest writing/updating tests after code changes
