


CREATE DATABASE Sistema;
GO

USE Sistema;
GO

CREATE LOGIN adminaduanaaa WITH PASSWORD = 'Administrador1';
go
CREATE USER adminaduanaaa FOR LOGIN adminaduanaaa;
EXEC sp_addrolemember 'db_owner', 'adminaduanaaa';

-- =========================
-- Tabla: pasajero
-- =========================
CREATE TABLE dbo.Pasajero (
    IdPasajero INT IDENTITY(1,1) PRIMARY KEY,
    Nombre NVARCHAR(100) NOT NULL,
    Apellido NVARCHAR(100) NOT NULL,
    DocumentoIdentidad NVARCHAR(50) NOT NULL UNIQUE,
    Nacionalidad NVARCHAR(50) NULL,
    Correo NVARCHAR(100) NULL UNIQUE,
    Telefono NVARCHAR(20) NULL
);
GO

-- =========================
-- Tabla: vuelo
-- =========================
CREATE TABLE dbo.Vuelo (
    IdVuelo INT IDENTITY(1,1) PRIMARY KEY,
    NumeroVuelo NVARCHAR(10) NOT NULL UNIQUE,
    FechaLlegada DATETIME NOT NULL,
    Origen NVARCHAR(50) NOT NULL,
    Destino NVARCHAR(50) NOT NULL,
    CodigoAerolinea NVARCHAR(3) NULL
);
GO

-- =========================
-- Tabla: declaracionaduanera
-- =========================
CREATE TABLE dbo.DeclaracionAduanera (
    IdDeclaracion INT IDENTITY(1,1) PRIMARY KEY,
    IdPasajero INT NOT NULL,
    IdVuelo INT NOT NULL,
    FechaDeclaracion DATETIME NOT NULL,
    EstadoDeclaracion NVARCHAR(20) NOT NULL 
        CHECK (EstadoDeclaracion IN ('En revisión','Liberada','Incautada')),
    Observaciones NVARCHAR(MAX) NULL,
    CONSTRAINT FK_DeclaracionAduanera_Pasajero FOREIGN KEY (IdPasajero)
        REFERENCES dbo.Pasajero (IdPasajero) ON UPDATE CASCADE,
    CONSTRAINT FK_DeclaracionAduanera_Vuelo FOREIGN KEY (IdVuelo)
        REFERENCES dbo.Vuelo (IdVuelo) ON UPDATE CASCADE
);
GO

