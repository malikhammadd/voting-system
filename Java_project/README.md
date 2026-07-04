# Online Voting System

A complete full-stack voting application with Java Spring Boot backend and modern HTML/CSS/JavaScript frontend, integrated with XAMPP MySQL database.

## Features

- ✅ Secure voter registration and authentication
- ✅ Multiple candidate support for different positions
- ✅ Real-time voting interface
- ✅ Live results dashboard with charts
- ✅ Vote counting and percentage calculations
- ✅ Prevention of duplicate votes
- ✅ Modern, responsive UI design

## Prerequisites

- Java JDK 11 or higher
- Maven 3.6+
- XAMPP (with MySQL and Apache running)
- Web browser (Chrome, Firefox, Edge)
- Any web server or live server extension (for frontend)

## Database Setup (XAMPP MySQL)

1. **Start XAMPP**
   - Open XAMPP Control Panel
   - Start Apache and MySQL services

2. **Create Database**
   - Open phpMyAdmin: http://localhost/phpmyadmin
   - Navigate to "SQL" tab
   - Copy and execute the SQL from `database/schema.sql`
   - Or use the MySQL command line:
     ```bash
     mysql -u root -p < database/schema.sql
     ```

3. **Verify Database**
   - Database name: `voting_db`
   - Tables: `candidates`, `voters`, `votes`
   - Default username: `root`
   - Default password: (empty/blank for XAMPP)

## Backend Setup (Spring Boot)

1. **Navigate to project directory**
   ```bash
   cd Java_project
   ```

2. **Configure Database Connection**
   - Edit `src/main/resources/application.properties`
   - Update if your MySQL has a password:
     ```properties
     spring.datasource.password=your_password
     ```

3. **Build and Run Backend**
   ```bash
   # Build the project
   mvn clean install

   # Run the application
   mvn spring-boot:run
   ```

4. **Verify Backend is Running**
   - Open: http://localhost:8080/api/candidates
   - You should see JSON data of candidates

## Frontend Setup

1. **Option 1: Using Live Server (VS Code)**
   - Install "Live Server" extension
   - Right-click on `frontend/index.html`
   - Select "Open with Live Server"

2. **Option 2: Using Python HTTP Server**
   ```bash
   cd frontend
   python -m http.server 5500
   ```

3. **Option 3: Using Node.js http-server**
   ```bash
   npx http-server frontend -p 5500
   ```

4. **Access the Application**
   - Voting Page: http://localhost:5500/index.html
   - Dashboard: http://localhost:5500/dashboard.html

## Project Structure

```
Java_project/
├── src/main/java/com/votingapp/
│   ├── VotingApplication.java          # Main Spring Boot app
│   ├── config/
│   │   └── CorsConfig.java             # CORS configuration
│   ├── controller/
│   │   ├── CandidateController.java    # Candidate endpoints
│   │   └── VotingController.java       # Voting endpoints
│   ├── dto/
│   │   ├── VoteRequest.java            # Vote request DTO
│   │   └── VoteResult.java             # Vote result DTO
│   ├── model/
│   │   ├── Candidate.java              # Candidate entity
│   │   ├── Voter.java                  # Voter entity
│   │   └── Vote.java                   # Vote entity
│   ├── repository/
│   │   ├── CandidateRepository.java    # Candidate repository
│   │   ├── VoterRepository.java        # Voter repository
│   │   └── VoteRepository.java         # Vote repository
│   └── service/
│       └── VotingService.java          # Business logic
├── src/main/resources/
│   └── application.properties          # Spring Boot config
├── database/
│   └── schema.sql                      # Database schema
├── frontend/
│   ├── index.html                      # Voting interface
│   ├── dashboard.html                  # Results dashboard
│   ├── css/
│   │   ├── style.css                   # Main styles
│   │   └── dashboard.css               # Dashboard styles
│   └── js/
│       ├── voting.js                   # Voting logic
│       └── dashboard.js                # Dashboard logic
└── pom.xml                             # Maven dependencies
```

## API Endpoints

### Candidate Endpoints
- `GET /api/candidates` - Get all candidates
- `GET /api/candidates/position/{position}` - Get candidates by position
- `GET /api/candidates/{id}` - Get candidate by ID

### Voting Endpoints
- `POST /api/voting/vote` - Cast a vote
  ```json
  {
    "voterName": "John Doe",
    "email": "john@example.com",
    "cnic": "12345-1234567-1",
    "candidateId": 1,
    "position": "President"
  }
  ```
- `GET /api/voting/results` - Get all vote results
- `GET /api/voting/results/position/{position}` - Get results by position
- `GET /api/voting/stats` - Get voting statistics

## Default Data

The schema includes sample candidates:
- **President**: John Doe, Jane Smith, Robert Johnson
- **Mayor**: Alice Brown, Charlie Wilson, Diana Miller

## Troubleshooting

### MySQL Connection Issues
- Ensure XAMPP MySQL is running
- Check if port 3306 is available
- Verify database credentials in `application.properties`

### CORS Errors
- Ensure backend is running on port 8080
- Check CORS configuration in `CorsConfig.java`

### Frontend Not Loading
- Ensure backend API is accessible at http://localhost:8080
- Check browser console for errors
- Verify API_BASE_URL in JavaScript files

## Development Notes

- Backend runs on: http://localhost:8080
- Frontend runs on: http://localhost:5500 (or your chosen port)
- Database: MySQL on localhost:3306
- Database name: voting_db

## Security Considerations

⚠️ **This is a development version. For production:**
- Add password to MySQL database
- Implement proper authentication
- Add HTTPS encryption
- Implement rate limiting
- Add input validation and sanitization
- Use environment variables for sensitive data

## License

This project is for educational purposes.
