------------------- Insertar datos en la tabla Company -------------------

INSERT INTO Company (compa_name, compa_tradename, compa_doctype, compa_docnum, compa_address, compa_city, compa_state, compa_country, compa_industry, compa_phone, compa_email, compa_website, compa_logo, compa_active)
VALUES 
('Tech Solutions', 'TechSol', 'NI', '123456789', '123 Tech St.', 'Tech City', 'Tech State', 'Tech Country', 'Technology', '123-456-7890', 'info@techsolutions.com', 'www.techsolutions.com', NULL, 1),
('Eco Services', 'EcoServ', 'NI', '987654321', '456 Eco Rd.', 'Eco City', 'Eco State', 'Eco Country', 'Environmental Services', '987-654-3210', 'contact@ecoservices.com', 'www.ecoservices.com', NULL, 1);

----------------- Insert data into EntityCatalog -----------------
INSERT INTO EntityCatalog (entit_name, entit_descrip, entit_active, entit_config)
VALUES 
('BranchOffice', 'Information about branch offices', 1, NULL),
('CostCenter', 'Manage cost centers and budgeting', 1, NULL),
('User', 'Manage user data and authentication', 1, NULL),
('Role', 'Define roles and their permissions', 1, NULL),
('Permission', 'Details of permissions available', 1, NULL),
('EntityCatalog', 'Configuration of all entities', 1, NULL);


-------------------------- Insertar datos en la tabla Role ------------------------------ 

INSERT INTO Role (company_id, role_name, role_code, role_description, role_active)
VALUES 
(1, 'System Admin', 'SYS_ADMIN', 'Full administrative privileges', 1),
(1, 'Manager', 'MANAGER', 'Managerial access with certain restrictions', 1),
(1, 'Analyst', 'ANALYST', 'Limited access mainly for data analysis', 1),
(2, 'System Admin', 'SYS_ADMIN', 'Full administrative privileges', 1),
(2, 'Manager', 'MANAGER', 'Managerial access with certain restrictions', 1),
(2, 'Analyst', 'ANALYST', 'Limited access mainly for data analysis', 1);


------------------------- Insertar datos en la tabla User ----------------------------------------------

INSERT INTO [User] (user_username, user_password, user_email, user_phone, user_is_admin, user_is_active)
VALUES 
('alice', 'password123', 'alice@techsolutions.com', '555-111-2222', 1, 1),
('bob', 'password456', 'bob@techsolutions.com', '555-333-4444', 0, 1),
('charlie', 'password789', 'charlie@techsolutions.com', '555-555-6666', 0, 1),
('dave', 'password123', 'dave@ecoservices.com', '555-777-8888', 1, 1),
('eve', 'password456', 'eve@ecoservices.com', '555-999-0000', 0, 1),
('frank', 'password789', 'frank@ecoservices.com', '555-000-1111', 0, 1),
('grace', 'password321', 'grace@techsolutions.com', '555-222-3333', 1, 1),
('hank', 'password654', 'hank@ecoservices.com', '555-444-5555', 0, 1),
('irene', 'password987', 'irene@techsolutions.com', '555-666-7777', 0, 1),
('jack', 'password321', 'jack@ecoservices.com', '555-888-9999', 1, 1);


--------------------------- Insertar datos en la tabla UserCompany ---------------------------

INSERT INTO UserCompany (user_id, company_id, useco_active)
VALUES 
(1, 1, 1), -- alice en Tech Solutions
(2, 1, 1), -- bob en Tech Solutions
(3, 1, 1), -- charlie en Tech Solutions
(4, 2, 1), -- dave en Eco Services
(5, 2, 1), -- eve en Eco Services
(6, 2, 1), -- frank en Eco Services
(7, 1, 1), -- grace en Tech Solutions
(8, 1, 1), -- hank en Tech Solutions
(9, 2, 1), -- irene en Eco Services
(10, 2, 1); -- jack en Eco Services
---------------------------- Insertar datos en la tabla Permission -----------------------------------

INSERT INTO Permission (name, description, can_create, can_read, can_update, can_delete, can_import, can_export)
VALUES 
('Administrator', 'Complete access to all CRUD operations and import/export', 1, 1, 1, 1, 1, 1),
('Manager', 'Access to all CRUD operations except delete, and import/export', 1, 1, 1, 0, 1, 1),
('Analyst', 'Read, import, and export only', 0, 1, 0, 0, 1, 1);


