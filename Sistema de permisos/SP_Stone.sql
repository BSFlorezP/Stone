CREATE PROCEDURE Sistema_de_permisos
	@entitycatalog_id BIGINT, -- BranchOffice
	@user_id BIGINT -- Usuario Analista
AS
	
BEGIN
    
    DECLARE @company_id BIGINT;

    -- Obtener la compañía del usuario
    SELECT @company_id = company_id 
    FROM UserCompany 
    WHERE user_id = @user_id;

    -- Consulta combinada
    SELECT 
        'GeneralUser' AS PermissionType, 
        pu.usercompany_id, 
        pu.permission_id, 
        pu.entitycatalog_id, 
        NULL AS record_id, 
        pu.peusr_include
    FROM PermiUser pu
    WHERE pu.usercompany_id = @user_id
      AND pu.entitycatalog_id = @entitycatalog_id

    UNION ALL

    SELECT 
        'SpecificUser' AS PermissionType, 
        pur.usercompany_id, 
        pur.permission_id, 
        pur.entitycatalog_id, 
        pur.peusr_record AS record_id, 
        pur.peusr_include
    FROM PermiUserRecord pur
    WHERE pur.usercompany_id = @user_id
      AND pur.entitycatalog_id = @entitycatalog_id

    UNION ALL

    SELECT 
        'GeneralRole' AS PermissionType, 
        uc.user_id AS role_id, 
        pr.permission_id, 
        pr.entitycatalog_id, 
        NULL AS record_id, 
        pr.perol_include
    FROM PermiRole pr
    JOIN UserCompany uc ON pr.role_id = uc.user_id
    WHERE uc.user_id = @user_id
      AND pr.entitycatalog_id = @entitycatalog_id

    UNION ALL

    SELECT 
        'SpecificRole' AS PermissionType, 
        uc.user_id AS role_id, 
        prr.permission_id, 
        prr.entitycatalog_id, 
        prr.perrc_record AS record_id, 
        prr.perrc_include
    FROM PermiRoleRecord prr
    JOIN UserCompany uc ON prr.role_id = uc.user_id
    WHERE uc.user_id = @user_id
      AND prr.entitycatalog_id = @entitycatalog_id

    ORDER BY PermissionType ASC, record_id;
END;


------------------------- Ejecutar Procedimiento Almacenado "Sistema de permisos" -------------------
---EXEC Sistema_de_permisos @entitycatalog_id = 1 , @user_id = 3;
