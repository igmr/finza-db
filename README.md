# Base de datos

## Modelo relacional

![Modelo relacional](./assets/model-er.png)

## Script SQL

```sql
DROP DATABASE IF EXISTS dbFinance;
CREATE DATABASE IF NOT EXISTS dbFinance;
USE dbFinance;

DROP TABLE IF EXISTS users;
CREATE TABLE IF NOT EXISTS users
(
    usr_id          INT           NOT NULL AUTO_INCREMENT   COMMENT "Identificador único para la administración de los usuarios.",
    usr_name        VARCHAR(255)      NULL DEFAULT 1        COMMENT "Nombre propio del usuario.",
    usr_email       VARCHAR(255)      NULL DEFAULT NULL     COMMENT "Correo electrónico del usuario.",
    usr_username    VARCHAR(255)      NULL DEFAULT NULL     COMMENT "Nombre de usuario para el acceso al sistema.",
    usr_password    VARCHAR(255)      NULL DEFAULT NULL     COMMENT "Contraseña de acceso del usuario.",
    usr_observation TEXT              NULL DEFAULT NULL     COMMENT "Opcional, observaciones del usuario.",
    usr_file        VARCHAR(150)      NULL DEFAULT NULL     COMMENT "Opcional, carga de archivo.",
    usr_status      CHAR(10)          NULL DEFAULT "Activo" COMMENT "Estatus actual de usuario: [Activo | Inactivo].",
    usr_created_at  TIMESTAMP         NULL DEFAULT NOW()    COMMENT "Datos de auditoria, Fecha de alta del registro.",
    usr_updated_at  TIMESTAMP         NULL DEFAULT NOW()    COMMENT "Datos de auditoria, Fecha de actualización del registro.",
    usr_deleted_at  TIMESTAMP         NULL DEFAULT NULL     COMMENT "Datos de auditoria, Fecha de baja del registro.",
    CONSTRAINT      pkUser        PRIMARY KEY(usr_id),
    CONSTRAINT      ukUser        UNIQUE(usr_email, usr_username)
) COMMENT "Catalogo de usuarios con privilegios para el acceso al sistema.";

DROP TABLE IF EXISTS banks;
CREATE TABLE IF NOT EXISTS banks
(
    ban_id           INT          NOT NULL  AUTO_INCREMENT   COMMENT "Identificador único para el catalogo de bancos.",
    ban_usr_id       INT              NULL  DEFAULT 1        COMMENT "Identificador del usuario.",
    ban_abbreviature CHAR(25)         NULL  DEFAULT NULL     COMMENT "Abreviatura del banco.",
    ban_name         VARCHAR(65)      NULL  DEFAULT NULL     COMMENT "Nombre completo de banco.",
    ban_description  VARCHAR(255)     NULL  DEFAULT NULL     COMMENT "Opcional, descripción general del banco",
    ban_observation  TEXT             NULL  DEFAULT NULL     COMMENT "Opcional, observaciones generales del banco.",
    ban_file         VARCHAR(10)      NULL  DEFAULT NULL     COMMENT "Opcional, nombre del archivo.",
    ban_status       CHAR(10)         NULL  DEFAULT "Activo" COMMENT "Estatus actual del banco [Activo | Inactivo]",
    ban_created_at   TIMESTAMP        NULL  DEFAULT now()    COMMENT "Datos de auditoria, fecha de alta del registro",
    ban_updated_at   TIMESTAMP        NULL  DEFAULT now()    COMMENT "Datos de auditoria, fecha de actualización del registro",
    ban_deleted_at   TIMESTAMP        NULL  DEFAULT now()    COMMENT "Datos de auditoria, fecha de baja del registro",
    CONSTRAINT       pkBank       PRIMARY KEY(ban_id),
    CONSTRAINT       ukBank       UNIQUE(ban_name),
    CONSTRAINT       fkBankUser   FOREIGN KEY(ban_usr_id) REFERENCES users(usr_id)
) COMMENT "Catalogo de bancos.";

DROP TABLE IF EXISTS categories;
CREATE TABLE IF NOT EXISTS categories
(
    cta_id           INT            NOT NULL AUTO_INCREMENT   COMMENT "Identificador único para el catalogo de categorías.",
    cta_usr_id       INT                NULL DEFAULT 1        COMMENT "Identificador del usuario.",
    cta_code         CHAR(10)           NULL DEFAULT NULL     COMMENT "Opcional, código de la categoría.",
    cta_description  VARCHAR(255)       NULL DEFAULT NULL     COMMENT "Descripción de la categoría.",
    cta_icon         VARCHAR(15)        NULL DEFAULT NULL     COMMENT "Opcional, icono de categoría.",
    cta_type         VARCHAR(15)        NULL DEFAULT NULL     COMMENT "Tipo de categoría: [ingreso | egreso].",
    cta_observation  TEXT               NULL DEFAULT NULL     COMMENT "Opcional, observaciones de la categoría.",
    cat_file         VARCHAR(150)       NULL DEFAULT NULL     COMMENT "Opcional, nombre del archivo.",
    cta_status       CHAR(10)           NULL DEFAULT "Activo" COMMENT "Estatus actual de categoría: [Activo | Inactivo].",
    cta_created_at   TIMESTAMP          NULL DEFAULT NOW()    COMMENT "Datos de auditoria, fecha de alta del registro.",
    cta_updated_at   TIMESTAMP          NULL DEFAULT NOW()    COMMENT "Datos de auditoria, fecha de actualización del registro.",
    cta_deleted_at   TIMESTAMP          NULL DEFAULT NULL     COMMENT "Datos de auditoria, fecha de baja del registro.",
    CONSTRAINT       pkCategory     PRIMARY KEY(cta_id),
    CONSTRAINT       ukCategory     UNIQUE(cta_description),
    CONSTRAINT       fkCategoryUser FOREIGN KEY(cta_usr_id) REFERENCES users(usr_id)
) COMMENT "Lista de categorías para clasificar los tipos";

DROP TABLE IF EXISTS debts;
CREATE TABLE IF NOT EXISTS debts
(
    deb_id            INT         NOT NULL AUTO_INCREMENT  COMMENT "Identificador único para la administración de mis deudas.",
    deb_usr_id        INT             NULL DEFAULT 1       COMMENT "Identificador del usuario.",
    deb_name          VARCHAR(65)     NULL DEFAULT NULL    COMMENT "Nombre de la deuda.",
    deb_amount        DOUBLE          NULL DEFAULT 0       COMMENT "Importe total de la deuda.",
    deb_observation   TEXT            NULL DEFAULT NULL    COMMENT "Opcional, observaciones de la deuda.",
    deb_file          VARCHAR(150)    NULL DEFAULT NULL    COMMENT "Opcional, nombre del archivo.",
    deb_status        CHAR(10)        NULL DEFAULT NULL    COMMENT "Estatus actual de la deuda: [En curso | Completada | Cancelado ].",
    deb_created_at    TIMESTAMP       NULL DEFAULT NOW()   COMMENT "Datos de auditoria, fecha de alta del registro.",
    deb_updated_at    TIMESTAMP       NULL DEFAULT NOW()   COMMENT "Datos de auditoria, fecha de actualización del registro.",
    deb_deleted_at    TIMESTAMP       NULL DEFAULT NULL    COMMENT "Datos de auditoria, fecha de baja del registro.",
    CONSTRAINT        pkDebt          PRIMARY KEY(deb_id),
    CONSTRAINT        ukDebt          UNIQUE(deb_name)
) COMMENT "Administración de deudas.";

DROP TABLE IF EXISTS savings;
CREATE TABLE IF NOT EXISTS savings
(
    sav_id            INT         NOT NULL AUTO_INCREMENT  COMMENT "Identificador único para las cuentas de ahorro.",
    sav_usr_id        INT             NULL DEFAULT 1       COMMENT "Identificador del usuario.",
    sav_name          VARCHAR(65)     NULL DEFAULT NULL    COMMENT "Nombre de la cuenta de ahorro.",
    sav_amount        DOUBLE          NULL DEFAULT 0       COMMENT "Importe total para el ahorro.",
    sav_observation   TEXT            NULL DEFAULT NULL    COMMENT "Opcional, observaciones del ahorro.",
    sav_file          VARCHAR(150)    NULL DEFAULT NULL    COMMENT "Opcional, nombre del archivo.",
    sav_status        CHAR(10)        NULL DEFAULT NULL    COMMENT "Estatus actual del ahorro: [Activo | Inactivo].",
    sav_created_at    TIMESTAMP       NULL DEFAULT NOW()   COMMENT "Datos de auditoria, fecha de alta del registro.",
    sav_updated_at    TIMESTAMP       NULL DEFAULT NOW()   COMMENT "Datos de auditoria, fecha de actualización del registro.",
    sav_deleted_at    TIMESTAMP       NULL DEFAULT NULL    COMMENT "Datos de auditoria, fecha de bajo del registro.",
    CONSTRAINT        pkSaving        PRIMARY KEY(sav_id),
    CONSTRAINT        ukSaving        UNIQUE(sav_name)
) COMMENT "Administración de ahorros.";

DROP TABLE IF EXISTS accounts;
CREATE TABLE IF NOT EXISTS accounts
(
    acc_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador único para catálogos de cuentas bancarias.",
    acc_usr_id       INT               NULL DEFAULT 1      COMMENT "Identificador del usuario.",
    acc_ban_id       INT               NULL DEFAULT 1      COMMENT "Identificador del catalogo de bancos.",
    acc_name         VARCHAR(65)       NULL DEFAULT NULL   COMMENT "Nombre corto de cuenta.",
    acc_amount       DOUBLE            NULL DEFAULT 0      COMMENT "Importe inicial de la cuenta.",
    acc_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la cuenta.",
    acc_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, nombre de archivo.",
    acc_status       CHAR(10)          NULL DEFAULT NULL   COMMENT "Estatus actual de cuenta: [Activo | Inactivo].",
    acc_created_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de alta del registro.",
    acc_updated_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de actualización del registro.",
    acc_deleted_at   TIMESTAMP         NULL DEFAULT NULL   COMMENT "Datos de auditoria, fecha de baja del registro.",
    CONSTRAINT       pkAccount     PRIMARY KEY(acc_id),
    CONSTRAINT       ukAccount     UNIQUE(acc_name),
    CONSTRAINT       fkAccountUser FOREIGN KEY(acc_usr_id) REFERENCES users(usr_id),
    CONSTRAINT       fkAccountBank FOREIGN KEY(acc_ban_id) REFERENCES banks(ban_id)
) COMMENT "Catalogo de cuentas bancarias.";

DROP TABLE IF EXISTS budgets;
CREATE TABLE IF NOT EXISTS budgets
(
    bud_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador único del presupuesto.",
    bud_usr_id       INT               NULL DEFAULT 1      COMMENT "Identificador del usuario.",
    bud_acc_id       INT               NULL DEFAULT NULL   COMMENT "Opcional, presupuesto basado por cuentas.",
    bud_description  VARCHAR(65)       NULL DEFAULT NULL   COMMENT "Descripción del presupuesto.",
    bud_amount       DOUBLE            NULL DEFAULT NULL   COMMENT "Importe total del presupuesto.",
    bud_period       CHAR(15)          NULL DEFAULT NULL   COMMENT "Tipo de presupuesto: [diario|quincenal|mensual|anual].",
    bud_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones del presupuesto.",
    bud_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, nombre de archivo.",
    bud_status       CHAR(10)          NULL DEFAULT NULL   COMMENT "Estatus actual de presupuesto: [Activo | Inactivo].",
    bud_created_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de alta del registro.",
    bud_updated_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de actualización del registro.",
    bud_deleted_at   TIMESTAMP         NULL DEFAULT NULL   COMMENT "Datos de auditoria, fecha de baja del registro.",
    CONSTRAINT       pkBudget          PRIMARY KEY(bud_id),
    CONSTRAINT       ukBudget          UNIQUE(bud_description),
    CONSTRAINT       fkBudgetUser      FOREIGN KEY(bud_usr_id) REFERENCES users(usr_id),
    CONSTRAINT       fkBudgetAccount   FOREIGN KEY(bud_acc_id) REFERENCES accounts(acc_id)
) COMMENT "Administración de presupuestos.";

DROP TABLE IF EXISTS ingresses;
CREATE TABLE IF NOT EXISTS ingresses
(
    iss_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador único de la operación de ingreso.",
    iss_usr_id       INT               NULL DEFAULT 1      COMMENT "Identificador del usuario.",
    iss_cat_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la categoría.",
    iss_sav_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta de ahorro.",
    iss_deb_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la deuda.",
    iss_acc_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta.",
    iss_concept      VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, nombre del concepto.",
    iss_description  VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, descripción del ingreso.",
    iss_reference    VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, referencia del ingreso.",
    iss_amount       DOUBLE            NULL DEFAULT 0      COMMENT "Importe total del ingreso.",
    iss_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la operación.",
    iss_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, nombre de archivo.",
    iss_created_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de alta del registro.",
    iss_updated_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de actualización del registro.",
    CONSTRAINT       pkIngress         PRIMARY KEY(iss_id),
    CONSTRAINT       fkIngressUser     FOREIGN KEY(iss_usr_id) REFERENCES users(usr_id),
    CONSTRAINT       fkIngressCategory FOREIGN KEY(iss_cat_id) REFERENCES categories(cta_id),
    CONSTRAINT       fkIngressSaving   FOREIGN KEY(iss_sav_id) REFERENCES savings(sav_id),
    CONSTRAINT       fkIngressDebt     FOREIGN KEY(iss_deb_id) REFERENCES debts(deb_id),
    CONSTRAINT       fkIngressAccount  FOREIGN KEY(iss_acc_id) REFERENCES accounts(acc_id)
) COMMENT "Operaciones de ingresos";

DROP TABLE IF EXISTS egresses;
CREATE TABLE IF NOT EXISTS egresses
(
    ess_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador único de la operación de egreso.",
    ess_usr_id       INT               NULL DEFAULT 1      COMMENT "Identificador del usuario.",
    ess_cat_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la categoría.",
    ess_sav_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta de ahorro.",
    ess_deb_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la deuda.",
    ess_acc_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta.",
    ess_concept      VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, nombre del concepto.",
    ess_description  VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, descripción del egreso.",
    ess_reference    VARCHAR(255)      NULL DEFAULT NULL   COMMENT "Opcional, referencia del egreso.",
    ess_amount       DOUBLE            NULL DEFAULT 0      COMMENT "Importe total del egreso.",
    ess_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la operación.",
    ess_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, nombre de archivo.",
    ess_created_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de alta del registro.",
    ess_updated_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de actualización del registro.",
    CONSTRAINT       pkEgress          PRIMARY KEY(ess_id),
    CONSTRAINT       fkEgressUser      FOREIGN KEY(ess_usr_id) REFERENCES users(usr_id),
    CONSTRAINT       fkEgressCategory  FOREIGN KEY(ess_cat_id) REFERENCES categories(cta_id),
    CONSTRAINT       fkEgressSaving    FOREIGN KEY(ess_sav_id) REFERENCES savings(sav_id),
    CONSTRAINT       fkEgressDebt      FOREIGN KEY(ess_deb_id) REFERENCES debts(deb_id),
    CONSTRAINT       fkEgressAccount   FOREIGN KEY(ess_acc_id) REFERENCES accounts(acc_id)
) COMMENT "Operaciones de ingresos";

DROP TABLE IF EXISTS transactions;
CREATE TABLE IF NOT EXISTS transactions
(
    tra_id           INT           NOT NULL AUTO_INCREMENT COMMENT "Identificador único de la transacción.",
    tra_usr_id       INT               NULL DEFAULT 1      COMMENT "Identificador del usuario.",
    tra_cat_id       INT               NULL DEFAULT 1      COMMENT "Identificador de la categoría.",
    tra_acc_id_from  INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta origen.",
    tra_acc_id_to    INT               NULL DEFAULT 1      COMMENT "Identificador de la cuenta destino.",
    tra_sav_id       INT               NULL DEFAULT 1      COMMENT "Identificador de cuentas de ahorro.",
    tra_deb_id       INT               NULL DEFAULT 1      COMMENT "Identificador de cuantas de deuda.",
    tra_amount       DOUBLE            NULL DEFAULT NULL   COMMENT "Importe total de la operación.",
    tra_type         CHAR(25)          NULL DEFAULT NULL   COMMENT "Tipo de transacción: [ingreso | egreso].",
    tra_observation  TEXT              NULL DEFAULT NULL   COMMENT "Opcional, observaciones de la transacción.",
    tra_file         VARCHAR(150)      NULL DEFAULT NULL   COMMENT "Opcional, nombre de archivo.",
    tra_created_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de alta del registro.",
    tra_updated_at   TIMESTAMP         NULL DEFAULT NOW()  COMMENT "Datos de auditoria, fecha de actualización del registro.",
    CONSTRAINT       pkTransaction            PRIMARY KEY(tra_id)
) COMMENT "Historial de operaciones de ingresos y egresos";

```