--------------------------------------- Insert data into BranchOffice ---------------------------------------
INSERT INTO BranchOffice (company_id, broff_name, broff_code, broff_address, broff_city, broff_state, broff_country, broff_phone, broff_email, broff_active)
VALUES 
(1, 'TechSol NY', 'NY001', '123 Main St', 'New York', 'NY', 'USA', '123-456-7890', 'ny@techsolutions.com', 1),
(1, 'TechSol SF', 'SF001', '456 Market St', 'San Francisco', 'CA', 'USA', '987-654-3210', 'sf@techsolutions.com', 1),
(1, 'TechSol LA', 'LA001', '789 Sunset Blvd', 'Los Angeles', 'CA', 'USA', '555-123-4567', 'la@techsolutions.com', 1),
(2, 'EcoServ NY', 'NY002', '321 Broadway', 'New York', 'NY', 'USA', '321-654-0987', 'ny@ecoservices.com', 1),
(2, 'EcoServ SF', 'SF002', '654 Mission St', 'San Francisco', 'CA', 'USA', '654-987-1230', 'sf@ecoservices.com', 1),
(2, 'EcoServ LA', 'LA002', '987 Hollywood Blvd', 'Los Angeles', 'CA', 'USA', '777-888-9999', 'la@ecoservices.com', 1);



------------------------------------ Insert data into CostCenter ----------------------------------

INSERT INTO CostCenter (company_id, cosce_parent_id, cosce_code, cosce_name, cosce_budget, cosce_level)
VALUES 
(1, NULL, 'CC001', 'Marketing', 50000.00, 1), -- Centro de costos principal
(1, 1, 'CC002', 'Digital Marketing', 20000.00, 2), -- Sub-centro de Marketing
(1, 1, 'CC003', 'Events', 15000.00, 2), -- Sub-centro de Marketing
(2, NULL, 'CC004', 'Research & Dev', 75000.00, 1), -- Centro de costos principal
(2, 4, 'CC005', 'Software Dev', 30000.00, 2), -- Sub-centro de Research & Dev
(2, 4, 'CC006', 'Hardware Dev', 45000.00, 2); -- Sub-centro de Research & Dev


---------------------- Insert data into PermiRole ----------------------
-- Permisos para Administrador (role_id = 1)
INSERT INTO PermiRole (role_id, permission_id, entitycatalog_id, perol_include)
VALUES 
(1, 1, 1, 1), -- Permiso sobre BranchOffice
(1, 1, 2, 1), -- Permiso sobre CostCenter
(1, 1, 3, 1), -- Permiso sobre User
(1, 1, 4, 1), -- Permiso sobre Role
(1, 1, 5, 1), -- Permiso sobre Permission
(1, 1, 6, 1), -- Permiso sobre EntityCatalog
(4, 1, 1, 1), -- Permiso sobre BranchOffice
(4, 1, 2, 1), -- Permiso sobre CostCenter
(4, 1, 3, 1), -- Permiso sobre User
(4, 1, 4, 1), -- Permiso sobre Role
(4, 1, 5, 1), -- Permiso sobre Permission
(4, 1, 6, 1), -- Permiso sobre EntityCatalog



-- Permisos para Analista (role_id = 3 Y 6)
(3, 3, 1, 1), -- Permiso sobre BranchOffice
(3, 3, 2, 1), -- Permiso sobre CostCenter
(6, 3, 1, 1), -- Permiso sobre BranchOffice
(6, 3, 2, 1); -- Permiso sobre CostCenter



-------------------------------- Insert data into PermiUser------------------------

INSERT INTO PermiUser (usercompany_id, permission_id, entitycatalog_id, peusr_include)
VALUES 

--------------- ADMINS --------------

(1, 1, 1, 1), -- Permiso sobre BranchOffice
(1, 1, 2, 1), -- Permiso sobre CostCenter
(1, 1, 3, 1), -- Permiso sobre User
(1, 1, 4, 1), -- Permiso sobre Role
(1, 1, 5, 1), -- Permiso sobre Permission
(1, 1, 6, 1), -- Permiso sobre EntityCatalog
(4, 1, 1, 1), -- Permiso sobre BranchOffice
(4, 1, 2, 1), -- Permiso sobre CostCenter
(4, 1, 3, 1), -- Permiso sobre User
(4, 1, 4, 1), -- Permiso sobre Role
(4, 1, 5, 1), -- Permiso sobre Permission
(4, 1, 6, 1); -- Permiso sobre EntityCatalog

----------------------- Analistas --------------------------

--INSERT INTO PermiUser (usercompany_id, permission_id, entitycatalog_id, peusr_include)
--VALUES 
(3, 3, 1, 1), -- Permiso sobre BranchOffice
(3, 3, 1, 1), -- Permiso sobre BranchOffi
(6, 3, 2, 1), -- Permiso sobre CostCenterce
(6, 3, 2, 1), -- Permiso sobre CostCenter


-------------- Gerentes -------------------
--INSERT INTO PermiUser (usercompany_id, permission_id, entitycatalog_id, peusr_include)
--VALUES 
(2, 2, 1, 1), -- Permiso sobre BranchOffice
(2, 2, 2, 1), -- Permiso sobre CostCenter
(2, 2, 3, 1), -- Permiso sobre User
(2, 2, 6, 1), -- Permiso sobre EntityCatalog

