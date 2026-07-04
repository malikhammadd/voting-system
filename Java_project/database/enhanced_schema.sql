-- Enhanced Voting Database Schema for MySQL (XAMPP)
-- Run this in phpMyAdmin or MySQL command line

CREATE DATABASE IF NOT EXISTS voting_db;
USE voting_db;

-- Drop existing tables if they exist (for clean setup)
DROP TABLE IF EXISTS votes;
DROP TABLE IF EXISTS voters;
DROP TABLE IF EXISTS candidates;

-- Candidates Table
CREATE TABLE candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    party VARCHAR(255),
    position VARCHAR(255) NOT NULL,
    description TEXT,
    image_url VARCHAR(500),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_position (position)
);

-- Voters Table
CREATE TABLE voters (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255) UNIQUE NOT NULL,
    cnic VARCHAR(20) UNIQUE NOT NULL,
    has_voted BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_email (email),
    INDEX idx_cnic (cnic)
);

-- Votes Table
CREATE TABLE votes (
    id INT AUTO_INCREMENT PRIMARY KEY,
    voter_id INT NOT NULL,
    candidate_id INT NOT NULL,
    position VARCHAR(255) NOT NULL,
    voted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (voter_id) REFERENCES voters(id) ON DELETE CASCADE,
    FOREIGN KEY (candidate_id) REFERENCES candidates(id) ON DELETE CASCADE,
    UNIQUE KEY unique_voter_position (voter_id, position),
    INDEX idx_candidate (candidate_id),
    INDEX idx_position (position)
);

-- Insert Enhanced Sample Candidates for President
INSERT INTO candidates (name, party, position, description, image_url) VALUES
('John Doe', 'Progressive Party', 'President', 'Experienced leader with 15 years in public service. Committed to economic growth and social justice. Visionary leader focused on innovation and progress.', NULL),
('Jane Smith', 'Democratic Alliance', 'President', 'Dedicated to transparency and progress. Former minister with proven track record. Advocate for education and healthcare reform.', NULL),
('Robert Johnson', 'National Unity', 'President', 'Building bridges for a better future. Expert in international relations and trade. Promises to unite the nation.', NULL),
('Sarah Williams', 'Green Party', 'President', 'Environment-first leader. PhD in Environmental Science. Champion of climate action and sustainable development.', NULL);

-- Insert Enhanced Sample Candidates for Mayor
INSERT INTO candidates (name, party, position, description, image_url) VALUES
('Alice Brown', 'Green Party', 'Mayor', 'Environment-focused leadership. Experienced urban planner. Committed to green infrastructure and sustainable city development.', NULL),
('Charlie Wilson', 'People\'s Party', 'Mayor', 'Community-first approach. Local businessman with 20 years community service. Focus on infrastructure and public safety.', NULL),
('Diana Miller', 'Independent', 'Mayor', 'No party affiliation, pure service. Retired teacher and community organizer. Promises transparent governance.', NULL),
('Michael Chen', 'Urban Development Party', 'Mayor', 'Tech-savvy leader. Former tech executive. Plans to digitize city services and improve connectivity.', NULL);

-- Insert Enhanced Sample Candidates for Governor
INSERT INTO candidates (name, party, position, description, image_url) VALUES
('David Thompson', 'Conservative Party', 'Governor', 'Fiscal conservative with business background. Focus on economic development and job creation.', NULL),
('Emma Davis', 'Liberal Party', 'Governor', 'Social progressive and education advocate. Plans to invest heavily in public education and healthcare.', NULL),
('James Wilson', 'Moderate Alliance', 'Governor', 'Centrist politician balancing fiscal responsibility with social programs. Former senator.', NULL);

-- Insert Sample Voters (for testing)
INSERT INTO voters (name, email, cnic, has_voted) VALUES
('Test Voter 1', 'voter1@test.com', '12345-1234567-1', FALSE),
('Test Voter 2', 'voter2@test.com', '12345-1234567-2', FALSE),
('Sample User', 'sample@example.com', '11111-1111111-1', FALSE);

-- Create View for Vote Results
CREATE OR REPLACE VIEW vote_results AS
SELECT 
    c.id as candidate_id,
    c.name as candidate_name,
    c.party,
    c.position,
    COUNT(v.id) as vote_count,
    ROUND(COUNT(v.id) * 100.0 / NULLIF((SELECT COUNT(*) FROM votes WHERE position = c.position), 0), 2) as percentage
FROM candidates c
LEFT JOIN votes v ON c.id = v.candidate_id
GROUP BY c.id, c.name, c.party, c.position;

-- Create View for Statistics
CREATE OR REPLACE VIEW voting_statistics AS
SELECT 
    (SELECT COUNT(*) FROM voters) as total_voters,
    (SELECT COUNT(*) FROM voters WHERE has_voted = TRUE) as voters_voted,
    (SELECT COUNT(*) FROM votes) as total_votes,
    (SELECT COUNT(DISTINCT position) FROM candidates) as positions_count,
    (SELECT COUNT(*) FROM candidates) as candidates_count;

-- Verify the data
SELECT 'Database setup complete!' as status;
SELECT COUNT(*) as candidates_count FROM candidates;
SELECT COUNT(*) as voters_count FROM voters;
SELECT 'You can now start voting!' as message;

