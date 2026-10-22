### Creating New User
1. docker compose up to run
2. Simple e ORDS itu rest service yg ada diatas dan hanya untuk crud, sedangkan untuk create new user harus akses sqlplus dan menjalankan query create new user 
3. run these to login sqlplus as system 
  - docker exec -it oracledb sqlplus system/Mik_1234@//localhost:1521/XEPDB1
4. Untuk create new user 
CREATE USER DEVUSER IDENTIFIED BY "DevPass123";
5. Untuk memperbolehkan mereka login 
GRANT CREATE SESSION TO DEVUSER;
6. Untuk memperbolehkan akses DDL
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO DEVUSER;
7. Untuk memberikan Quota unlimited untuk penyimpanan database
ALTER USER DEVUSER QUOTA UNLIMITED ON USERS;


Template 
username : utsql 
password :UtsSQL123 -> harus lebih dari 8 char dan kombinasi angka, huruf besar dan kecil
