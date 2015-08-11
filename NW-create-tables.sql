-- ----------------
-- :e! ++enc=utf8I
-- ----------------

DROP TABLE if exists categories;
CREATE TABLE categories (
    CategoryID integer PRIMARY KEY,
    CategoryName text NOT NULL,
    Description text,
    Picture blob
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-categories.csv categories
-- --------------------------

DROP TABLE if exists customers;
CREATE TABLE customers (
    CustomerID text PRIMARY KEY,
    CompanyName text,
    ContactName text,
    ContactTitle text,
    Address text,
    City text,
    Region text,
    PostalCode text,
    Country text,
    Phone text,
    Fax text
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-customers.csv customers
-- --------------------------

DROP TABLE if exists territories;
CREATE TABLE territories (
    TerritoryID text,
    TerritoryDescription text NOT NULL,
    RegionID integer,
    PRIMARY KEY (TerritoryID),
    FOREIGN KEY (RegionID) REFERENCES region (RegionID)
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-territories.csv territories
-- --------------------------

DROP TABLE if exists region;
CREATE TABLE region (
    RegionID integer,
    RegionDescription text NOT NULL,
    PRIMARY KEY (RegionID)
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-regions.csv region
-- --------------------------

DROP TABLE IF EXISTS suppliers;
CREATE TABLE suppliers(
   SupplierID integer NOT NULL,
   CompanyName text NOT NULL,
   ContactName text,
   ContactTitle text,
   Address text,
   City text,
   Region text,
   PostalCode text,
   Country text,
   Phone text,
   Fax text,
   HomePage text,
   PRIMARY KEY (SupplierID)
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-suppliers.csv suppliers
-- --------------------------

DROP TABLE IF EXISTS products;
CREATE TABLE products(
   ProductID integer NOT NULL,
   ProductName text NOT NULL,
   SupplierID integer,
   CategoryID integer,
   QuantityPerUnit text,
   UnitPrice real DEFAULT 0,
   UnitsInStock integer DEFAULT 0,
   UnitsOnOrder integer DEFAULT 0,
   ReorderLevel integer DEFAULT 0,
   Discontinued text NOT NULL DEFAULT '0',
   PRIMARY KEY (ProductID),
    CHECK (UnitPrice>=(0)),
    CHECK (ReorderLevel>=(0)),
    CHECK (UnitsInStock>=(0)),
    CHECK (UnitsOnOrder>=(0)),
	FOREIGN KEY (ProductID) REFERENCES Categories (CategoryID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (SupplierID) REFERENCES Suppliers (SupplierID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-products.csv products
-- --------------------------

DROP TABLE if EXISTS order_details;
CREATE TABLE order_details(
   OrderID integer NOT NULL,
   ProductID integer NOT NULL,
   UnitPrice real NOT NULL DEFAULT 0,
   Quantity integer NOT NULL DEFAULT 1,
   Discount real NOT NULL DEFAULT 0,
    PRIMARY KEY (OrderID,ProductID),
    CHECK (Discount>=(0) AND Discount<=(1)),
    CHECK (Quantity>(0)),
    CHECK (UnitPrice>=(0)),
	FOREIGN KEY (OrderID) REFERENCES Orders (OrderID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (ProductID) REFERENCES Products (ProductID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-order-details.csv order_details
-- --------------------------

DROP TABLE IF EXISTS employee_territories;
CREATE TABLE employee_territories(
   EmployeeID integer NOT NULL,
   TerritoryID text NOT NULL,
    PRIMARY KEY (EmployeeID,TerritoryID),
	FOREIGN KEY (EmployeeID) REFERENCES employees (EmployeeID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (TerritoryID) REFERENCES territories (TerritoryID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-employee-territories.csv employee_territories
-- --------------------------

DROP TABLE IF EXISTS orders;
CREATE TABLE orders(
   OrderID integer NOT NULL PRIMARY KEY AUTOINCREMENT,
   CustomerID text,
   EmployeeID integer,
   OrderDate text,
   RequiredDate text,
   ShippedDate text,
   ShipperID integer,
   Freight real DEFAULT 0,
   ShipName text,
   ShipAddress text,
   ShipCity text,
   ShipRegion text,
   ShipPostalCode text,
   ShipCountry text,
   FOREIGN KEY (EmployeeID) REFERENCES Employees (EmployeeID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (CustomerID) REFERENCES Customers (CustomerID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION,
	FOREIGN KEY (ShipperID) REFERENCES Shippers (ShipperID) 
		ON DELETE NO ACTION ON UPDATE NO ACTION
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-orders.csv orders
-- --------------------------

DROP TABLE IF EXISTS shippers;
CREATE TABLE shippers (
    ShipperID integer NOT NULL,
    CompanyName text NOT NULL,
    Phone text,
    PRIMARY KEY (ShipperID)
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-shippers.csv shippers
-- --------------------------

DROP TABLE IF EXISTS employees;
CREATE TABLE employees (
    EmployeeID integer NOT NULL,
    LastName text  NOT NULL,
    FirstName text  NOT NULL,
    Title text ,
    TitleOfCourtesy text ,
    BirthDate date,
    HireDate date,
    Address text ,
    City text ,
    Region text ,
    PostalCode text ,
    Country text ,
    HomePhone text ,
    Extension text ,
    Notes text,
    ReportsTo integer,
    PhotoPath text 
);

-- --------------------------
-- .separator "|"
-- .mode list
-- .import NW-employees.csv employees
-- --------------------------

