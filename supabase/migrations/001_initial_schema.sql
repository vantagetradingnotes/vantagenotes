-- Database schema for Trading Journal & Analytics (v1)

-- AUTH
CREATE TABLE profiles (
    id UUID PRIMARY KEY REFERENCES auth.users(id) ON DELETE CASCADE,
    timezone TEXT DEFAULT 'UTC',
    currency TEXT DEFAULT 'USD',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

-- INSTRUMENTS
CREATE TABLE instruments (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    symbol TEXT UNIQUE NOT NULL,
    name TEXT,
    asset_type TEXT,
    exchange TEXT,
    currency TEXT DEFAULT 'USD'
);

CREATE TABLE futures_contracts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    instrument_id UUID REFERENCES instruments(id) ON DELETE CASCADE,
    root_symbol TEXT,
    contract_month TEXT,
    expiration_date DATE,
    first_notice_date DATE,
    last_trade_date DATE,
    tick_size NUMERIC(20, 8),
    tick_value NUMERIC(20, 8),
    contract_multiplier NUMERIC(20, 8),
    point_value NUMERIC(20, 8)
);

-- TRADING
CREATE TABLE trading_accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    broker TEXT,
    account_type TEXT,
    initial_balance NUMERIC(20, 8),
    currency TEXT DEFAULT 'USD',
    status TEXT DEFAULT 'active',
    commission_per_contract NUMERIC(20, 8),
    exchange_fee NUMERIC(20, 8),
    regulatory_fee NUMERIC(20, 8),
    clearing_fee NUMERIC(20, 8)
);

CREATE TABLE account_snapshots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES trading_accounts(id) ON DELETE CASCADE,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    balance NUMERIC(20, 8),
    equity NUMERIC(20, 8),
    margin NUMERIC(20, 8),
    available_funds NUMERIC(20, 8)
);

CREATE TABLE trading_days (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    market_bias TEXT,
    plan TEXT,
    mood TEXT,
    lessons TEXT,
    notes TEXT,
    UNIQUE(user_id, date)
);

CREATE TABLE strategies (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    entry_rules TEXT,
    exit_rules TEXT,
    risk_rules TEXT,
    market_conditions TEXT,
    checklist TEXT
);

CREATE TABLE tag_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    UNIQUE(user_id, name)
);

CREATE TABLE tags (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    category_id UUID REFERENCES tag_categories(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    UNIQUE(category_id, name)
);

CREATE TABLE prop_firms (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    profit_target NUMERIC(20, 8),
    trailing_drawdown NUMERIC(20, 8),
    daily_loss_limit NUMERIC(20, 8),
    consistency_rule TEXT
);

CREATE TABLE prop_accounts (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    prop_firm_id UUID REFERENCES prop_firms(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    starting_balance NUMERIC(20, 8),
    current_balance NUMERIC(20, 8),
    status TEXT DEFAULT 'active'
);

CREATE TABLE goals (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    description TEXT,
    rule TEXT,
    target_value NUMERIC(20, 8)
);

CREATE TABLE backtest_sessions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    name TEXT NOT NULL,
    symbol TEXT NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE,
    starting_balance NUMERIC(20, 8),
    ending_balance NUMERIC(20, 8),
    status TEXT DEFAULT 'pending'
);

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES trading_accounts(id) ON DELETE CASCADE,
    instrument_id UUID REFERENCES instruments(id),
    direction TEXT NOT NULL CHECK (direction IN ('long', 'short')),
    quantity NUMERIC(20, 8) NOT NULL,
    price NUMERIC(20, 8),
    order_type TEXT NOT NULL,
    status TEXT NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    strategy_id UUID REFERENCES strategies(id),
    notes TEXT
);

CREATE TABLE executions (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    order_id UUID REFERENCES orders(id) ON DELETE CASCADE,
    side TEXT NOT NULL CHECK (side IN ('buy', 'sell')),
    quantity NUMERIC(20, 8) NOT NULL,
    price NUMERIC(20, 8) NOT NULL,
    commission NUMERIC(20, 8),
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL
);

