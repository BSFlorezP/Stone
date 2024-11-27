CREATE PROCEDURE GetRolesByHierarchy
    @entitycatalog_id BIGINT,
    @user_id BIGINT
AS
BEGIN
    SET NOCOUNT ON;

    -- Crear una tabla temporal para calcular la jerarquía
    CREATE TABLE #RoleHierarchy (
        role_name NVARCHAR(255),
        role_code NVARCHAR(255),
        entity_level NVARCHAR(50), -- 'Entity' o 'Record'
        hierarchy_score INT
    );

    -- Agregar roles por entidad
    INSERT INTO #RoleHierarchy (role_name, role_code, entity_level, hierarchy_score)
    SELECT 
        R.role_name,
        R.role_code,
        'Entity' AS entity_level,
        (P.can_create * 10 + P.can_read * 5 + P.can_update * 7 + P.can_delete * 8 + P.can_import * 6 + P.can_export * 4) AS hierarchy_score
    FROM CREATE PROCEDURE Sistema_de_permisos
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

        PermiUser PU
    INNER JOIN UserCompany UC ON PU.usercompany_id = UC.id_useco
    INNER JOIN Role R ON UC.company_id = R.company_id
    INNER JOIN PermiRole PR ON R.id_role = PR.role_id
    INNER JOIN Permission P ON PR.permission_id = P.id_permi
    WHERE 
        PU.entitycatalog_id = @entitycatalog_id
        AND UC.user_id = @user_id;

    -- Agregar roles por registro
    INSERT INTO #RoleHierarchy (role_name, role_code, entity_level, hierarchy_score)
    SELECT 
        R.role_name,
        R.role_code,
        'Record' AS entity_level,
        (P.can_create * 10 + P.can_read * 5 + P.can_update * 7 + P.can_delete * 8 + P.can_import * 6 + P.can_export * 4) AS hierarchy_score
    FROM 
        PermiUserRecord PUR
    INNER JOIN UserCompany UC ON PUR.usercompany_id = UC.id_useco
    INNER JOIN Role R ON UC.company_id = R.company_id
    INNER JOIN PermiRoleRecord PRR ON R.id_role = PRR.role_id
    INNER JOIN Permission P ON PRR.permission_id = P.id_permi
    WHERE 
        PUR.entitycatalog_id = @entitycatalog_id
        AND UC.user_id = @user_id;

    -- Seleccionar los resultados ordenados por jerarquía
    SELECT 
        role_name,
        role_code,
        entity_level,
        hierarchy_score
    FROM 
        #RoleHierarchy
    ORDER BY 
        hierarchy_score DESC, -- Ordenar por jerarquía (mayor a menor)
        entity_level ASC; -- Entity primero, luego Record

    -- Limpiar la tabla temporal
    DROP TABLE #RoleHierarchy;
END;

------------------------- Ejecutar Procedimiento Almacenado "Sistema de permisos" -------------------
---EXEC Sistema_de_permisos @entitycatalog_id = 1 , @user_id = 3;
