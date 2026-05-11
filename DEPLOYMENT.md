# AgriFinance Platform - Full-Stack Serverless Deployment Guide

## Overview
AgriFinance is a React + TypeScript platform for agricultural financial management and accounting collaboration. This guide covers deploying to Vercel with Neon PostgreSQL.

## Prerequisites
1. **GitHub Account** - Required for Vercel deployment
2. **Vercel Account** - Sign up at https://vercel.com
3. **Neon Account** - PostgreSQL provider at https://neon.tech

## Deployment Steps

### Step 1: Set up PostgreSQL Database (Neon)

1. Go to https://neon.tech and create a free account
2. Create a new project
3. Copy your `DATABASE_URL` from the Connection String section
4. Run the SQL schema:
   - Open Neon's SQL editor or psql
   - Copy the contents of `database.sql`
   - Execute it to create all tables

### Step 2: Push to GitHub

```bash
cd c:\Users\HP\Desktop\agrifinance

# Initialize git (if not done)
git init
git add .
git commit -m "Initial commit - AgriFinance serverless setup"

# Create a new repo on GitHub at github.com/new
# Then push:
git remote add origin https://github.com/YOUR_USERNAME/agrifinance.git
git branch -M main
git push -u origin main
```

### Step 3: Deploy to Vercel

1. Go to https://vercel.com/new
2. Click **Import Project**
3. Select your GitHub repo (`agrifinance`)
4. Leave settings as default
5. Go to **Environment Variables** and add:
   - `DATABASE_URL` = Your Neon PostgreSQL connection string
   - `GEMINI_API_KEY` = Your Google Gemini API key
6. Click **Deploy**

### Step 4: Update Frontend API Calls

After Vercel deployment, update your API endpoints:

- Local: `http://localhost:3000/api/...`
- Production: `https://your-vercel-app.vercel.app/api/...`

Frontend automatically detects environment and adjusts base URL.

## Environment Variables

Required in Vercel:
- `DATABASE_URL` - PostgreSQL connection string from Neon
- `GEMINI_API_KEY` - Google Gemini API key for AI advice

## API Endpoints

All endpoints are now serverless functions in `/api/`:

- `POST /api/auth?action=register` - Register user
- `POST /api/auth?action=login` - Login user
- `GET /api/transactions` - Get transactions
- `POST /api/transactions` - Create transaction
- `GET /api/accountants` - Get accountant directory
- `POST /api/collaborations/request` - Request collaboration
- etc.

## Local Development

```bash
npm install
npm run build  # Build React frontend
npm run dev    # Run local development server
```

The app will be available at `http://localhost:3000`

## Project Structure

```
agrifinance/
├── src/
│   ├── App.tsx           # Main React component
│   ├── main.tsx          # React entry point
│   └── ...
├── api/                  # Vercel serverless functions
│   ├── auth.ts           # Authentication endpoints
│   ├── db.ts             # Database connection utility
│   └── ...
├── vercel.json           # Vercel configuration
├── database.sql          # PostgreSQL schema
└── package.json          # Dependencies
```

## Features

- **Farmer Dashboard**: Track income/expenses, find accountants, request services
- **Accountant Dashboard**: Manage clients, review service requests, provide insights
- **Real-time Chat**: Direct messaging between farmers and accountants
- **AI Advice**: Gemini-powered agricultural recommendations
- **Multi-language**: French (FR) and Arabic (AR) support
- **File Management**: Upload CVs, diplomas, documents

## Troubleshooting

### Database Connection Errors
- Verify `DATABASE_URL` format in Vercel environment variables
- Check Neon console for active connection pools
- Ensure all tables were created via `database.sql`

### API Returns 404
- Vercel serverless functions must be in `/api/` directory
- Check file names match route paths
- Verify `vercel.json` configuration

### CORS Issues
- All API handlers include CORS headers
- Frontend should be able to call from any origin

## Support

For issues or questions, check:
- Neon documentation: https://neon.tech/docs
- Vercel docs: https://vercel.com/docs
- React documentation: https://react.dev
