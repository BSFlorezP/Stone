CREATE TABLE Company (
    id_compa BIGINT IDENTITY(1,1) PRIMARY KEY,
    compa_name NVARCHAR(255) NOT NULL,
    compa_tradename NVARCHAR(255) NOT NULL,
    compa_doctype NVARCHAR(2) NOT NULL CHECK (compa_doctype IN ('NI', 'CC', 'CE', 'PP', 'OT')),
    compa_docnum NVARCHAR(255) NOT NULL,
    compa_address NVARCHAR(255) NOT NULL,
    compa_city NVARCHAR(255) NOT NULL,
    compa_state NVARCHAR(255) NOT NULL,
    compa_country NVARCHAR(255) NOT NULL,
    compa_industry NVARCHAR(255) NOT NULL,
    compa_phone NVARCHAR(255) NOT NULL,
    compa_email NVARCHAR(255) NOT NULL,
    compa_website NVARCHAR(255) NULL,
    compa_logo NVARCHAR(MAX) NULL,
    compa_active BIT NOT NULL DEFAULT 1
);

CREATE TABLE EntityCatalog (
    id_entit BIGINT IDENTITY(1,1) PRIMARY KEY,
    entit_name NVARCHAR(255) NOT NULL UNIQUE,
    entit_descrip NVARCHAR(255) NOT NULL,
    entit_active BIT NOT NULL DEFAULT 1,
    entit_config NVARCHAR(MAX) NULL
);

CREATE TABLE Role (
    id_role BIGINT IDENTITY(1,1) PRIMARY KEY,
    company_id BIGINT NOT NULL CONSTRAINT FK_Role_Company FOREIGN KEY REFERENCES Company(id_compa),
    role_name NVARCHAR(255) NOT NULL,
    role_code NVARCHAR(255) NOT NULL,
    role_description NVARCHAR(MAX) NULL,
    role_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_Company_RoleCode UNIQUE (company_id, role_code)
);

CREATE TABLE [User] (
    id_user BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_username NVARCHAR(255) NOT NULL,
    user_password NVARCHAR(255) NOT NULL,
    user_email NVARCHAR(255) NOT NULL,
    user_phone NVARCHAR(255) NULL,
    user_is_admin BIT NOT NULL DEFAULT 0,
    user_is_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_User_Username UNIQUE (user_username),
    CONSTRAINT UQ_User_Email UNIQUE (user_email)
);

CREATE TABLE UserCompany (
    id_useco BIGINT IDENTITY(1,1) PRIMARY KEY,
    user_id BIGINT NOT NULL CONSTRAINT FK_UserCompany_User FOREIGN KEY REFERENCES [User](id_user),
    company_id BIGINT NOT NULL CONSTRAINT FK_UserCompany_Company FOREIGN KEY REFERENCES Company(id_compa),
    useco_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_User_Company UNIQUE (user_id, company_id)
);

CREATE TABLE Permission (
    id_permi BIGINT IDENTITY(1,1) PRIMARY KEY,
    name NVARCHAR(255) NOT NULL,
    description NVARCHAR(MAX) NULL,
    can_create BIT NOT NULL DEFAULT 0,
    can_read BIT NOT NULL DEFAULT 0,
    can_update BIT NOT NULL DEFAULT 0,
    can_delete BIT NOT NULL DEFAULT 0,
    can_import BIT NOT NULL DEFAULT 0,
    can_export BIT NOT NULL DEFAULT 0
);

CREATE TABLE BranchOffice (
    id_broff BIGINT IDENTITY(1,1) PRIMARY KEY,
    company_id BIGINT NOT NULL CONSTRAINT FK_BranchOffice_Company FOREIGN KEY REFERENCES Company(id_compa),
    broff_name NVARCHAR(255) NOT NULL,
    broff_code NVARCHAR(255) NOT NULL,
    broff_address NVARCHAR(255) NOT NULL,
    broff_city NVARCHAR(255) NOT NULL,
    broff_state NVARCHAR(255) NOT NULL,
    broff_country NVARCHAR(255) NOT NULL,
    broff_phone NVARCHAR(255) NOT NULL,
    broff_email NVARCHAR(255) NOT NULL,
    broff_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_Company_BranchCode UNIQUE (company_id, broff_code)
);

