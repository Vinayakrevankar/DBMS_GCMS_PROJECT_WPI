DROP TABLE LoginAttempts;
DROP TABLE Transaction;
DROP TABLE TransactionMode;
DROP TABLE UserPreference;
DROP TABLE Notification;
DROP TABLE UserFeedback;
DROP TABLE FavouriteProducts;
DROP TABLE UserFavourites;
DROP TABLE Quantity;
DROP TABLE GiftCard;
DROP TABLE PromoCode;
DROP TABLE ProductOrders;
DROP TABLE UserRewardsHistory;
DROP TABLE UserRewards;
DROP TABLE Product;
DROP TABLE Orders;
DROP TABLE ProductCategory;
DROP TABLE Brand;
DROP TABLE CustomerPhoneDetails;
DROP TABLE Customer;
DROP TABLE Users;
DROP TABLE Roles;


CREATE TABLE Roles (
roleId INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
isSuperAdmin NUMBER(1) NOT NULL,
isCustomer NUMBER(1) NOT NULL
);

INSERT INTO Roles (isSuperAdmin,isCustomer) VALUES (0,1);
INSERT INTO Roles (isSuperAdmin,isCustomer) VALUES (1,0);

CREATE TABLE Users (
userID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
roleID INTEGER NOT NULL,
emailID VARCHAR(50),
password VARCHAR(80),
isActive NUMBER(1) NOT NULL,
lastLogin TIMESTAMP NOT NULL,
FOREIGN KEY(roleId) REFERENCES Roles(roleId));

CREATE TABLE Customer (
customerId INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER,
firstName VARCHAR(50) NOT NULL,
lastName VARCHAR(50) NOT NULL,
zipcode INTEGER NOT NULL,
address VARCHAR(255),
DOB DATE,
FOREIGN KEY(userId) REFERENCES Users(userId));

CREATE TABLE CustomerPhoneDetails (
customerId INTEGER NOT NULL,
phoneNumber INTEGER NOT NULL,
phoneType VARCHAR(20) NOT NULL,
PRIMARY KEY (customerId, phoneNumber),
FOREIGN KEY(customerId) REFERENCES Customer(customerId) ON DELETE CASCADE);

CREATE TABLE LoginAttempts (
userId INTEGER,
loginAttempts INTEGER NOT NULL,
loginDatetime TIMESTAMP NOT NULL,
PRIMARY KEY (userId,loginAttempts),
FOREIGN KEY(userId) REFERENCES Users(userId) ON DELETE CASCADE);

CREATE TABLE TransactionMode(
idTransactionMode INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
transactionMode VARCHAR(20)
);

CREATE TABLE Transaction (
transactionID INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER NOT NULL,
idTransactionMode INTEGER NOT NULL,
status VARCHAR(20),
amount REAL NOT NULL,
transactionDatetime TIMESTAMP,
FOREIGN KEY(idTransactionMode) REFERENCES TransactionMode(idTransactionMode),
FOREIGN KEY(userId) REFERENCES Users(userId));

CREATE TABLE UserPreference (
idPreference INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER NOT NULL,
email NUMBER(1) NOT NULL,
sms NUMBER(1) NOT NULL,
FOREIGN KEY(userId) REFERENCES Users(userId) ON DELETE CASCADE);

CREATE TABLE Notification (
idNotification INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER,
isSMSSent NUMBER(1),
isEmailSent NUMBER(1),
message VARCHAR(80),
notificationDatetime TIMESTAMP,
FOREIGN KEY(userId) REFERENCES Users(userId));

CREATE TABLE UserFeedback (
idFeedback INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER NOT NULL,
message VARCHAR(255),
rating INTEGER,
FOREIGN KEY(userId) REFERENCES Users(userId));

CREATE TABLE Brand (
idBrand INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
brandName VARCHAR(40)
);

CREATE TABLE ProductCategory (
idCategory INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
categoryName VARCHAR(40)
);

CREATE TABLE Product (
idProduct INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idBrand INTEGER NOT NULL,
idCategory INTEGER NOT NULL,
productName VARCHAR(40) NOT NULL,
description VARCHAR(255),
termsAndConditions VARCHAR(255),
stepsToRedeem VARCHAR(255),
imageURL VARCHAR(255),
quantity INTEGER NOT NULL,
FOREIGN KEY(idBrand) REFERENCES Brand(idBrand),
FOREIGN KEY(idCategory) REFERENCES ProductCategory(idCategory));

