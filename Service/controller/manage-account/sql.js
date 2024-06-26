
exports.IS_EMAIL_EXISTS = `Select U.idUser AS "idUser", U.emailId AS "emailId", U.password AS "password",
R.isSuperAdmin AS "isSuperAdmin"
from Users U
LEFT JOIN roles R ON R.idRole = U.idRole
where emailId=:emailId`

exports.VERIFY_USER = `Select idUser,emailId from Users where emailId=:emailId AND password=:password`

exports.CHECK_LOGINATTEMPTS = `Select idUser,loginAttempts,loginDatetime from LoginAttempts where idUser = :idUser`

exports.UPDATE_LOGINATTEMPTS = `UPDATE LoginAttempts set loginAttempts = loginAttempts+1,loginDatetime = SYSDATE  where idUser = :idUser`

exports.RESET_LOGINATTEMPTS = `UPDATE LoginAttempts set loginAttempts = 0,loginDatetime = SYSDATE  where idUser = :idUser`

exports.UPDATE_LASTLOGIN = `UPDATE Users set lastLogin = SYSDATE  where idUser = :idUser`

exports.GET_ID_ROLE = `Select idRole from Roles where isSuperAdmin=:isSuperAdmin AND isCustomer=:isCustomer`

exports.CREATE_USER = `INSERT INTO Users (idRole, emailId, password, isActive, lastLogin) VALUES (:idRole, :emailId, :password, 1, SYSDATE) RETURNING idUser INTO :out_userId`

exports.INSERT_LOGINATTEMPTS = `INSERT INTO LoginAttempts (idUser, loginAttempts, loginDatetime) VALUES (:idUser, 0, SYSDATE)`

exports.INSERT_USERPREFERENCES = `INSERT INTO UserPreference (idUser, email, sms) VALUES (:idUser, :email, :sms)`

exports.INSERT_USERREWARDS = `INSERT INTO UserRewards (idUser, points) VALUES (:idUser, 0)`

exports.INSERT_CUSTOMER = `INSERT INTO Customer (idUser, firstName, lastName, DOB, address, zipcode) VALUES (:idUser, :firstName, :lastName, :dob, :address, :zipcode) RETURNING idCustomer INTO :out_customerId`

exports.INSERT_FAVOURITE = `INSERT INTO UserFavourites (idUser) VALUES (:idUser)`

exports.INSERT_PHONEDETAILS = `INSERT INTO CustomerPhoneDetails (idCustomer, phoneNumber, phoneType) VALUES (:idCustomer, :phone, :phoneType)`

exports.INSERT_FEEDBACK = `INSERT INTO UserFeedback (idUser, message, rating) VALUES (:idUser, :feedback, :rating)`

exports.FETCH_CUSTOMERDETAILS = `Select * from Users left join Customer using(idUser) left join CustomerPhoneDetails using(idCustomer) left join UserRewards using(idUser) where idUser=:idUser`

exports.UPDATE_USERDETAILS = `UPDATE Users set :updateValues where idUser = :idUser`

exports.UPDATE_CUSTOMERDETAILS = `UPDATE Customer set :updateValues where idUser = :idUser`

exports.UPDATE_PHONEDETAILS = `UPDATE CustomerPhoneDetails SET :updateValues where idCustomer = (select idCustomer from Customer where idUser = :idUser)`

exports.GET_FEEDBACK = `SELECT 
UF.idFeedback AS "idFeedback",
U.emailId AS "emailId",
C.firstName AS "firstName",
C.lastName AS "lastName",
message AS "message", 
CP.phoneNumber AS "phoneNumber",
rating AS "rating" FROM UserFeedback UF
INNER JOIN Customer C ON C.idUser = UF.idUser
INNER JOIN Users U ON U.idUser = UF.idUser
INNER JOIN CustomerPhoneDetails CP ON CP.idCustomer = C.idCustomer

`