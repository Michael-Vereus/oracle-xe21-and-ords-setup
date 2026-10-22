# Creating a New Oracle Database User

## 1. Menjalankan Oracle Database

Jalankan Docker Compose untuk menyalakan container Oracle Database.

```bash
docker compose up -d
```

## 2. Memahami ORDS dan SQL*Plus

**ORDS (Oracle REST Data Services)** merupakan layanan yang memungkinkan database Oracle diakses melalui REST API. ORDS dapat digunakan untuk menyediakan endpoint CRUD (*Create, Read, Update, Delete*) terhadap data database.

Namun, untuk membuat user database baru, kita perlu menggunakan akun administrator Oracle dan menjalankan perintah SQL melalui SQL*Plus.

## 3. Login ke SQL*Plus sebagai SYSTEM

Jalankan perintah berikut melalui terminal untuk masuk ke Oracle Database sebagai administrator `SYSTEM`.

```bash
docker exec -it oracledb sqlplus system@//localhost:1521/XEPDB1
```

Masukkan password `SYSTEM` ketika diminta.

**Catatan:** Pastikan service name yang digunakan adalah `XEPDB1` dan container Oracle Database sudah berjalan.

## 4. Membuat User Baru

Jalankan query berikut untuk membuat user database baru.

```sql
CREATE USER utsql IDENTIFIED BY "UtsSQL123";
```

Ganti `utsql` dengan username yang diinginkan dan `UtsSQL123` dengan password yang sesuai.

## 5. Memberikan Hak Akses Login

Agar user dapat login ke database, berikan privilege `CREATE SESSION`.

```sql
GRANT CREATE SESSION TO utsql;
```

## 6. Memberikan Hak Akses DDL

Untuk memperbolehkan user membuat tabel, view, dan sequence, jalankan:

```sql
GRANT CREATE TABLE, CREATE VIEW, CREATE SEQUENCE TO utsql;
```

Privilege tersebut memungkinkan user melakukan operasi DDL (*Data Definition Language*) tertentu.

## 7. Memberikan Quota Penyimpanan

Berikan quota pada tablespace `USERS` agar user dapat mengalokasikan ruang penyimpanan untuk objek database yang dibuatnya.

```sql
ALTER USER utsql QUOTA UNLIMITED ON USERS;
```

Quota ini berlaku pada tablespace `USERS`, bukan berarti seluruh kapasitas penyimpanan server menjadi tidak terbatas.

## 8. Template Akun User

Gunakan kredensial berikut sebagai template akun database untuk keperluan praktikum.

| Atribut | Nilai |
|---|---|
| Username | `utsql` |
| Password | `UtsSQL123` |
| Service Name | `XEPDB1` |
| Host | `localhost` |
| Port | `1521` |

**Ketentuan password:**
- Minimal lebih dari 8 karakter.
- Mengandung huruf besar dan huruf kecil.
- Mengandung angka.

> **Catatan keamanan:** Password pada template hanya untuk contoh praktikum. Gunakan password unik jika akun digunakan untuk menyimpan data penting.

## 9. Verifikasi Login

Keluar dari sesi administrator SQL*Plus:

```sql
EXIT;
```

Kemudian login menggunakan user yang baru dibuat:

```bash
docker exec -it oracledb sqlplus utsql@//localhost:1521/XEPDB1
```

Masukkan password `UtsSQL123` ketika diminta.

Verifikasi user dan container:

```sql
SHOW USER;
SHOW CON_NAME;
```

Output yang diharapkan:

```text
USER is "UTSQL"

CON_NAME
------------------------------
XEPDB1
```

Jika output menunjukkan user `UTSQL` dan container `XEPDB1`, akun berhasil dibuat dan dapat digunakan untuk mengakses database.
