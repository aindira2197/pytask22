CREATE TABLE Users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  email VARCHAR(255) UNIQUE NOT NULL,
  password VARCHAR(255) NOT NULL,
  role VARCHAR(255) NOT NULL
);

CREATE TABLE Products (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  price DECIMAL(10, 2) NOT NULL,
  description TEXT,
  category VARCHAR(255) NOT NULL
);

CREATE TABLE Orders (
  id SERIAL PRIMARY KEY,
  user_id INTEGER NOT NULL,
  order_date DATE NOT NULL,
  total DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (user_id) REFERENCES Users(id)
);

CREATE TABLE OrderItems (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL,
  product_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders(id),
  FOREIGN KEY (product_id) REFERENCES Products(id)
);

CREATE TABLE Payments (
  id SERIAL PRIMARY KEY,
  order_id INTEGER NOT NULL,
  payment_date DATE NOT NULL,
  amount DECIMAL(10, 2) NOT NULL,
  FOREIGN KEY (order_id) REFERENCES Orders(id)
);

INSERT INTO Users (name, email, password, role) VALUES ('Admin', 'admin@example.com', 'password123', 'admin');
INSERT INTO Users (name, email, password, role) VALUES ('Customer', 'customer@example.com', 'password123', 'customer');

INSERT INTO Products (name, price, description, category) VALUES ('Product 1', 10.99, 'This is product 1', 'Category 1');
INSERT INTO Products (name, price, description, category) VALUES ('Product 2', 9.99, 'This is product 2', 'Category 2');
INSERT INTO Products (name, price, description, category) VALUES ('Product 3', 12.99, 'This is product 3', 'Category 3');

INSERT INTO Orders (user_id, order_date, total) VALUES (2, '2022-01-01', 10.99);
INSERT INTO Orders (user_id, order_date, total) VALUES (2, '2022-01-15', 19.98);

INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (1, 1, 1);
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (2, 1, 2);
INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (2, 2, 1);

INSERT INTO Payments (order_id, payment_date, amount) VALUES (1, '2022-01-01', 10.99);
INSERT INTO Payments (order_id, payment_date, amount) VALUES (2, '2022-01-15', 19.98);

CREATE OR REPLACE FUNCTION create_order(_user_id INTEGER, _order_date DATE, _total DECIMAL(10, 2)) RETURNS INTEGER AS $$
DECLARE
  _order_id INTEGER;
BEGIN
  INSERT INTO Orders (user_id, order_date, total) VALUES (_user_id, _order_date, _total) RETURNING id INTO _order_id;
  RETURN _order_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION add_order_item(_order_id INTEGER, _product_id INTEGER, _quantity INTEGER) RETURNS VOID AS $$
BEGIN
  INSERT INTO OrderItems (order_id, product_id, quantity) VALUES (_order_id, _product_id, _quantity);
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION make_payment(_order_id INTEGER, _payment_date DATE, _amount DECIMAL(10, 2)) RETURNS VOID AS $$
BEGIN
  INSERT INTO Payments (order_id, payment_date, amount) VALUES (_order_id, _payment_date, _amount);
END;
$$ LANGUAGE plpgsql; 

SELECT * FROM Users;
SELECT * FROM Products;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
SELECT * FROM Payments;