-- =========================
-- Tabla: mercancia
-- =========================
CREATE TABLE dbo.Mercancia (
    IdMercancia INT IDENTITY(1,1) PRIMARY KEY,
    IdDeclaracion INT NOT NULL,
    Descripcion NVARCHAR(255) NOT NULL,
    Tipo NVARCHAR(100) NOT NULL,
    ValorDeclarado DECIMAL(10,2) NULL,
    ResultadoInspeccion NVARCHAR(20) NOT NULL
        CHECK (ResultadoInspeccion IN ('Normal','Sospechosa','Incautada')),
    CONSTRAINT FK_Mercancia_DeclaracionAduanera FOREIGN KEY (IdDeclaracion)
        REFERENCES dbo.DeclaracionAduanera (IdDeclaracion)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO

-- =========================
-- Tabla: notificacion
-- =========================
CREATE TABLE dbo.Notificacion (
    IdNotificacion INT IDENTITY(1,1) PRIMARY KEY,
    IdPasajero INT NOT NULL,
    Tipo NVARCHAR(50) NOT NULL,
    Mensaje NVARCHAR(MAX) NOT NULL,
    FechaEnvio DATETIME NOT NULL,
    CONSTRAINT FK_Notificacion_Pasajero FOREIGN KEY (IdPasajero)
        REFERENCES dbo.Pasajero (IdPasajero)
        ON UPDATE CASCADE
);
GO

-- =========================
-- Tabla: usuariosistema
-- =========================
CREATE TABLE dbo.tblUsuarios (
    intCodUsuario INT NOT NULL PRIMARY KEY,
    strNomApellidos NVARCHAR(150) NOT NULL,
    strCargo CHAR(50) NULL,
    strUsuario NVARCHAR(50) NULL,
    strPasswd NVARCHAR(100) NULL,
 
    dtmFechaIngreso DATETIME NOT NULL,
    blnActivo BIT NOT NULL DEFAULT(1)
);
GO

-- =========================
-- Tabla: revisionaduanera
-- =========================
CREATE TABLE dbo.RevisionAduanera (
    IdRevision INT IDENTITY(1,1) PRIMARY KEY,
    IdDeclaracion INT NOT NULL,
    FechaRevision DATETIME NOT NULL,
    Resultado NVARCHAR(30) NOT NULL
        CHECK (Resultado IN ('Aprobado','Requiere Inspección','Incautación')),
    InspectorId INT NULL,
    Observaciones NVARCHAR(MAX) NULL,
    CONSTRAINT FK_RevisionAduanera_DeclaracionAduanera FOREIGN KEY (IdDeclaracion)
        REFERENCES dbo.DeclaracionAduanera (IdDeclaracion)
        ON UPDATE CASCADE,
    CONSTRAINT FK_RevisionAduanera_Usuario FOREIGN KEY (InspectorId)
        REFERENCES dbo.tblUsuarios (intCodUsuario)
        ON DELETE SET NULL ON UPDATE CASCADE
);
GO

-- =========================
-- Tabla: pasajerovuelo
-- =========================
CREATE TABLE dbo.PasajeroVuelo (
    IdPasajero INT NOT NULL,
    IdVuelo INT NOT NULL,
    PRIMARY KEY (IdPasajero, IdVuelo),
    CONSTRAINT FK_PasajeroVuelo_Pasajero FOREIGN KEY (IdPasajero)
        REFERENCES dbo.Pasajero (IdPasajero)
        ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT FK_PasajeroVuelo_Vuelo FOREIGN KEY (IdVuelo)
        REFERENCES dbo.Vuelo (IdVuelo)
        ON DELETE CASCADE ON UPDATE CASCADE
);
GO



-- =========================================
--  Pasajeros (base de todo)
-- =========================================
INSERT INTO dbo.Pasajero (Nombre, Apellido, DocumentoIdentidad, Nacionalidad, Correo, Telefono)
VALUES
('Laura', 'Gómez', 'CC123456', 'Colombiana', 'laura.gomez@mail.com', '3014567890'),
('Carlos', 'Rojas', 'CC654321', 'Ecuatoriano', 'carlos.rojas@mail.com', '3029876543'),
('Ana', 'Pérez', 'CC789012', 'Peruana', 'ana.perez@mail.com', '3004561237');
GO

-- =========================================
--  Vuelos
-- =========================================
INSERT INTO dbo.Vuelo (NumeroVuelo, FechaLlegada, Origen, Destino, CodigoAerolinea)
VALUES
('AV101', '2025-11-12 08:30', 'Quito', 'Bogotá', 'AVA'),
('LA202', '2025-11-12 09:45', 'Lima', 'Bogotá', 'LAT'),
('CM303', '2025-11-12 10:15', 'Panamá', 'Bogotá', 'COP');
GO

-- =========================================
--  Declaraciones Aduaneras
-- (usa IdPasajero e IdVuelo existentes)
-- =========================================
INSERT INTO dbo.DeclaracionAduanera (IdPasajero, IdVuelo, FechaDeclaracion, EstadoDeclaracion, Observaciones)
VALUES
(1, 1, '2025-11-12 09:00', 'En revisión', 'Equipaje con artículos electrónicos'),
(2, 2, '2025-11-12 10:00', 'Liberada', 'Sin observaciones'),
(3, 3, '2025-11-12 10:45', 'Incautada', 'Mercancía no declarada');
GO

-- =========================================
--  Mercancía
-- =========================================
INSERT INTO dbo.Mercancia (IdDeclaracion, Descripcion, Tipo, ValorDeclarado, ResultadoInspeccion)
VALUES
(1, 'Laptop Dell', 'Electrónica', 3500.00, 'Normal'),
(2, 'Ropa personal', 'Textil', 400.00, 'Normal'),
(3, 'Cigarrillos', 'Tabaco', 1200.00, 'Incautada');
GO

-- =========================================
-- Usuarios del sistema (inspectores)
-- =========================================
INSERT INTO dbo.tblUsuarios (intCodUsuario, strNomApellidos, strCargo, strUsuario, strPasswd, dtmFechaIngreso, blnActivo)
VALUES
(1, 'Juan Ramírez', 'Inspector', 'jramirez', '12345', GETDATE(), 1),
(2, 'María López', 'Supervisor', 'mlopez', 'abcde', GETDATE(), 1),
(3, 'Pedro Torres', 'Administrador', 'ptorres', 'admin', GETDATE(), 1);
GO

-- =========================================
--  Revisiones Aduaneras
-- =========================================
INSERT INTO dbo.RevisionAduanera (IdDeclaracion, FechaRevision, Resultado, InspectorId, Observaciones)
VALUES
(1, '2025-11-12 09:30', 'Aprobado', 1, 'Todo en orden'),
(2, '2025-11-12 10:15', 'Requiere Inspección', 2, 'Equipaje normal'),
(3, '2025-11-12 11:00', 'Incautación', 1, 'Se retuvo mercancía no declarada');
GO


CREATE OR ALTER PROCEDURE PA_LISTAR_REVISION_ADUANERA
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
	RA.IdDeclaracion, RA.FechaRevision, RA.Resultado,RA.InspectorId, RA.Observaciones,U.strNomApellidos AS inspector, MER.Descripcion

    FROM RevisionAduanera AS RA INNER JOIN tblUsuarios AS U ON U.intCodUsuario=RA.InspectorId
	INNER JOIN  Mercancia AS MER ON MER.IdDeclaracion =RA.IdDeclaracion


    
END;
go






--  Notificaciones
-- =========================================
INSERT INTO dbo.Notificacion (IdPasajero, Tipo, Mensaje, FechaEnvio)
VALUES
(1, 'Correo', 'Su declaración está en revisión.', '2025-11-12 09:10'),
(2, 'Correo', 'Su declaración fue liberada.', '2025-11-12 10:10'),
(3, 'Correo', 'Se ha incautado parte de su equipaje.', '2025-11-12 11:10');
GO

-- =========================================
--  PasajeroVuelo (relación N a N)
-- =========================================
INSERT INTO dbo.PasajeroVuelo (IdPasajero, IdVuelo)
VALUES
(1, 1),
(2, 2),
(3, 3);
GO




CREATE or alter  PROCEDURE PA_LOGIN_USUARIO
    @USUARIO NVARCHAR(50),
    @PASSWD NVARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
        intCodUsuario,
        strNomApellidos,
        strCargo
     
    FROM tblUsuarios
    WHERE strUsuario = @USUARIO
      AND strPasswd = @PASSWD
      AND blnActivo = 1;
END;
GO

CREATE OR ALTER PROCEDURE PA_APROBADOS
AS
BEGIN
 
SELECT COUNT(*) AS Aprobados
FROM RevisionAduanera
WHERE Resultado = 'Aprobado'
 
  
END;
go


CREATE OR ALTER PROCEDURE PA_INSPECCION
AS
BEGIN
 
SELECT COUNT(*) AS Inpeccion
FROM RevisionAduanera
WHERE Resultado = 'Requiere Inspección'
  

  
END;
go


CREATE OR ALTER PROCEDURE PA_INCAUTADO
AS
BEGIN
 
SELECT COUNT(*) AS Incautados
FROM RevisionAduanera
WHERE Resultado = 'Incautación'
 

  
END;
go






CREATE OR ALTER PROCEDURE PA_BUSCAR_MERCANCIAS
    @BUSQUEDA VARCHAR(100)
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @BUSQUEDA_UPPER VARCHAR(100) = UPPER(@BUSQUEDA);

    SELECT 
        me.IdDeclaracion AS IdDeclaracion,
        dh.EstadoDeclaracion AS FechaDeclaracion,
		Me.ResultadoInspeccion as ResultadoInspeccion,
        me.Descripcion AS Descripcion,
       
	
        CASE 
            WHEN dh.EstadoDeclaracion = 'Aprobado' THEN 'Aprobado'
            WHEN dh.EstadoDeclaracion = 'Incautación' THEN 'Incautación'
			WHEN dh.EstadoDeclaracion = 'Requiere Inspección' THEN 'Requiere Inspección' 
            ELSE 'Sin estado'
        END AS EstadoDeclaracion
       
    FROM Mercancia AS me
    INNER JOIN DeclaracionAduanera AS dh ON me.IdDeclaracion = dh.IdDeclaracion
    
    WHERE 
        (
            -- 🔹 Si se puede convertir a número, buscar por códigos o número de sticker
            TRY_CAST(@BUSQUEDA_UPPER AS INT) IS NOT NULL 
            AND (
                ME.IdDeclaracion = TRY_CAST(@BUSQUEDA_UPPER AS INT)
                
            )
        )
        OR
        (
            -- 🔹 Si no es número, buscar por nombre del equipo (texto)
            TRY_CAST(@BUSQUEDA_UPPER AS INT) IS NULL 
            AND UPPER(ME.Descripcion) LIKE '%' + @BUSQUEDA_UPPER + '%'
			OR UPPER(DH.EstadoDeclaracion) LIKE '%' + @BUSQUEDA_UPPER + '%'
        )
    ORDER BY FechaDeclaracion DESC;
END;
GO


CREATE OR ALTER PROCEDURE PA_LISTAR_MERCA_DECLARADA
AS
BEGIN
    SET NOCOUNT ON;

    SELECT distinct
     
        me.IdDeclaracion AS IdDeclaracion,
		 dh.FechaDeclaracion AS FechaDeclaracion,
        
		Me.ResultadoInspeccion as ResultadoInspeccion,
        me.Descripcion AS Descripcion,
      
	
        CASE 
            WHEN dh.EstadoDeclaracion = 'Liberada' THEN 'Aprobado'
            WHEN dh.EstadoDeclaracion = 'Incautada' THEN 'Incautación'
			WHEN dh.EstadoDeclaracion = 'En revisión' THEN 'Requiere Inspección' 
            ELSE 'Sin estado'
        END AS EstadoDeclaracion
       
    FROM Mercancia AS me
    INNER JOIN DeclaracionAduanera AS dh ON me.IdDeclaracion = dh.IdDeclaracion
    
    ORDER BY FechaDeclaracion DESC;
END;
GO

create or ALTER   PROCEDURE [dbo].[PA_LISTAR_REVISION_ADUANERA]
AS
BEGIN
    SET NOCOUNT ON;

    SELECT 
	RA.IdDeclaracion, RA.FechaRevision, RA.Resultado,RA.InspectorId, RA.Observaciones,U.strNomApellidos AS inspector, MER.Descripcion

    FROM RevisionAduanera AS RA INNER JOIN tblUsuarios AS U ON U.intCodUsuario=RA.InspectorId
	INNER JOIN  Mercancia AS MER ON MER.IdDeclaracion =RA.IdDeclaracion


    
END;




      
  
           