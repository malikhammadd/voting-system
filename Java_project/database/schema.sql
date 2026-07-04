-- Voting Database Schema for MySQL (XAMPP)

CREATE DATABASE IF NOT EXISTS voting_db;
USE voting_db;

-- Candidates Table
CREATE TABLE IF NOT EXISTS candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    party VARCHAR(255),
    position VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Voters Table
CREATE TABLE IF NOT EXISTS voters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    cnic VARCHAR(20) UNIQUE NOT NULL,
    has_voted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Votes Table
CREATE TABLE IF NOT EXISTS votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    position VARCHAR(255) NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    UNIQUE KEY unique_voter_position (voter_id, position)
);

-- Insert Sample Candidates
INSERT INTO candidates (name, party, position, description) VALUES
('John Doe', 'Progressive Party', 'President', 'Experienced leader with vision for change'),
('Jane Smith', 'Democratic Alliance', 'President', 'Dedicated to transparency and progress'),
('Robert Johnson', 'National Unity', 'President', 'Building bridges for a better future'),
('Alice Brown', 'Green Party', 'Mayor', 'Environment-focused leadership'),
('Charlie Wilson', 'People\'s Party', 'Mayor', 'Community-first approach'),
('Diana Miller', 'Independent', 'Mayor', 'No party affiliation, pure service');

-- Insert Sample Voters (for testing)
INSERT INTO voters (name, email, cnic, has_voted) VALUES
('Test Voter 1', 'voter1@test.com', '12345-1234567-1', FALSE),
('Test Voter 2', 'voter2@test.com', '12345-1234567-2', FALSE);
