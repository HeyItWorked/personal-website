# Development Workflow

## 🔄 Deployment Pipeline

```
┌─────────────┐    git push    ┌─────────────┐   auto-build   ┌─────────────────┐
│   Local     │ ─────────────→ │   GitHub    │ ─────────────→ │  Cloudflare     │
│  (dev)      │                │   (main)    │                │  Pages          │
└─────────────┘                └─────────────┘                └─────────────────┘
                                                                    │
                                                                    ▼
                                                          ┌─────────────────┐
                                                          │ liamnguyenn.com │
                                                          └─────────────────┘
```

## 🚀 Quick Start

### 1. Local Development

```bash
# Start dev server
bun run dev

# Open http://localhost:4321
```

### 2. Make Changes

Edit files in:
- `src/pages/` - Page content
- `src/components/` - Reusable components
- `src/content/` - Blog posts, projects, etc.
- `src/styles/global.css` - Global styles

### 3. Preview Build Locally

```bash
# Build and preview production version
bun run build
bun run preview
```

### 4. Commit & Push

```bash
# Stage changes
git add .

# Commit with descriptive message
git commit -m "feat: add new project card"

# Push to GitHub
git push origin main
```

### 5. Auto-Deploy 🎉

Cloudflare Pages will:
1. Detect the push to `main`
2. Run `bun install && bun run build`
3. Deploy to `liamnguyenn.com`
4. Send email notification

## 📋 Commit Message Conventions

| Prefix | Use for |
|--------|---------|
| `feat:` | New features |
| `fix:` | Bug fixes |
| `content:` | Blog posts, projects |
| `style:` | CSS/styling changes |
| `chore:` | Maintenance, config |
| `security:` | Security improvements |

Examples:
```bash
git commit -m "feat: add dark mode toggle"
git commit -m "content: add rust learning notes"
git commit -m "fix: mobile navigation"
```

## 🌿 Branch Strategy

### Main Branch (Production)
- `main` → Auto-deploys to `liamnguyenn.com`
- Only merge tested, working code

### Feature Branches (Optional)
```bash
# Create feature branch
git checkout -b feature/new-project

# Work on it...
git add .
git commit -m "feat: add new project"

# Push and create PR
git push origin feature/new-project
# Then create Pull Request on GitHub

# After PR merged, delete branch
git branch -d feature/new-project
```

## 🔍 Check Deployment Status

### Via GitHub
1. Go to **GitHub Repo** → **Actions** tab
2. See build status

### Via Cloudflare
1. Go to **Cloudflare Dashboard** → **Pages**
2. See deployment history

### Via CLI
```bash
# Check latest deployment
npx wrangler pages deployment list --project-name=personal-website
```

## ⚡ Pro Tips

### 1. Preview Deployments (Branch Previews)
- Push to any branch → Gets preview URL
- Example: `https://[branch-name].personal-website.pages.dev`

### 2. Rollback
If something breaks:
1. Go to Cloudflare Pages → Deployments
2. Find previous working version
3. Click **"Rollback"**

### 3. Environment Variables
If you need secrets:
1. Cloudflare Pages → Settings → Environment variables
2. Add variables for Production/Preview

### 4. Build Failures
If build fails:
```bash
# Check locally
bun run build

# Common issues:
# - TypeScript errors
# - Missing imports
# - Build command typo
```

## 📝 Content Updates

### Adding a New Project
1. Create `src/content/projects/my-project.mdx`
2. Add frontmatter (title, description, techStack, etc.)
3. Write content
4. `git add . && git commit -m "content: add my project" && git push`

### Adding a Garden Note
1. Create `src/content/garden/my-note.mdx`
2. Set `maturity: 'seedling'` (or 'budding', 'evergreen')
3. Push to GitHub → Auto-deploys

### Updating Bio/Info
1. Edit `src/pages/about.astro`
2. Commit and push

## 🔒 Security Checks

Every deployment automatically:
- ✅ Runs `bun audit` (dependency scan)
- ✅ Applies security headers from `_headers`
- ✅ Enforces HTTPS

## 📊 Monitoring

- **Analytics**: Cloudflare Dashboard → Analytics
- **Performance**: Real User Monitoring (RUM)
- **Security**: Security events in Cloudflare

---

## 🎯 Summary

1. **Develop locally** with `bun run dev`
2. **Commit often** with clear messages
3. **Push to main** → Auto-deploys in ~2 minutes
4. **Check email** for deployment notifications
5. **Visit** `https://liamnguyenn.com` 🎉
