
USE dbFinance;

INSERT INTO users(id, name, email, password, status, created_at)
VALUES(001, 'demo', 'demo@demo.com', '$2y$10$5SFjm0x0JlQm4YIlki/5luRMnE5eiohMPQ8pmvSonX01r8kStQCAS', 'Activo', NOW()); -- gPassword#321

INSERT INTO banks (id, usr_id, name, status, created_at) VALUES (001, 001, 'Efectivo'      , 'Activo', NOW());
INSERT INTO banks (id, usr_id, name, status, created_at) VALUES (002, 001, 'Banco Azteca'  , 'Activo', NOW());
INSERT INTO banks (id, usr_id, name, status, created_at) VALUES (003, 001, 'BBVA'          , 'Activo', NOW());
INSERT INTO banks (id, usr_id, name, status, created_at) VALUES (004, 001, 'Hey Banco'     , 'Activo', NOW());
INSERT INTO banks (id, usr_id, name, status, created_at) VALUES (005, 001, 'Banbajio'      , 'Activo', NOW());

INSERT INTO accounts (id, usr_id, ban_id, name, status, created_at) VALUES (001, 001, 001, 'Principal', 'Activo', NOW());
INSERT INTO accounts (id, usr_id, ban_id, name, status, created_at) VALUES (002, 001, 002, 'Principal', 'Activo', NOW());
INSERT INTO accounts (id, usr_id, ban_id, name, status, created_at) VALUES (003, 001, 003, 'Principal', 'Activo', NOW());
INSERT INTO accounts (id, usr_id, ban_id, name, status, created_at) VALUES (004, 001, 004, 'Principal', 'Activo', NOW());
INSERT INTO accounts (id, usr_id, ban_id, name, status, created_at) VALUES (005, 001, 005, 'Principal', 'Activo', NOW());

INSERT INTO categories (id, usr_id, code, name, status, created_at) VALUES (001, 001, 'CAT-002', 'Gastos' , 'Activo', NOW());

INSERT INTO classifications (id, usr_id, code, name, status, created_at) VALUES (001, 001, 'CLS-002', 'Ingreso', 'Activo', NOW());

INSERT INTO budgets (id, usr_id, name, amount, period, status, created_at) VALUES (001, 001, 'Diario'    ,   200.00, 'Diario'    , 'Activo', NOW());
INSERT INTO budgets (id, usr_id, name, amount, period, status, created_at) VALUES (002, 001, 'Semanal'   ,  1400.00, 'Semanal'   , 'Activo', NOW());
INSERT INTO budgets (id, usr_id, name, amount, period, status, created_at) VALUES (003, 001, 'Quincenal' ,  2800.00, 'Quincenal' , 'Activo', NOW());
INSERT INTO budgets (id, usr_id, name, amount, period, status, created_at) VALUES (004, 001, 'Mensual'   ,  5600.00, 'Mensual'   , 'Activo', NOW());
INSERT INTO budgets (id, usr_id, name, amount, period, status, created_at) VALUES (005, 001, 'Anual'     , 67200.00, 'Anual'     , 'Activo', NOW());

INSERT INTO savings (id, usr_id, name, amount, date_finish, status, created_at) VALUES (001, 001, 'Ahorro anual', 2400.00, '2023-12-31', 'Activo', NOW());
