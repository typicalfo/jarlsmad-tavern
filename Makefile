# Jarlsmad Tavern - Viking MUD Game Makefile
# A comprehensive build system for the TanStack + Venice.ai + Convex project

.PHONY: help install dev build serve clean test lint format deps check deploy logs restart stop status env-check agents-deploy convex-dev convex-deploy convex-reset

# Default target - show help
help: ## Show this help message
	@echo "🏴‍☠️ Jarlsmad Tavern - Viking MUD Game"
	@echo "====================================="
	@echo ""
	@echo "Available commands:"
	@echo ""
	@awk 'BEGIN {FS = ":.*?## "} /^[a-zA-Z_-]+:.*?## / {printf "  \033[36m%-20s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)
	@echo ""
	@echo "Environment files needed:"
	@echo "  .env.local - Convex deployment and Venice API key"
	@echo "  .env       - Additional environment variables"
	@echo ""

# Installation and Setup
install: ## Install all dependencies (npm + convex)
	@echo "⚡ Installing dependencies..."
	npm install
	@echo "✅ Dependencies installed"

deps: install ## Alias for install

env-check: ## Check if required environment variables are set
	@echo "🔍 Checking environment variables..."
	@if [ ! -f .env.local ]; then echo "❌ .env.local not found"; exit 1; fi
	@if [ ! -f .env ]; then echo "❌ .env not found"; exit 1; fi
	@grep -q "VENICE_API_KEY" .env.local || (echo "❌ VENICE_API_KEY not found in .env.local"; exit 1)
	@grep -q "VITE_CONVEX_URL" .env.local || (echo "❌ VITE_CONVEX_URL not found in .env.local"; exit 1)
	@echo "✅ Environment variables check passed"

# Development
dev: env-check ## Start development server with netlify dev
	@echo "🚀 Starting Netlify dev server..."
	netlify dev

dev-simple: env-check ## Start simple TanStack dev server (no netlify)
	@echo "🚀 Starting TanStack dev server..."
	npm run dev

convex-dev: ## Start Convex development server
	@echo "🔄 Starting Convex dev server..."
	npx convex dev

agents-deploy: ## Deploy Convex agents to development
	@echo "🤖 Deploying AI agents to Convex..."
	npx convex deploy --component=agent

# Building and Production
build: env-check ## Build the application for production
	@echo "🏗️  Building application..."
	npm run build
	@echo "✅ Build completed"

serve: build ## Serve the built application locally
	@echo "🌐 Serving built application..."
	npm run serve

# Convex Operations
convex-deploy: ## Deploy to Convex production
	@echo "🚀 Deploying to Convex production..."
	npx convex deploy

convex-reset: ## Reset Convex development database (DESTRUCTIVE)
	@echo "⚠️  WARNING: This will delete all data in development database!"
	@read -p "Are you sure? (y/N): " confirm && [ "$$confirm" = "y" ] || exit 1
	npx convex dev --clear

# Code Quality
lint: ## Run linting checks
	@echo "🔍 Running linting..."
	@if command -v eslint >/dev/null 2>&1; then \
		npx eslint src/ convex/ --ext .ts,.tsx,.js,.jsx; \
	else \
		echo "⚠️  ESLint not configured"; \
	fi

format: ## Format code with prettier
	@echo "💅 Formatting code..."
	@if command -v prettier >/dev/null 2>&1; then \
		npx prettier --write "src/**/*.{ts,tsx,js,jsx,css,md}" "convex/**/*.{ts,js}"; \
	else \
		echo "⚠️  Prettier not configured"; \
	fi

typecheck: ## Run TypeScript type checking
	@echo "📝 Running type checks..."
	npx tsc --noEmit

check: lint typecheck ## Run all code quality checks

# Testing
test: ## Run tests (if configured)
	@echo "🧪 Running tests..."
	@if [ -f "package.json" ] && grep -q '"test"' package.json; then \
		npm test; \
	else \
		echo "⚠️  No tests configured"; \
	fi

# Maintenance
clean: ## Clean build artifacts and dependencies
	@echo "🧹 Cleaning build artifacts..."
	rm -rf dist/
	rm -rf .vinxi/
	rm -rf node_modules/.cache/
	rm -rf .netlify/
	@echo "✅ Clean completed"

clean-all: clean ## Deep clean including node_modules
	@echo "🧹 Deep cleaning..."
	rm -rf node_modules/
	@echo "✅ Deep clean completed - run 'make install' to reinstall"