CREATE TABLE trades (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    account_id UUID REFERENCES trading_accounts(id) ON DELETE CASCADE,
    instrument_id UUID REFERENCES instruments(id),
    direction TEXT NOT NULL CHECK (direction IN ('long', 'short')),
    quantity NUMERIC(20, 8) NOT NULL,
    entry_price NUMERIC(20, 8),
    exit_price NUMERIC(20, 8),
    entry_time TIMESTAMP WITH TIME ZONE,
    exit_time TIMESTAMP WITH TIME ZONE,
    gross_pnl NUMERIC(20, 8),
    commission NUMERIC(20, 8),
    fees NUMERIC(20, 8),
    net_pnl NUMERIC(20, 8),
    stop_loss NUMERIC(20, 8),
    take_profit NUMERIC(20, 8),
    planned_r NUMERIC(20, 8),
    realized_r NUMERIC(20, 8),
    mae NUMERIC(20, 8),
    mfe NUMERIC(20, 8),
    rating INTEGER,
    notes TEXT,
    strategy_id UUID REFERENCES strategies(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE trade_tags (
    trade_id UUID REFERENCES trades(id) ON DELETE CASCADE,
    tag_id UUID REFERENCES tags(id) ON DELETE CASCADE,
    PRIMARY KEY (trade_id, tag_id)
);

CREATE TABLE journal_entries (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES auth.users(id) ON DELETE CASCADE,
    date DATE NOT NULL,
    market_bias TEXT,
    plan TEXT,
    mood TEXT,
    lessons TEXT,
    notes TEXT,
    UNIQUE(user_id, date)
);

CREATE TABLE market_data (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    instrument_id UUID REFERENCES instruments(id),
    timestamp TIMESTAMP WITH TIME ZONE NOT NULL,
    open NUMERIC(20, 8),
    high NUMERIC(20, 8),
    low NUMERIC(20, 8),
    close NUMERIC(20, 8),
    volume NUMERIC(20, 8),
    UNIQUE(instrument_id, timestamp)
);

-- Indexes for performance
CREATE INDEX idx_trades_account_id ON trades(account_id);
CREATE INDEX idx_trades_instrument_id ON trades(instrument_id);
CREATE INDEX idx_executions_order_id ON executions(order_id);
CREATE INDEX idx_executions_timestamp ON executions(timestamp);
CREATE INDEX idx_orders_account_id ON orders(account_id);
CREATE INDEX idx_orders_instrument_id ON orders(instrument_id);
CREATE INDEX idx_orders_timestamp ON orders(timestamp);
CREATE INDEX idx_market_data_instrument_id ON market_data(instrument_id);
CREATE INDEX idx_market_data_timestamp ON market_data(timestamp);

-- Row Level Security
ALTER TABLE profiles ENABLE ROW LEVEL SECURITY;
ALTER TABLE trading_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE account_snapshots ENABLE ROW LEVEL SECURITY;
ALTER TABLE trading_days ENABLE ROW LEVEL SECURITY;
ALTER TABLE strategies ENABLE ROW LEVEL SECURITY;
ALTER TABLE tag_categories ENABLE ROW LEVEL SECURITY;
ALTER TABLE tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE prop_firms ENABLE ROW LEVEL SECURITY;
ALTER TABLE prop_accounts ENABLE ROW LEVEL SECURITY;
ALTER TABLE goals ENABLE ROW LEVEL SECURITY;
ALTER TABLE backtest_sessions ENABLE ROW LEVEL SECURITY;
ALTER TABLE orders ENABLE ROW LEVEL SECURITY;
ALTER TABLE executions ENABLE ROW LEVEL SECURITY;
ALTER TABLE trades ENABLE ROW LEVEL SECURITY;
ALTER TABLE trade_tags ENABLE ROW LEVEL SECURITY;
ALTER TABLE journal_entries ENABLE ROW LEVEL SECURITY;
ALTER TABLE market_data ENABLE ROW LEVEL SECURITY;

-- RLS Policies
CREATE POLICY "profiles_policy" ON profiles
    USING (auth.uid() = id);

CREATE POLICY "trading_accounts_policy" ON trading_accounts
    USING (user_id = auth.uid());

CREATE POLICY "account_snapshots_policy" ON account_snapshots
    USING (account_id IN (SELECT id FROM trading_accounts WHERE user_id = auth.uid()));

CREATE POLICY "trading_days_policy" ON trading_days
    USING (user_id = auth.uid());

CREATE POLICY "strategies_policy" ON strategies
    USING (user_id = auth.uid());

CREATE POLICY "tag_categories_policy" ON tag_categories
    USING (user_id = auth.uid());

CREATE POLICY "tags_policy" ON tags
    USING (category_id IN (SELECT id FROM tag_categories WHERE user_id = auth.uid()));

CREATE POLICY "prop_firms_policy" ON prop_firms
    USING (user_id = auth.uid());

CREATE POLICY "prop_accounts_policy" ON prop_accounts
    USING (prop_firm_id IN (SELECT id FROM prop_firms WHERE user_id = auth.uid()));

CREATE POLICY "goals_policy" ON goals
    USING (user_id = auth.uid());

CREATE POLICY "backtest_sessions_policy" ON backtest_sessions
    USING (user_id = auth.uid());

CREATE POLICY "orders_policy" ON orders
    USING (account_id IN (SELECT id FROM trading_accounts WHERE user_id = auth.uid()));

CREATE POLICY "executions_policy" ON executions
    USING (order_id IN (SELECT id FROM orders WHERE account_id IN (SELECT id FROM trading_accounts WHERE user_id = auth.uid())));

CREATE POLICY "trades_policy" ON trades
    USING (account_id IN (SELECT id FROM trading_accounts WHERE user_id = auth.uid()));

CREATE POLICY "trade_tags_policy" ON trade_tags
    USING (trade_id IN (SELECT id FROM trades WHERE account_id IN (SELECT id FROM trading_accounts WHERE user_id = auth.uid())));

CREATE POLICY "journal_entries_policy" ON journal_entries
    USING (user_id = auth.uid());

CREATE POLICY "market_data_policy" ON market_data
    USING (instrument_id IN (SELECT id FROM instruments));
