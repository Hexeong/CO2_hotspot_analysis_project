CREATE DATABASE IF NOT EXISTS datamart;

USE datamart;

CREATE TABLE IF NOT EXISTS hotspot_daily_emissions (
  `day` DATE,
  Clat DOUBLE,
  Clon DOUBLE,
  total_co2_emission_estimate BIGINT,
  emission_rank INT
);