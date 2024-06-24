# DEPUBLIC

## Ticketing Aplication 🎫

---

This platform is a marketplace for buying and selling concert and event tickets, offering various categories to meet diverse needs. Registered users can act as buyers, easily finding and paying for tickets online. The website provides accurate, up-to-date event information for an optimal user experience. Built with Go using the Echo framework and Clean Architecture, the application ensures maintainability and scalability, utilizing a PostgreSQL database for robust data storage, resulting in efficient and reliable endpoints.

---

## Installation 👨🏻‍💻

Depublic build by [Go](https://go.dev/dl/) Go 1.13+ to run.

1. Clone Repository
   By use terminal/cmd

```sh
git clone https://github.com/Kevinmajesta/depublic-backend.git
```

2. Open Repository
   By use terminal/cmd

```sh
cd depublic-backend
```

2. Check the .env file and configure with your device

```sh
Example file .env
ENV="yourEnv"
PORT="your using port ex("8080")"
POSTGRES_HOST= "your psql host ex("localhost")"
POSTGRES_PORT="your psql port ex("5432")"
POSTGRES_USER="depublic"
POSTGRES_PASSWORD="depublic"
POSTGRES_DATABASE="depublic"
REDIS_HOST="localhost"
REDIS_PORT="6379"
JWT_SECRET_KEY="erwhdhsajdahjkdhqwiuou"
```

3. Enable the PostgreSQL database
   Option you can use :

   - [pgAdmin](https://www.pgadmin.org/)
   - [NaviCat](https://www.navicat.com/en/download/navicat-premium?gad_source=1&gclid=CjwKCAjwmYCzBhA6EiwAxFwfgFWv6YNc_nwrdL5BByjvaEmUNbzD0vvg-tHgv7x6rFyIx-zSdWYQWhoCRP0QAvD_BwE)
   - Or anything else you usualy use

4. Run the command to create the database and migrate it.
   Make sure you have install migrate cli.
   If you dont, install first by

**If you MAC user** 🍏

- First if you dont have [Home Brew](https://brew.sh/)
  Open terminal and copy code below :

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Then install migrate cli

```sh
brew install golang-migrate
```

**If you windows user**🪟

- Open PowerShell. You can do this by searching for PowerShell in the start menu.
- Inside PowerShell, type the code below

```sh
iwr -useb get.scoop.sh | iex
```

Then Install use scoop

```sh
scoop install migrate
```

After all, migrate it by

```sh
migrate -database "postgres://depublic:depublic@localhost:5432/depublic?sslmode=disable" -path db/migrations up
```

5. Configure Docker
   **First Install Docker**
   - Windows User[Docker](https://docs.docker.com/desktop/install/windows-install/)
   - Mac User [Docker](https://docs.docker.com/desktop/install/mac-install/)
   - Then compose it by

```sh
docker-compose up -d
```

6. Run the application

```sh
go mod tidy
go run cmd/app/main.go
```

---

## Detail Project 📝

**WHAT WE BUILD?**
Project Theme : Ticketing App

**Description**
Platform for a marketplace for buying and selling concert and event tickets, offering various categories to meet diverse needs.With provides accurate, up-to-date event information for an optimal user experience.

## Features ✨

- Full controll by Admin
- User Registration.
- Implementation of In-App Notification (in-app notification, not push notification).
- User Profile.
- Realtime Payment by Midtrans
- Transaction History.
- Search, Sort, and Filter.

## Tech 💻

Depublic uses a number of open source projects to work properly :

1. **Golang** - High-performance language for scalable apps.
2. **Echo Framework** - Web framework for Go.
3. **PostgreSQL** - Reliable open-source database.
4. **Midtrans** - Secure online payment gateway.
5. **Docker** - Container platform for consistent deployment.

## Architecture 𐄷

- Using Model-View-Controller (MVC) basic architecture with two layers (backend and frontend).
- Using project layout by (https://github.com/golang-standards/project-layout)
- Implementation of search, filter, and sorting features.

## Available Roles 👨🏻‍💻

- Admin
- User

## Development

This project app develope by 5 people
| Name | Github |
| ------ | ------ |
| Kevin | https://github.com/Kevinmajesta |
| Surya | https://github.com/suryaapandi28 |
| Anom | https://github.com/AnomID |
| Haqiqi | https://github.com/haqiqi157 |
| Vivi | https://github.com/cutesoo |

By using github for development for staging and production. Git workflow with two branch branches: "main" for production and "dev" for testing and build.

## API Documentation 🔗

Documentation for API can be get by :

```sh
output\depublic-backend/depublic_project.postman_collection.json
or
https://github.com/Kevinmajesta/depublic-backend/blob/main/DB%20%26%20JSON%20API/depublic_project_fix.postman_collection.json
or
https://documenter.getpostman.com/view/24409024/2sA3XJjjNi
```

## Detail Image ⚒️

Detail for Flow Application
![Flow1](https://github.com/Kevinmajesta/depublic-backend/blob/main/assets/flow1.png)
![Flow2](https://github.com/Kevinmajesta/depublic-backend/blob/main/assets/flow2.png)
![Flow](https://github.com/Kevinmajesta/depublic-backend/blob/main/assets/fullflow.png)
**Detail fo Table Relation**
![Flow](https://github.com/Kevinmajesta/depublic-backend/blob/main/assets/Diagram.png)

---

## Lisensi MIT <img src="http://creativecommons.or.id/uploads/nc.large.png" alt="NonCommercial" width="20">

**Copyright (c) 2024 Group 4 Golang with MIKTI MSIB Partner**

**Prohibited to sell or distribute this software for commercial purposes without written permission from us.**
Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to use, copy, modify, and distribute the Software, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

The software is provided "as is", without warranty of any kind, express or implied, including but not limited to the warranties of merchantability, fitness for a particular purpose, and non-infringement. In no event shall the authors or copyright holders be liable for any claim, damages, or other liability, whether in an action of contract, tort, or otherwise, arising from, out of, or in connection with the software or the use or other dealings in the software.

**Hak Cipta (c) 2024 Kelompok 4 Golang with MIKTI Mitra MSIB**

**Dilarang menjual atau mendistribusikan perangkat lunak** ini untuk tujuan komersial tanpa persetujuan tertulis dari kami.
Dengan ini, izin diberikan, tanpa biaya, kepada siapa pun yang memperoleh salinan perangkat lunak ini dan dokumentasi
terkait (disebut sebagai "Perangkat Lunak"),untuk menggunakan, menyalin, memodifikasi, dan mendistribusikan Perangkat Lunak,
dengan syarat pemberitahuan hak cipta di atas dan pemberitahuan ini disertakan dalam semua salinan atau bagian penting dari Perangkat Lunak.

perangkat lunak ini disediakan "sebagaimana adanya", tanpa jaminan apapun, baik tersurat maupun tersirat, termasuk namun tidak terbatas
pada jaminan diperdagangkan, kesesuaian untuk tujuan tertentu, dan non-pelanggaran. dalam keadaan apapun, penulis atau pemegang hak cipta
tidak bertanggung jawab atas klaim, kerusakan, atau kewajiban lainnya, baik dalam tindakan kontrak, tort, atau lainnya, yang timbul dari,
keluar dari, atau berhubungan dengan perangkat lunak atau penggunaan atau transaksi lain dalam perangkat lunak.
