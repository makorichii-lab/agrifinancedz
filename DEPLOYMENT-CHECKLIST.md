# AgriFinance - B2 Serverless Deployment Checklist

## ✅ Completed Setup

### Backend (Serverless Functions)
- ✓ Created `/api/` directory structure
- ✓ `api/db.ts` - PostgreSQL connection manager  
- ✓ `api/auth.ts` - Authentication endpoints (register, login, me, logout)
- ✓ `api/transactions.ts` - Transaction CRUD operations
- ✓ `api/accountants.ts` - Directory listing & ratings
- ✓ `api/collaborations.ts` - Farmer-accountant partnerships
- ✓ `api/messages.ts` - Real-time messaging
- ✓ `api/service-requests.ts` - Service request management

### Configuration
- ✓ `vercel.json` - Vercel deployment configuration
- ✓ `package.json` - Updated with PostgreSQL dependencies
- ✓ `database.sql` - Complete PostgreSQL schema
- ✓ `.env.example` - Environment variables template
- ✓ `src/lib/api.ts` - API client utility for serverless calls
- ✓ Updated auth endpoints in `src/App.tsx`

---

## 📋 Deployment Steps

### Step 1: Install Git (5 minutes)
**If not installed:**
1. Download: https://git-scm.com/download/win
2. Install with default settings
3. Restart terminal/VS Code

### Step 2: Push Code to GitHub (10 minutes)

```powershell
cd c:\Users\HP\Desktop\agrifinance

# Initialize git
git init
git add .
git commit -m "Initial commit - AgriFinance serverless setup"

# Create new repo on GitHub: https://github.com/new
# Name: agrifinance

# Then run these commands:
git remote add origin https://github.com/YOUR_USERNAME/agrifinance.git
git branch -M main
git push -u origin main
```

**Replace `YOUR_USERNAME` with your GitHub username**

### Step 3: Set up Neon PostgreSQL Database (10 minutes)

1. Go to: https://neon.tech
2. Sign up with GitHub (easiest)
3. Create new project
4. Copy the **Connection String** (DATABASE_URL)
5. Open Neon's SQL editor
6. Copy entire contents of `database.sql` from your project
7. Paste into Neon SQL editor and execute
8. Verify all tables created (users, transactions, collaborations, etc.)

**Save your DATABASE_URL** - you'll need it in Step 4

### Step 4: Deploy to Vercel (5 minutes)

1. Go to: https://vercel.com/new
2. Click **"Import Project"**
3. Select **"GitHub"**
4. Find and select your `agrifinance` repository
5. Click **"Import"**
6. Go to **"Environment Variables"** tab
7. Add these variables:
   - **DATABASE_URL** = Paste your Neon connection string
   - **GEMINI_API_KEY** = Your Google Gemini API key
8. Click **"Deploy"**
9. Wait 2-3 minutes for deployment to complete

**Your app will be available at:** `https://your-project.vercel.app`

---

## 🔗 API Endpoint Structure

All endpoints are now serverless functions with authentication via headers:

### Authentication
```
POST /api/auth?action=register  - Create new account
POST /api/auth?action=login     - Login user
GET  /api/auth?action=me        - Get current user (requires x-user-id header)
POST /api/auth?action=logout    - Logout
```

### Transactions
```
GET  /api/transactions                    - List user transactions
POST /api/transactions                    - Create transaction
PUT  /api/transactions?id=123             - Update transaction
DELETE /api/transactions?id=123           - Delete transaction
```

### Directory & Ratings
```
GET  /api/accountants              - List all accountants
POST /api/accountants              - Rate an accountant
```

### Collaborations
```
GET  /api/collaborations?action=list          - List collaborations
POST /api/collaborations?action=request       - Request collaboration
POST /api/collaborations?action=update        - Update collaboration status
```

### Messages
```
GET  /api/messages?action=unread-count        - Get unread count
GET  /api/messages?otherId=123                - Get conversation
POST /api/messages                            - Send message
```

### Service Requests
```
GET  /api/service-requests                    - List service requests
POST /api/service-requests                    - Create service request
POST /api/service-requests?action=respond&id=123  - Respond to request
```

**Required headers for authenticated endpoints:**
```
x-user-id:   [user_id]
x-user-role: [farmer|accountant]
```

---

## 🛠️ Frontend Updates

The frontend (`src/App.tsx`) has been partially updated. You'll need to update remaining fetch calls to include auth headers:

```typescript
// Old way (localhost only)
fetch('/api/transactions')

// New way (serverless)
fetch('/api/transactions', {
  headers: {
    'x-user-id': user.id.toString(),
    'x-user-role': user.role
  }
})
```

**User info is stored in localStorage after login:**
- `userId` - User ID
- `userRole` - farmer or accountant

---

## 📦 Testing Locally Before Deployment

```powershell
cd c:\Users\HP\Desktop\agrifinance

# Install dependencies (if not done)
npm install

# Build React frontend
npm run build

# Verify TypeScript (should show no errors)
npm run lint
```

---

## ✨ After Deployment

1. **Share your Vercel URL** - Your app is now public
2. **First user account** - Create an account to test
3. **Set up Neon backups** - Neon is in beta, backup important data
4. **Monitor Vercel** - Check Performance tab for any issues

---

## 🆘 Troubleshooting

### "Database connection failed"
- Check DATABASE_URL is correct in Vercel environment variables
- Verify database.sql was executed in Neon SQL editor
- Neon dashboard should show active connections

### "API returns 404"
- Verify serverless functions are in `/api/` directory
- Check function file names match route paths
- Rebuild: `npm run build`

### "Missing x-user-id header"
- Verify user is logged in and localStorage has userId
- Check frontend auth headers are being sent
- Verify localStorage keys: `userId`, `userRole`

### "Cannot find module 'pg'"
- Run: `npm install`
- Redeploy to Vercel

---

## 📚 Useful Links

- Vercel Docs: https://vercel.com/docs
- Neon PostgreSQL: https://neon.tech/docs
- React: https://react.dev
- TypeScript: https://www.typescriptlang.org

---

## 🎉 You're Done!

Your AgriFinance platform is now deployed and accessible to anyone with your Vercel URL.

**Platform Features:**
- ✓ Farmer dashboard with financial tracking
- ✓ Accountant directory with ratings
- ✓ Real-time messaging
- ✓ Service request management
- ✓ AI-powered agricultural advice
- ✓ Multi-language support (FR/AR)

Enjoy! 🚀