(5, 2, 1, 1), -- Permiso sobre BranchOffice
(5, 2, 2, 1), -- Permiso sobre CostCenter
(5, 2, 3, 1), -- Permiso sobre User
(5, 2, 6, 1), -- Permiso sobre EntityCatalog

(7, 2, 1, 1), -- Permiso sobre BranchOffice
(7, 2, 2, 1), -- Permiso sobre CostCenter
(7, 2, 3, 1), -- Permiso sobre User
(7, 2, 6, 1), -- Permiso sobre EntityCatalog

(8, 2, 1, 1), -- Permiso sobre BranchOffice
(8, 2, 2, 1), -- Permiso sobre CostCenter
(8, 2, 3, 1), -- Permiso sobre User
(8, 2, 6, 1), -- Permiso sobre EntityCatalog

(9, 2, 1, 1), -- Permiso sobre BranchOffice
(9, 2, 2, 1), -- Permiso sobre CostCenter
(9, 2, 3, 1), -- Permiso sobre User
(9, 2, 6, 1), -- Permiso sobre EntityCatalog

(10, 2, 1, 1), -- Permiso sobre BranchOffice
(10, 2, 2, 1), -- Permiso sobre CostCenter
(10, 2, 3, 1), -- Permiso sobre User
(10, 2, 6, 1); -- Permiso sobre EntityCatalog



-------------------------------------- Insert data into PermiUserRecord --------------------
----------------------------------- Cada Gerente Tiene acceso a 4 Entidades en sus respectivas Sucursales ------------------------- 

INSERT INTO PermiUserRecord (usercompany_id, permission_id, entitycatalog_id, peusr_record, peusr_include)
VALUES 


--Usuario 2 con acceso a 4  entidades
(2, 2, 1, 2, 1), -- TechSol SF
(2, 2, 2, 2, 1), -- TechSol SF
(2, 2, 3, 2, 1), -- TechSol SF
(2, 2, 6, 2, 1), -- TechSol SF


-- Usuario 7 (Gerente de TechSol LA)
(7, 2, 1, 3, 1), -- TechSol LA
(7, 2, 2, 3, 1), -- TechSol LA
(7, 2, 3, 3, 1), -- TechSol LA
(7, 2, 6, 3, 1), -- TechSol LA

-- Usuario 8 
(8, 2, 1, 1, 1), -- TechSol NY 
(8, 2, 2, 1, 1), -- TechSol NY 
(8, 2, 3, 1, 1), -- TechSol NY 
(8, 2, 6, 1, 1), -- TechSol NY 

-- Usuario 5 (Gerente de EcoServ NY)
(5, 2, 1, 4, 1), -- EcoServ NY
(5, 2, 2, 4, 1), -- EcoServ NY
(5, 2, 3, 4, 1), -- EcoServ NY
(5, 2, 6, 4, 1), -- EcoServ NY

-- Usuario 9 (Gerente de EcoServ SF)
(9, 2, 1, 5, 1), -- EcoServ SF
(9, 2, 2, 5, 1), -- EcoServ SF
(9, 2, 3, 5, 1), -- EcoServ SF
(9, 2, 6, 5, 1), -- EcoServ SF

-- Usuario 10 (Gerente de EcoServ LA)
(10, 2, 1, 6, 1); -- EcoServ LA
(10, 2, 2, 6, 1), -- EcoServ LA
(10, 2, 3, 6, 1), -- EcoServ LA
(10, 2, 6, 6, 1); -- EcoServ LA

-------------------------------------- Insert data into PermiRoleRecord --------------------

INSERT INTO PermiRoleRecord (role_id, permission_id, entitycatalog_id, perrc_record, perrc_include)
VALUES 
(3, 3, 1, 1, 1), -- Permiso sobre TechSol NY
(3, 3, 1, 2, 1), -- Permiso sobre TechSol SF
(3, 3, 1, 3, 1), -- Permiso sobre TechSol LA
(3, 3, 2, 1, 1), -- Permiso sobre TechSol NY
(3, 3, 2, 2, 1), -- Permiso sobre TechSol SF
(3, 3, 2, 3, 1), -- Permiso sobre TechSol LA


(6, 3, 1, 4, 1), -- Permiso sobre EcoServ NY
(6, 3, 1, 5, 1), -- Permiso sobre EcoServ SF
(6, 3, 1, 6, 1), -- Permiso sobre EcoServ LA
(6, 3, 2, 4, 1), -- Permiso sobre EcoServ NY
(6, 3, 2, 5, 1), -- Permiso sobre EcoServ SF
(6, 3, 2, 6, 1); -- Permiso sobre EcoServ LA
