# XAMPP phpMyAdmin Links & Database Setup Guide

## 🔗 Direct XAMPP Links

### 1. phpMyAdmin (Database Management)
```
http://localhost/phpmyadmin
```

### 2. XAMPP Dashboard
```
http://localhost/dashboard
```

### 3. Apache Welcome Page (if running)
```
http://localhost
```

---

## 📋 Quick Database Setup in phpMyAdmin

### Method 1: Import SQL File (Recommended)

1. **Start XAMPP MySQL**
   - Open XAMPP Control Panel
   - Click "Start" next to MySQL
   - Wait for green indicator

2. **Access phpMyAdmin**
   - Open: http://localhost/phpmyadmin
   - Login (default: username `root`, password: empty/blank)

3. **Import Database**
   - Click on "New" in left sidebar (or "Databases" tab)
   - Click "Import" tab at the top
   - Click "Choose File"
   - Navigate to: `Java_project/database/enhanced_schema.sql`
   - Click "Go" button
   - Wait for success message

4. **Verify Database**
   - You should see `voting_db` in left sidebar
   - Click on it to see tables: candidates, voters, votes

---

### Method 2: Copy-Paste SQL (Alternative)

1. **Open phpMyAdmin**
   - Go to: http://localhost/phpmyadmin

2. **Click SQL Tab**
   - Click on "SQL" tab at the top

3. **Copy SQL Code**
   - Open file: `database/enhanced_schema.sql` in text editor
   - Copy all content (Ctrl+A, Ctrl+C)

4. **Paste and Execute**
   - Paste into phpMyAdmin SQL textarea
   - Click "Go" button
   - Wait for execution

5. **Check Results**
   - You should see green success messages
   - Database `voting_db` created
   - 11 candidates inserted
   - 3 test voters inserted

---

## 📊 Verify Database Setup

### Check Tables:
```
http://localhost/phpmyadmin
→ Click on "voting_db" (left sidebar)
→ You should see 3 tables:
   - candidates
   - voters
   - votes
```

### View Candidates:
In phpMyAdmin SQL tab, run:
```sql
SELECT * FROM voting_db.candidates;
```

**Expected:** 11 rows (4 President, 4 Mayor, 3 Governor)

### View Sample Data:
```sql
SELECT * FROM voting_db.candidates WHERE position = 'President';
```
Should show 4 candidates

---

## 🔍 Database Connection Test

### Test MySQL Connection (Command Line):
```bash
mysql -u root -e "SELECT VERSION();"
```

### Test Database Access:
```bash
mysql -u root -e "USE voting_db; SHOW TABLES;"
```

### View All Candidates:
```bash
mysql -u root -e "USE voting_db; SELECT * FROM candidates;"
```

---

## 📝 Database Details

**Database Name:** `voting_db`

**Tables:**
1. **candidates** - 11 rows
   - 4 President candidates
   - 4 Mayor candidates
   - 3 Governor candidates

2. **voters** - 3 rows (test data)

3. **votes** - Empty (will be populated when voting starts)

**Views Created:**
- `vote_results` - Pre-calculated vote statistics
- `voting_statistics` - Overall voting stats

---

## 🛠️ Troubleshooting

### Issue: phpMyAdmin not loading
**Solution:**
- Start Apache in XAMPP Control Panel
- Access: http://localhost/phpmyadmin

### Issue: Can't connect to MySQL
**Solution:**
- Check XAMPP Control Panel - MySQL must be running (green)
- Default port: 3306
- Username: root
- Password: (empty/blank for default XAMPP)

### Issue: Import fails
**Solution:**
- Check file encoding (should be UTF-8)
- Try Method 2 (copy-paste SQL)
- Check MySQL error logs in XAMPP

### Issue: Database already exists
**Solution:**
- Option 1: Drop and recreate
  ```sql
  DROP DATABASE IF EXISTS voting_db;
  ```
  Then import again

- Option 2: Use existing database
  - The schema uses `CREATE IF NOT EXISTS`
  - Will add new data if tables exist

---

## 📖 Quick SQL Commands for Testing

### View all candidates:
```sql
USE voting_db;
SELECT * FROM candidates;
```

### Count votes:
```sql
USE voting_db;
SELECT COUNT(*) as total_votes FROM votes;
```

### Check voters:
```sql
USE voting_db;
SELECT * FROM voters;
```

### View vote results:
```sql
USE voting_db;
SELECT * FROM vote_results;
```

---

## ✅ Verification Checklist

After setting up database, verify:

- [ ] Database `voting_db` exists
- [ ] 3 tables created: candidates, voters, votes
- [ ] 11 candidates inserted
- [ ] 3 test voters inserted
- [ ] Can connect: `mysql -u root voting_db`
- [ ] phpMyAdmin shows all tables
- [ ] Backend can connect (when you start it)

---

## 🚀 Next Steps After Database Setup

1. **Start Backend:**
   ```bash
   cd Java_project
   mvn spring-boot:run
   ```

2. **Verify Connection:**
   - Backend logs should show: "Started VotingApplication"
   - Test API: http://localhost:8080/api/candidates

3. **Start Frontend:**
   ```bash
   cd frontend
   python -m http.server 5500
   ```

4. **Test Application:**
   - Open: http://localhost:5500/index.html
   - Cast a test vote
   - Check dashboard for results
   - Verify in phpMyAdmin that vote was saved

---

## 📱 XAMPP Control Panel Quick Reference

**Start Services:**
- Click "Start" next to MySQL
- Click "Start" next to Apache (for phpMyAdmin)

**Stop Services:**
- Click "Stop" next to running service

**View Logs:**
- Click "Logs" button next to MySQL
- Check for connection errors

**Admin Button:**
- Apache → Opens http://localhost
- MySQL → Opens http://localhost/phpmyadmin

---

## 🎯 Default XAMPP Settings

**MySQL Configuration:**
- Port: 3306
- Username: root
- Password: (empty/blank)
- Host: localhost

**Apache Configuration:**
- Port: 80
- Document Root: C:\xampp\htdocs

**phpMyAdmin:**
- URL: http://localhost/phpmyadmin
- Default login: root / (no password)

---

**All links should work when XAMPP is running!** ✅

