CREATE TABLE `production_hydro` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prod_date` date NOT NULL,
  `prod_hour` tinyint(4) NOT NULL,
  `prod_output` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `production_nuclear` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prod_date` date NOT NULL,
  `prod_hour` tinyint(4) NOT NULL,
  `prod_output` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `production_thermal` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prod_date` date NOT NULL,
  `prod_hour` tinyint(4) NOT NULL,
  `prod_output` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `production_renewable` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prod_date` date NOT NULL,
  `prod_hour` tinyint(4) NOT NULL,
  `prod_output` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;

CREATE TABLE `production_imports` (
  `id` int NOT NULL AUTO_INCREMENT,
  `prod_date` date NOT NULL,
  `prod_hour` tinyint(4) NOT NULL,
  `prod_output` mediumint(9) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB;


  CREATE INDEX production_hydro_date_hour_idx ON production_hydro(prod_date, prod_hour);
  
    CREATE INDEX prod_nuclear_date_hour_idx ON production_nuclear(prod_date, prod_hour);
    
    CREATE INDEX prod_thermal_date_hour_idx ON production_thermal(prod_date, prod_hour);
    
    CREATE INDEX prod_renewable_date_hour_idx ON production_renewable(prod_date, prod_hour);
    
    CREATE INDEX prod_imports_date_hour_idx ON production_imports(prod_date, prod_hour);
   
