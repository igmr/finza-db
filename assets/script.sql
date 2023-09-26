DROP DATABASE IF EXISTS dbFinance;
CREATE DATABASE IF NOT EXISTS dbFinance;
USE dbFinance;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users
(
    usr_id          INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador del usuario.",
    usr_name        VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Nombre propio del usuario.",
    usr_email       VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Correo electrónico del usuario.",
    usr_username    VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Nombre de usuario para el acceso al sistema.",
    usr_password    VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Contraseña de acceso del usuario.",
    usr_observation TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones del usuario.",
    usr_file        VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    usr_status      CHAR(10)          NULL DEFAULT NULL   COMMENT "Estatus actual de usuario: [activo | inactivo].",
    usr_created_at  DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    usr_updated_at  DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    usr_deleted_at  DATETIME          NULL DEFAULT NULL   COMMENT "Información de auditoria.",
    CONSTRAINT      pkUser        PRIMARY KEY(usr_id),
    CONSTRAINT      ukUser        UNIQUE(usr_email, usr_username)
) COMMENT "Lista de usuarios con privilegios para el acceso al sistema.";

DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories
(
    cta_id           INT            NOT NULL AUTO_INCREMENT COMMENT "Identificador de categoría.",
    cta_usr_id       INT                NULL DEFAULT 1      COMMENT "Clave foráneo de tabla users.",
    cta_code         CHAR(10)           NULL DEFAULT NULL   COMMENT "Código de la categoría.",
    cta_description  VARCHAR(255)       NULL DEFAULT NULL   COMMENT "Descripción de la categoría.",
    cta_icon         VARCHAR(15)        NULL DEFAULT NULL   COMMENT "Icono de categoría.",
    cta_type         VARCHAR(15)        NULL DEFAULT NULL   COMMENT "Tipo: [ingreso | egreso].",
    cta_observation  TEXT               NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la categoría.",
    cat_file         VARCHAR(150)       NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    cta_status       CHAR(10)           NULL DEFAULT NULL   COMMENT "Estatus actual de categoría: [activo | inactivo].",
    cta_created_at   DATETIME           NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    cta_updated_at   DATETIME           NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    cta_deleted_at   DATETIME           NULL DEFAULT NULL   COMMENT "Información de auditoria.",
    CONSTRAINT       pkCategory     PRIMARY KEY(cta_id),
    CONSTRAINT       ukCategory     UNIQUE(cta_description),
    CONSTRAINT       fkCategoryUser FOREIGN KEY(cta_usr_id) REFERENCES users(usr_id)
) COMMENT "Lista de categorías para clasificar los tipos";

DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts
(
    acc_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador de cuenta.",
    acc_usr_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla users.",
    acc_name         VARCHAR(65)       NULL DEFAULT NULL   COMMENT "Nombre corto de cuenta.",
    acc_bank         VARCHAR(65)       NULL DEFAULT NULL   COMMENT "Nombre del banco o cuenta principal.",
    acc_amount       DOUBLE            NULL DEFAULT 0      COMMENT "Saldo inicial de la cuenta.",
    acc_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la cuenta.",
    acc_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    acc_status       CHAR(10)          NULL DEFAULT NULL   COMMENT "Estatus actual de cuenta: [activo | inactivo].",
    acc_created_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    acc_updated_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    acc_deleted_at   DATETIME          NULL DEFAULT NULL   COMMENT "Información de auditoria.",
    CONSTRAINT       pkAccount     PRIMARY KEY(acc_id),
    CONSTRAINT       ukAccount     UNIQUE(acc_name),
    CONSTRAINT       fkAccountUser FOREIGN KEY(acc_usr_id) REFERENCES users(usr_id)
) COMMENT "Lista de cuentas activas.";

DROP TABLE IF EXISTS budgets;
CREATE TABLE IF NOT EXISTS budgets
(
    bud_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador del presupuesto.",
    bud_usr_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla users.",
    bud_acc_id       INT               NULL DEFAULT NULL   COMMENT "Opcional. Clave foráneo, si el presupuesto se basará sobre cuentas.",
    bud_description  VARCHAR(65)       NULL DEFAULT NULL   COMMENT "Descripción del presupuesto.",
    bud_amount       DOUBLE            NULL DEFAULT NULL   COMMENT "Importe de presupuesto.",
    bud_period       CHAR(15)          NULL DEFAULT NULL   COMMENT "Tipo de presupuesto: [diario|quincenal|mensual|anual].",
    bud_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones del presupuesto.",
    bud_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    bud_status       CHAR(10)          NULL DEFAULT NULL   COMMENT "Estatus actual de presupuesto: [activo | inactivo].",
    bud_created_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    bud_updated_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    bud_deleted_at   DATETIME          NULL DEFAULT NULL   COMMENT "Información de auditoria.",
    CONSTRAINT       pkBudget          PRIMARY KEY(bud_id),
    CONSTRAINT       ukBudget          UNIQUE(bud_description),
    CONSTRAINT       fkBudgetUser      FOREIGN KEY(bud_usr_id) REFERENCES users(usr_id),
    CONSTRAINT       fkBudgetAccount   FOREIGN KEY(bud_acc_id) REFERENCES accounts(acc_id)
) COMMENT "Administración de presupuesto.";

DROP TABLE IF EXISTS transactions;
CREATE TABLE IF NOT EXISTS transactions
(
    tra_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador de transacción.",
    tra_usr_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla users.",
    tra_cat_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla categories.",
    tra_acc_id_from  INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla accounts, para cuenta origen.",
    tra_acc_id_to    INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla accounts, para cuenta destino.",
    tra_amount       DOUBLE            NULL DEFAULT NULL   COMMENT "Importe de transacción.",
    tra_type         CHAR(25)          NULL DEFAULT NULL   COMMENT "Tipo de transacción: [ingreso | egreso].",
    tra_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la transacción.",
    tra_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    tra_created_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    tra_updated_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    CONSTRAINT       pkTransaction            PRIMARY KEY(tra_id),
    CONSTRAINT       fkTransactionUser        FOREIGN KEY(tra_usr_id)      REFERENCES users(usr_id),
    CONSTRAINT       fkTransactionCategory    FOREIGN KEY(tra_cat_id)      REFERENCES categories(cta_id),
    CONSTRAINT       fkTransactionAccountFrom FOREIGN KEY(tra_acc_id_from) REFERENCES accounts(acc_id),
    CONSTRAINT       fkTransactionAccountTo   FOREIGN KEY(tra_acc_id_to)   REFERENCES accounts(acc_id)
) COMMENT "Administración de operaciones de ingreso y egresos";

DROP TABLE IF EXISTS details_transactions;
CREATE TABLE IF NOT EXISTS details_transactions
(
    dtt_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador de transacción.",
    dtt_usr_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla users.",
    dtt_cat_id       INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla categories.",
    dtt_acc_id_from  INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla accounts, para cuenta origen.",
    dtt_acc_id_to    INT               NULL DEFAULT 1      COMMENT "Clave foráneo de tabla accounts, para cuenta destino.",
    dtt_amount       DOUBLE            NULL DEFAULT NULL   COMMENT "Importe de transacción.",
    dtt_type         CHAR(25)          NULL DEFAULT NULL   COMMENT "Tipo de transacción: [ingreso | egreso].",
    dtt_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la transacción.",
    dtt_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, carga de archivo.",
    dtt_created_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    dtt_updated_at   DATETIME          NULL DEFAULT NOW()  COMMENT "Información de auditoria.",
    CONSTRAINT       pkDetailTransaction    PRIMARY KEY(dtt_id)
) COMMENT "Administración de operaciones de ingreso y egresos";