CREATE TABLE CostCenter (
    id_cosce BIGINT IDENTITY(1,1) PRIMARY KEY,
    company_id BIGINT NOT NULL CONSTRAINT FK_CostCenter_Company FOREIGN KEY REFERENCES Company(id_compa),
    cosce_parent_id BIGINT NULL CONSTRAINT FK_CostCenter_Parent FOREIGN KEY REFERENCES CostCenter(id_cosce),
    cosce_code NVARCHAR(255) NOT NULL,
    cosce_name NVARCHAR(255) NOT NULL,
    cosce_description NVARCHAR(MAX) NULL,
    cosce_budget DECIMAL(15,2) NOT NULL DEFAULT 0,
    cosce_level SMALLINT NOT NULL DEFAULT 1 CHECK (cosce_level > 0),
    cosce_active BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_Company_CostCenterCode UNIQUE (company_id, cosce_code)
);

CREATE TABLE PermiRole (
    id_perol BIGINT IDENTITY(1,1) PRIMARY KEY,
    role_id BIGINT NOT NULL CONSTRAINT FK_PermiRole_Role FOREIGN KEY REFERENCES Role(id_role),
    permission_id BIGINT NOT NULL CONSTRAINT FK_PermiRole_Permission FOREIGN KEY REFERENCES Permission(id_permi),
    entitycatalog_id BIGINT NOT NULL CONSTRAINT FK_PermiRole_EntityCatalog FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    perol_include BIT NOT NULL DEFAULT 1,
    perol_record BIGINT NULL,
    CONSTRAINT UQ_Role_Permission_Entity UNIQUE (role_id, permission_id, entitycatalog_id, perol_record)
);

CREATE TABLE PermiRoleRecord (
    id_perrc BIGINT IDENTITY(1,1) PRIMARY KEY,
    role_id BIGINT NOT NULL CONSTRAINT FK_PermiRoleRecord_Role FOREIGN KEY REFERENCES Role(id_role),
    permission_id BIGINT NOT NULL CONSTRAINT FK_PermiRoleRecord_Permission FOREIGN KEY REFERENCES Permission(id_permi),
    entitycatalog_id BIGINT NOT NULL CONSTRAINT FK_PermiRoleRecord_EntityCatalog FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    perrc_record BIGINT NOT NULL,
    perrc_include BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_Role_Permission_Entity_Record UNIQUE (role_id, permission_id, entitycatalog_id, perrc_record)
);

CREATE TABLE PermiUser (
    id_peusr BIGINT IDENTITY(1,1) PRIMARY KEY,
    usercompany_id BIGINT NOT NULL CONSTRAINT FK_PermiUser_UserCompany FOREIGN KEY REFERENCES UserCompany(id_useco),
    permission_id BIGINT NOT NULL CONSTRAINT FK_PermiUser_Permission FOREIGN KEY REFERENCES Permission(id_permi),
    entitycatalog_id BIGINT NOT NULL CONSTRAINT FK_PermiUser_EntityCatalog FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    peusr_include BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_UserCompany_Permission_Entity UNIQUE (usercompany_id, permission_id, entitycatalog_id)
);

CREATE TABLE PermiUserRecord (
    id_peusr BIGINT IDENTITY(1,1) PRIMARY KEY,
    usercompany_id BIGINT NOT NULL CONSTRAINT FK_PermiUserRecord_UserCompany FOREIGN KEY REFERENCES UserCompany(id_useco),
    permission_id BIGINT NOT NULL CONSTRAINT FK_PermiUserRecord_Permission FOREIGN KEY REFERENCES Permission(id_permi),
    entitycatalog_id BIGINT NOT NULL CONSTRAINT FK_PermiUserRecord_EntityCatalog FOREIGN KEY REFERENCES EntityCatalog(id_entit),
    peusr_record BIGINT NOT NULL,
    peusr_include BIT NOT NULL DEFAULT 1,
    CONSTRAINT UQ_UserCompany_Permission_Entity_Record UNIQUE (usercompany_id, permission_id, entitycatalog_id, peusr_record)
);