restart: stop dev ## Restart development server

# Status and Monitoring
status: ## Show project status and running services
	@echo "📊 Jarlsmad Tavern Status"
	@echo "========================"
	@echo ""
	@echo "🔧 Development dependencies:"
	@command -v node >/dev/null 2>&1 && echo "  ✅ Node.js: $$(node --version)" || echo "  ❌ Node.js not found"
	@command -v npm >/dev/null 2>&1 && echo "  ✅ npm: $$(npm --version)" || echo "  ❌ npm not found"
	@command -v netlify >/dev/null 2>&1 && echo "  ✅ Netlify CLI: $$(netlify --version)" || echo "  ❌ Netlify CLI not found"
	@command -v npx >/dev/null 2>&1 && echo "  ✅ npx available" || echo "  ❌ npx not found"
	@echo ""
	@echo "📁 Project files:"
	@[ -f package.json ] && echo "  ✅ package.json" || echo "  ❌ package.json missing"
	@[ -f .env.local ] && echo "  ✅ .env.local" || echo "  ❌ .env.local missing"
	@[ -f .env ] && echo "  ✅ .env" || echo "  ❌ .env missing"
	@[ -d convex ] && echo "  ✅ convex/" || echo "  ❌ convex/ missing"
	@[ -d src ] && echo "  ✅ src/" || echo "  ❌ src/ missing"
	@echo ""
	@echo "🚀 Running processes:"
	@pgrep -f "netlify dev" >/dev/null && echo "  ✅ Netlify dev server running" || echo "  ❌ Netlify dev server not running"
	@pgrep -f "convex dev" >/dev/null && echo "  ✅ Convex dev server running" || echo "  ❌ Convex dev server not running"

logs: ## Show recent logs (if any log files exist)
	@echo "📋 Recent logs:"
	@if [ -f ".netlify/functions-serve.log" ]; then \
		echo "Netlify logs:"; \
		tail -20 .netlify/functions-serve.log; \
	else \
		echo "No log files found"; \
	fi

stop: ## Stop development servers
	@echo "🛑 Stopping development servers..."
	@pkill -f "netlify dev" 2>/dev/null || true
	@pkill -f "convex dev" 2>/dev/null || true
	@pkill -f "vinxi dev" 2>/dev/null || true
	@echo "✅ Servers stopped"

# Deployment
deploy: build ## Deploy to production (requires proper setup)
	@echo "🚀 Deploying to production..."
	@if command -v netlify >/dev/null 2>&1; then \
		netlify deploy --prod; \
	else \
		echo "❌ Netlify CLI not found. Install with: npm install -g netlify-cli"; \
	fi

# Quick development workflow
quick-start: install dev ## Quick start: install deps and start dev server

# Documentation
docs: ## Generate or view documentation
	@echo "📚 Documentation:"
	@echo "  - README.md: Project overview and setup"
	@echo "  - FOR_CLAUDE.md: AI context documentation"
	@echo "  - convex/README.md: Database schema info"
	@echo "  - View online: https://docs.anthropic.com/en/docs/claude-code"

# Advanced development
debug: ## Start development with debugging enabled
	@echo "🐛 Starting debug mode..."
	DEBUG=* make dev

# Environment management
env-template: ## Create .env template files
	@echo "📝 Creating environment template files..."
	@if [ ! -f .env.example ]; then \
		echo "# Venice AI configuration\nVENICE_API_KEY=your-venice-api-key-here\nVITE_VENICE_API_KEY=your-venice-api-key-here\n\n# Convex configuration\nVITE_CONVEX_URL=your-convex-deployment-url-here\n\n# Sentry configuration\nVITE_SENTRY_DSN=your-sentry-dsn-here\nSENTRY_AUTH_TOKEN=your-sentry-auth-token-here" > .env.example; \
	fi
	@echo "✅ Check .env.example for required variables"

# Game-specific commands
game-reset: convex-reset ## Reset game state (alias for convex-reset)

agents-status: ## Check status of deployed agents
	@echo "🤖 Checking Convex agents status..."
	npx convex logs --component=agent

# Development tools
tunnel: ## Create public tunnel for testing (requires ngrok)
	@if command -v ngrok >/dev/null 2>&1; then \
		echo "🌍 Creating public tunnel..."; \
		ngrok http 8888; \
	else \
		echo "❌ ngrok not found. Install from: https://ngrok.com/"; \
	fi

# Default target
.DEFAULT_GOAL := help