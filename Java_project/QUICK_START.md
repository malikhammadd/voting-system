# Quick Start Guide

## Step-by-Step Setup for XAMPP MySQL

### 1. Start XAMPP
- Open **XAMPP Control Panel**
- Click **Start** for **Apache** (if needed for phpMyAdmin)
- Click **Start** for **MySQL**

### 2. Create Database
**Option A: Using phpMyAdmin (Recommended)**
1. Open browser: http://localhost/phpmyadmin
2. Click on **SQL** tab
3. Copy entire content from `database/schema.sql`
4. Paste and click **Go**
5. Verify database `voting_db` is created with 3 tables

**Option B: Using Command Line**
```bash
mysql -u root < database/schema.sql
```

### 3. Verify Database Configuration
- Open `src/main/resources/application.properties`
- Default settings (should work with XAMPP):
  - Username: `root`
  - Password: (empty)
  - Database: `voting_db`
  - Port: `3306`

If you changed MySQL password in XAMPP, update:
```properties
spring.datasource.password=your_password
```

### 4. Run Backend
```bash
# Navigate to project folder
cd Java_project

# Run Spring Boot application
mvn spring-boot:run
```

Wait for: `Started VotingApplication in X.XXX seconds`

### 5. Start Frontend
**Using Live Server (VS Code):**
1. Open VS Code in project folder
2. Install "Live Server" extension
3. Right-click `frontend/index.html`
4. Click "Open with Live Server"

**Using Python:**
```bash
cd frontend
python -m http.server 5500
```

**Using Node.js:**
```bash
cd frontend
npx http-server -p 5500
```

### 6. Access Application
- **Voting Page**: http://localhost:5500/index.html
- **Dashboard**: http://localhost:5500/dashboard.html
- **API Test**: http://localhost:8080/api/candidates

## Testing the Application

1. **Test Voting:**
   - Select a position (President or Mayor)
   - Fill in voter details
   - Select a candidate
   - Click "Submit Vote"

2. **View Results:**
   - Navigate to Dashboard
   - See real-time vote counts
   - Filter by position
   - View charts

3. **Verify in Database:**
   - Open phpMyAdmin
   - Go to `voting_db` database
   - Check `votes` table for your vote
   - Check `voters` table for registered voters

## Troubleshooting

**Backend won't start:**
- Check if MySQL is running in XAMPP
- Verify database exists: `voting_db`
- Check port 8080 is not in use
- Look at console error messages

**Frontend can't connect:**
- Ensure backend is running on port 8080
- Open browser console (F12) and check errors
- Verify API URL in `frontend/js/voting.js` and `dashboard.js`

**Database connection error:**
- Verify XAMPP MySQL is running
- Check credentials in `application.properties`
- Try: `mysql -u root -p` to test connection

**Port already in use:**
- Change port in `application.properties`: `server.port=8081`
- Update frontend API URLs accordingly

## Default Test Data

Already included in database:
- **3 President candidates**: John Doe, Jane Smith, Robert Johnson
- **3 Mayor candidates**: Alice Brown, Charlie Wilson, Diana Miller
- **2 Test voters**: voter1@test.com, voter2@test.com

## Architecture

```
Frontend (localhost:5500)
    ↓ HTTP Requests
Backend API (localhost:8080)
    ↓ JDBC
MySQL Database (localhost:3306)
    ↓
XAMPP MySQL
```

Happy Voting! 🗳️
