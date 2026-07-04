# Quick Command Reference

## 🚀 Fastest Way to Start (3 Commands)

### Terminal 1 - Backend:
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project
mvn spring-boot:run
```

### Terminal 2 - Frontend:
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project\frontend
python -m http.server 5500
```

### Or use batch files (Windows):
Double-click `run-backend.bat` (then open new window)
Double-click `run-frontend.bat`

---

## 📋 Setup Commands (First Time Only)

### 1. Create Database:
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project
mysql -u root < database/schema.sql
```

### 2. Build Project:
```bash
mvn clean install
```

---

## 🔍 Verification Commands

### Test Database:
```bash
mysql -u root -e "USE voting_db; SHOW TABLES;"
```

### Test Backend API:
```bash
curl http://localhost:8080/api/candidates
```

### Check Ports:
```bash
netstat -ano | findstr :8080
netstat -ano | findstr :5500
```

---

## 🗄️ Database Commands

### View all candidates:
```bash
mysql -u root -e "USE voting_db; SELECT * FROM candidates;"
```

### View all votes:
```bash
mysql -u root -e "USE voting_db; SELECT * FROM votes;"
```

### View all voters:
```bash
mysql -u root -e "USE voting_db; SELECT * FROM voters;"
```

### Count votes:
```bash
mysql -u root -e "USE voting_db; SELECT COUNT(*) as total_votes FROM votes;"
```

---

## 🛠️ Build & Run Commands

### Clean build:
```bash
mvn clean install
```

### Run application:
```bash
mvn spring-boot:run
```

### Build JAR (for distribution):
```bash
mvn clean package
```

### Run JAR file:
```bash
java -jar target/voting-app-1.0.0.jar
```

---

## 🌐 Frontend Commands

### Python Server:
```bash
cd frontend
python -m http.server 5500
```

### Python 3:
```bash
cd frontend
python3 -m http.server 5500
```

### Node.js (if installed):
```bash
cd frontend
npx http-server -p 5500
```

---

## 🐛 Troubleshooting Commands

### Kill process on port 8080:
```bash
# Find PID first
netstat -ano | findstr :8080
# Kill it (replace <PID> with actual number)
taskkill /PID <PID> /F
```

### Check Java version:
```bash
java -version
```

### Check Maven version:
```bash
mvn -version
```

### Check MySQL version:
```bash
mysql --version
```

---

## 📍 URLs to Access

| Service | URL |
|---------|-----|
| Voting Page | http://localhost:5500/index.html |
| Dashboard | http://localhost:5500/dashboard.html |
| API Test | http://localhost:5500/test-api.html |
| Backend API | http://localhost:8080/api/candidates |
| phpMyAdmin | http://localhost/phpmyadmin |

---

## ⚡ Quick Start Sequence

```bash
# Step 1: Start XAMPP MySQL (from XAMPP Control Panel)

# Step 2: Create database
mysql -u root < database/schema.sql

# Step 3: Build project
mvn clean install

# Step 4: Start backend (Terminal 1)
mvn spring-boot:run

# Step 5: Start frontend (Terminal 2)
cd frontend
python -m http.server 5500

# Step 6: Open browser
start http://localhost:5500/index.html
```

---

## 🛑 Stop Commands

| Service | Command |
|---------|---------|
| Backend | `Ctrl + C` (in backend terminal) |
| Frontend | `Ctrl + C` (in frontend terminal) |
| MySQL | Stop from XAMPP Control Panel |

---

## 📝 Environment Check

Run this to verify everything is ready:
```bash
java -version && echo Java: OK || echo Java: MISSING
mvn -version && echo Maven: OK || echo Maven: MISSING
mysql --version && echo MySQL: OK || echo MySQL: MISSING
python --version && echo Python: OK || echo Python: MISSING
```
