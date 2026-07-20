## Create Database

CREATE DATABASE vehicle_analysis;
USE vehicle_analysis;

## Create Table

CREATE TABLE vehicle_data (
    State VARCHAR(50),
    EV INT,
    PHEV INT,
    HEV INT,
    Biodiesel INT,
    Ethanol INT,
    CNG INT,
    Propane INT,
    Hydrogen INT,
    Methanol INT,
    Gasoline INT,
    Diesel INT,
    UnknownFuel INT,
    TotalVehicles INT
);

## Verify Import

SELECT *
FROM vehicle_data;

## Count Records

SELECT COUNT(*) AS Total_States
FROM vehicle_data;

## Total Registered Vehicles

SELECT
SUM(TotalVehicles) AS Total_Registered_Vehicles
FROM vehicle_data;

## National Fuel Totals

SELECT
SUM(EV) AS Total_EV,
SUM(PHEV) AS Total_PHEV,
SUM(HEV) AS Total_HEV,
SUM(Biodiesel) AS Total_Biodiesel,
SUM(Ethanol) AS Total_Ethanol,
SUM(CNG) AS Total_CNG,
SUM(Propane) AS Total_Propane,
SUM(Hydrogen) AS Total_Hydrogen,
SUM(Methanol) AS Total_Methanol,
SUM(Gasoline) AS Total_Gasoline,
SUM(Diesel) AS Total_Diesel,
SUM(UnknownFuel) AS Total_UnknownFuel
FROM vehicle_data;

## Vehicle Percentage by State

SELECT
State,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Percentage,
ROUND(PHEV*100.0/TotalVehicles,2) AS PHEV_Percentage,
ROUND(HEV*100.0/TotalVehicles,2) AS HEV_Percentage,
ROUND(Gasoline*100.0/TotalVehicles,2) AS Gasoline_Percentage
FROM vehicle_data;

## Top 5 States by EV Adoption

SELECT
State,
EV,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Adoption_Rate
FROM vehicle_data
ORDER BY EV_Adoption_Rate DESC
LIMIT 5;

## Bottom 5 States by EV Adoption

SELECT
State,
EV,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Adoption_Rate
FROM vehicle_data
ORDER BY EV_Adoption_Rate ASC
LIMIT 5;

## California vs Other Large States

SELECT
State,
EV,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Adoption
FROM vehicle_data
WHERE State IN
('California',
'Texas',
'Florida',
'New York');

## Alternative Fuel Comparison

SELECT
State,
Biodiesel,
Ethanol,
Hydrogen,
CNG,
Propane
FROM vehicle_data
ORDER BY Ethanol DESC;

## National Market Share

SELECT
    ROUND(SUM(EV) * 100.0 / SUM(TotalVehicles), 2) AS EV_Share,
    ROUND(SUM(PHEV) * 100.0 / SUM(TotalVehicles), 2) AS PHEV_Share,
    ROUND(SUM(HEV) * 100.0 / SUM(TotalVehicles), 2) AS HEV_Share,
    ROUND(SUM(Gasoline) * 100.0 / SUM(TotalVehicles), 2) AS Gasoline_Share
FROM vehicle_data;

## Top Biodiesel States

SELECT
State,
Biodiesel
FROM vehicle_data
ORDER BY Biodiesel DESC
LIMIT 10;

## Top Ethanol States

SELECT
State,
Ethanol
FROM vehicle_data
ORDER BY Ethanol DESC
LIMIT 10;

## Hydrogen Vehicle Distribution

SELECT
State,
Hydrogen
FROM vehicle_data
ORDER BY Hydrogen DESC;

## Largest Vehicle Markets

SELECT
State,
TotalVehicles
FROM vehicle_data
ORDER BY TotalVehicles DESC
LIMIT 10;

## Alternative Fuel Percentage

SELECT
State,
ROUND(
(EV+PHEV+HEV+Biodiesel+Ethanol+CNG+Propane+Hydrogen+Methanol)
*100.0/
TotalVehicles
,2)
AS AlternativeFuelPercentage
FROM vehicle_data
ORDER BY AlternativeFuelPercentage DESC;

## Infrastructure Priority States

SELECT
State,
TotalVehicles,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Percentage,
EV
FROM vehicle_data
ORDER BY
EV_Percentage DESC,
TotalVehicles DESC
LIMIT 10;

## States with Low EV Adoption

SELECT
State,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Percentage
FROM vehicle_data
ORDER BY EV_Percentage
LIMIT 10;

## Create a View for Tableau

CREATE VIEW vehicle_dashboard AS
SELECT
State,
EV,
PHEV,
HEV,
Gasoline,
Diesel,
Biodiesel,
Ethanol,
Hydrogen,
CNG,
Propane,
Methanol,
UnknownFuel,
TotalVehicles,
ROUND(EV*100.0/TotalVehicles,2) AS EV_Percentage,
ROUND(PHEV*100.0/TotalVehicles,2) AS PHEV_Percentage,
ROUND(HEV*100.0/TotalVehicles,2) AS HEV_Percentage,
ROUND(Gasoline*100.0/TotalVehicles,2) AS Gasoline_Percentage,
ROUND(
(EV+PHEV+HEV+Biodiesel+Ethanol+CNG+Propane+Hydrogen+Methanol)
*100.0/
TotalVehicles
,2)
AS AlternativeFuelPercentage
FROM vehicle_data;

## Test the View

SELECT *
FROM vehicle_dashboard;

SHOW TABLES;


