# Oracle XE 21c + ORDS (SQL Developer Web)

Docker Compose setup for Oracle Database XE 21c and ORDS, so you can run SQL in the browser with SQL Developer Web.

## Requirements

- Docker with Compose v2 (`docker compose`)
- A working laptop / pc

## Steps

**0. Log in ke Oracle (Optional karena aku ngga perlu login)**

```bash
docker login container-registry.oracle.com
```

**1. Start container**

```bash
docker compose up -d
```

Start pertama kali bisa makan waktu bbrp menit jadi tunggu aja

**2. Check ORDS apakah sudah siap pakai**

```bash
docker compose logs -f ords
```

Tunggu sampe kamu lihat ada tulisan `Oracle REST Data Services initialized`, kemudian pencet `Ctrl+C` untuk keluar dari logs nya (kontainer nya masih jalan aman kok tadi kamu cuma lihat logs / history nya).

**3. Buat user baru buat SQL Developer Web**

```bash
docker exec -i oracledb sqlplus system/Mik_1234@localhost:1521/XEPDB1 < create-user.sql
```

`PL/SQL procedure successfully completed.` artinya sukses. Password `Mik_1234` adalah password bawaan di env `.env`.

**4. Buka SQL Developer Web**

http://localhost:8181/ords/sql-developer

Log in with the user from `create-user.sql` (default: `DEVUSER` / `Dev_1234`).
##### ps : kadang SQL Developer Web e rewel gabisa login jadi isi username mu devuser (kecil semua) + klik advance terus isi path sama devuser juga.
## Connect from a client (DBeaver, etc.)

Host `localhost` | Port `1522` | Service name `XEPDB1`

**5. Buka SQL Developer Web**

Tinggal jalanin script create-tables.sql yang ada di folder sql-akademik + seed.sql untuk ngisi datanya

## Stop / reset

```bash
docker compose down       # Cuma nge stop container, datamu masi aman soale volume ga kehapus
docker compose down -v    # iki bahaya literally volume mu kehapus mati kamu
```

## After Shutdown / Reboot 

jadi docker compose ini ngga aku buat untuk auto nyala setelah reboot / shutdown biar engga makan memory jadi kalian perlu nyalain lagi manual via command `docker compose up -d`. Tenang aja dia ngga bakal buat container baru selama container lama masih ada dia bakal ngestart container yg lama itu.

## License

The files in this repo are released under the [MIT License](LICENSE).

Oracle Database and ORDS images are not part of this repo and are subject to Oracle's own license terms. This repo only contains configuration files.