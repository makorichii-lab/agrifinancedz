-- AgriFinance Platform Database Schema for Neon PostgreSQL

CREATE TABLE IF NOT EXISTS users (
  id SERIAL PRIMARY KEY,
  email TEXT UNIQUE NOT NULL,
  password TEXT NOT NULL,
  name TEXT NOT NULL,
  role TEXT NOT NULL CHECK(role IN ('farmer', 'accountant')),
  language TEXT DEFAULT 'fr',
  activity_type TEXT,
  nin TEXT,
  tax_id TEXT,
  phone TEXT,
  cv_path TEXT,
  diploma_path TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS transactions (
  id SERIAL PRIMARY KEY,
  farmer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK(type IN ('income', 'expense')),
  amount DECIMAL(15, 2) NOT NULL,
  date TEXT NOT NULL,
  description TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS collaborations (
  id SERIAL PRIMARY KEY,
  farmer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  accountant_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  status TEXT DEFAULT 'pending' CHECK(status IN ('pending', 'active', 'rejected')),
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS messages (
  id SERIAL PRIMARY KEY,
  sender_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  receiver_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  content TEXT NOT NULL,
  is_read INTEGER DEFAULT 0,
  timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS service_requests (
  id SERIAL PRIMARY KEY,
  farmer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  accountant_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  type TEXT NOT NULL,
  status TEXT DEFAULT 'pending',
  description TEXT,
  response_message TEXT,
  response_file TEXT,
  request_file TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE IF NOT EXISTS ratings (
  id SERIAL PRIMARY KEY,
  farmer_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  accountant_id INTEGER NOT NULL REFERENCES users(id) ON DELETE CASCADE,
  rating INTEGER NOT NULL CHECK(rating >= 1 AND rating <= 5),
  comment TEXT,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  UNIQUE(farmer_id, accountant_id)
);

-- Create indexes for better performance
CREATE INDEX IF NOT EXISTS idx_transactions_farmer ON transactions(farmer_id);
CREATE INDEX IF NOT EXISTS idx_collaborations_farmer ON collaborations(farmer_id);
CREATE INDEX IF NOT EXISTS idx_collaborations_accountant ON collaborations(accountant_id);
CREATE INDEX IF NOT EXISTS idx_messages_sender ON messages(sender_id);
CREATE INDEX IF NOT EXISTS idx_messages_receiver ON messages(receiver_id);
CREATE INDEX IF NOT EXISTS idx_service_requests_farmer ON service_requests(farmer_id);
CREATE INDEX IF NOT EXISTS idx_service_requests_accountant ON service_requests(accountant_id);
