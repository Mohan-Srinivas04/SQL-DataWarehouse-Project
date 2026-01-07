/*
==================================================================
Create Database and Schemas
==================================================================

Script Purpose:
  This Script creates a new database named 'DataWarehouse' after checking if it already exists.
  If database already exists, it drops the existing one and creates a new database.
  Additionally the script sets up three schemas within the database: bronze, silver and gold.

Warning:
  Running this script will drop the entire database if exists.
  All the data will be permenantly deleted procees with caution 
  and ensure that you have proper backups before running the script.
*/



USE master;
GO

--DROP AND RECREATE THE DATABASE IF ALREADY AVAILABLE----------------------------------------------

IF EXISTS(SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
	ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
	DROP DATABASE DataWarehouse
END;
GO

--CREATE DATABASE 'DATAWAREHOUSE'------------------------------------------------------------------

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse
GO

--CREATING THE SCHEMAS FOR THE DATAWAREHOUSE-------------------------------------------------------

--CREATE BRONZE SCHEMA---------------------------

CREATE SCHEMA bronze;
GO

--CREATE SILER SCHEMA----------------------------

CREATE SCHEMA silver;
GO

--CREATE GOLD SCHEMA-----------------------------

CREATE SCHEMA gold;
GO