CREATE TABLE UserFavourites (
userID INTEGER NOT NULL,
favouriteID INTEGER NOT NULL,
PRIMARY KEY(userID, favouriteID),
FOREIGN KEY(userID) REFERENCES Users(userID) ON DELETE CASCADE);

CREATE TABLE FavouriteProducts (
userId INTEGER NOT NULL,
idFavourite INTEGER NOT NULL,
idProduct INTEGER NOT NULL,
PRIMARY KEY(userId, idFavourite, idProduct),
FOREIGN KEY(userId, idFavourite) REFERENCES UserFavourites(userId, idFavourite),
FOREIGN KEY(idProduct) REFERENCES Product(idProduct));

CREATE TABLE GiftCard (
idGiftcard INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idProduct INTEGER NOT NULL,
giftCardNumber VARCHAR(16) NOT NULL,
giftCardPin INTEGER NOT NULL,
status VARCHAR(16) NOT NULL,
FOREIGN KEY(idProduct) REFERENCES Product(idProduct));

CREATE TABLE PromoCode (
promocodeId INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idProduct INTEGER NOT NULL,
name VARCHAR(20),
discountInPercentage INTEGER NOT NULL,
FOREIGN KEY(idProduct) REFERENCES Product(idProduct));

CREATE TABLE Orders (
orderId INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER NOT NULL,
idGiftcard INTEGER NOT NULL,
status VARCHAR(20),
discount REAL NOT NULL,
totalAmount REAL NOT NULL,
startDate TIMESTAMP NOT NULL,
endDate TIMESTAMP NOT NULL,
orderDatetime TIMESTAMP NOT NULL,
FOREIGN KEY(userId) REFERENCES Users(userId) ON DELETE CASCADE);

CREATE TABLE ProductOrders (
orderId INTEGER NOT NULL,
idGiftcard INTEGER NOT NULL,
PRIMARY KEY (orderId, idGiftcard),
FOREIGN KEY(idGiftcard) REFERENCES GiftCard(idGiftcard),
FOREIGN KEY(orderId) REFERENCES Orders(orderId));

CREATE TABLE UserRewards (
idReward INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
userId INTEGER NOT NULL,
points REAL,
FOREIGN KEY(userId) REFERENCES Users(userId));

CREATE TABLE UserRewardsHistory (
idHistory INT GENERATED BY DEFAULT AS IDENTITY (START WITH 1) PRIMARY KEY,
idReward INTEGER NOT NULL,
orderId INTEGER NOT NULL,
points REAL NOT NULL,
modifiedDatetime TIMESTAMP,
FOREIGN KEY(idReward) REFERENCES UserRewards(idReward),
FOREIGN KEY(orderId) REFERENCES Orders(orderId));



INSERT INTO ProductCategory (categoryName) VALUES ('E-commerce/Online');
INSERT INTO ProductCategory (categoryName) VALUES ('Fashion / Lifestyle');
INSERT INTO ProductCategory (categoryName) VALUES ('Grocery');
INSERT INTO ProductCategory (categoryName) VALUES ('Home Needs');
INSERT INTO ProductCategory (categoryName) VALUES ('Home Furnishings');
INSERT INTO ProductCategory (categoryName) VALUES ('Travel');
INSERT INTO ProductCategory (categoryName) VALUES ('Gaming');
INSERT INTO ProductCategory (categoryName) VALUES ('Entertainment');
INSERT INTO ProductCategory (categoryName) VALUES ('Health / Beauty');
INSERT INTO ProductCategory (categoryName) VALUES ('Electronics');
INSERT INTO ProductCategory (categoryName) VALUES ('Food / Beverages');
INSERT INTO ProductCategory (categoryName) VALUES ('Hospitality');
INSERT INTO ProductCategory (categoryName) VALUES ('Jewellery');
INSERT INTO ProductCategory (categoryName) VALUES ('Luxury Brand');
INSERT INTO ProductCategory (categoryName) VALUES ('International Brands');
INSERT INTO ProductCategory (categoryName) VALUES ('Sportswear / Footwear');
INSERT INTO ProductCategory (categoryName) VALUES ('Baby Products');
INSERT INTO ProductCategory (categoryName) VALUES ('Books');
INSERT INTO ProductCategory (categoryName) VALUES ('Finance and Insurance');

INSERT INTO TRANSACTIONMODE VALUES(1,'Credit Card');
INSERT INTO TRANSACTIONMODE VALUES(2,'Debit Card');