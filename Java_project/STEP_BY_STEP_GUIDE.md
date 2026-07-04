# Step-by-Step Guide to Run Voting Application

## Prerequisites Check

### 1. Check if Java is installed
```bash
java -version
```
**Expected output:** Java version 11 or higher
**If not installed:** Download from https://adoptium.net/

### 2. Check if Maven is installed
```bash
mvn -version
```
**Expected output:** Apache Maven 3.6 or higher
**If not installed:** Download from https://maven.apache.org/download.cgi

### 3. Verify XAMPP is installed
- Open XAMPP Control Panel
- Make sure MySQL service is available

---

## Step 1: Start XAMPP MySQL

### Windows:
1. Open **XAMPP Control Panel**
2. Click **Start** button next to **MySQL**
3. Wait for green indicator (MySQL is running on port 3306)

### Verify MySQL is running:
```bash
mysql -u root -e "SELECT VERSION();"
```
**Expected output:** MySQL version number

---

## Step 2: Create Database

### Option A: Using phpMyAdmin (Easier)
1. Open browser: http://localhost/phpmyadmin
2. Click on **SQL** tab (top menu)
3. Open file: `database/schema.sql` in a text editor
4. Copy entire content
5. Paste into phpMyAdmin SQL textarea
6. Click **Go** button
7. Verify: You should see "voting_db" database with 3 tables

### Option B: Using Command Line
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project
mysql -u root < database/schema.sql
```

### Verify Database:
```bash
mysql -u root -e "USE voting_db; SHOW TABLES;"
```
**Expected output:** candidates, votes, voters

---

## Step 3: Configure Database (If needed)

### Check if MySQL has password:
```bash
mysql -u root -p
```
- If it asks for password, you have one set
- If it connects without password, you're using default XAMPP settings

### If you have a password, update configuration:
Edit file: `src/main/resources/application.properties`
```properties
spring.datasource.password=YOUR_PASSWORD_HERE
```

---

## Step 4: Build the Backend Project

### Navigate to project directory:
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project
```

### Clean and build project:
```bash
mvn clean install
```
**This will:**
- Download dependencies (first time takes 2-5 minutes)
- Compile Java code
- Run tests
- Create JAR file

**Expected output:** `BUILD SUCCESS`

---

## Step 5: Run the Backend Server

### Start Spring Boot application:
```bash
mvn spring-boot:run
```

**What happens:**
- Application starts on port 8080
- Connects to MySQL database
- Creates tables if they don't exist
- Waits for requests

**Expected output:**
```
Started VotingApplication in X.XXX seconds (JVM running for X.XXX)
```

**Keep this terminal window open!** The server must keep running.

---

## Step 6: Test Backend API (New Terminal Window)

### Open a NEW terminal/command prompt (keep backend running)

### Test if backend is running:
```bash
curl http://localhost:8080/api/candidates
```

**Or open in browser:**
http://localhost:8080/api/candidates

**Expected:** JSON array with candidate data

---

## Step 7: Start Frontend Server

### Open a NEW terminal window (keep backend running)

### Option A: Using Python HTTP Server
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project\frontend
python -m http.server 5500
```

**If Python not found:**
```bash
python3 -m http.server 5500
```

### Option B: Using Node.js (if you have it)
```bash
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project\frontend
npx http-server -p 5500
```

### Option C: Using VS Code Live Server
1. Install "Live Server" extension in VS Code
2. Right-click `frontend/index.html`
3. Select "Open with Live Server"

---

## Step 8: Access the Application

### Open browser and visit:

1. **Voting Page:**
   ```
   http://localhost:5500/index.html
   ```

2. **Dashboard:**
   ```
   http://localhost:5500/dashboard.html
   ```

3. **API Test Page:**
   ```
   http://localhost:5500/test-api.html
   ```

---

## Step 9: Test the Application

### A. Cast a Vote:
1. Go to: http://localhost:5500/index.html
2. Fill in voter information:
   - Name: Your Name
   - Email: test@example.com
   - CNIC: 12345-1234567-3
3. Select Position: "President" or "Mayor"
4. Select a candidate
5. Click "Submit Vote"
6. See success message

### B. View Results:
1. Go to: http://localhost:5500/dashboard.html
2. See real-time vote counts
3. Filter by position
4. View charts

### C. Verify in Database:
```bash
mysql -u root -e "USE voting_db; SELECT * FROM votes;"
```

---

## Quick Commands Summary

### All commands in sequence:
```bash
# 1. Navigate to project
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project

# 2. Build project
mvn clean install

# 3. Start backend (Terminal 1)
mvn spring-boot:run

# 4. Start frontend (Terminal 2 - NEW window)
cd frontend
python -m http.server 5500
```

---

## Troubleshooting Commands

### Check if port 8080 is in use:
```bash
netstat -ano | findstr :8080
```

### Check if port 5500 is in use:
```bash
netstat -ano | findstr :5500
```

### Test MySQL connection:
```bash
mysql -u root -e "SHOW DATABASES;"
```

### View application logs:
Check the terminal where you ran `mvn spring-boot:run`

### Kill process on port (if needed):
```bash
# Find process ID from netstat command above
taskkill /PID <process_id> /F
```

---

## Stopping the Application

### To stop backend:
- In backend terminal, press: `Ctrl + C`

### To stop frontend:
- In frontend terminal, press: `Ctrl + C`

### To stop MySQL:
- XAMPP Control Panel → Click **Stop** next to MySQL

---

## Common Issues & Solutions

### Issue: "Port 8080 already in use"
**Solution:**
```bash
# Change port in application.properties
# Or kill the process using port 8080
```

### Issue: "Cannot connect to database"
**Solution:**
```bash
# 1. Verify XAMPP MySQL is running
# 2. Test connection:
mysql -u root -e "SELECT 1;"
# 3. Check application.properties password setting
```

### Issue: "Maven not found"
**Solution:**
- Add Maven to PATH environment variable
- Or use full path to mvn.exe

### Issue: "Frontend can't connect to backend"
**Solution:**
1. Verify backend is running: http://localhost:8080/api/candidates
2. Check browser console (F12) for CORS errors
3. Verify API_BASE_URL in JavaScript files

---

## Development Workflow

### Daily startup sequence:
```bash
# Terminal 1: Backend
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project
mvn spring-boot:run

# Terminal 2: Frontend
cd c:\Users\Malik Hammad\OneDrive\Desktop\Java_project\frontend
python -m http.server 5500
```

### After code changes:
- **Backend changes:** Restart Spring Boot (Ctrl+C, then `mvn spring-boot:run`)
- **Frontend changes:** Just refresh browser (no restart needed)

---

## Production Build

### Create executable JAR:
```bash
mvn clean package
```

### Run JAR file:
```bash
java -jar target/voting-app-1.0.0.jar
```

---

## Need Help?

1. Check backend logs in terminal
2. Open browser DevTools (F12) → Console tab
3. Test API: http://localhost:8080/api/candidates
4. Test database: `mysql -u root voting_db -e "SELECT * FROM candidates;"`
