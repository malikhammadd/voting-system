const API_BASE_URL = 'http://localhost:8080/api';

let selectedCandidate = null;
let candidates = [];

// Load candidates when position is selected
document.getElementById('position').addEventListener('change', async function() {
    const position = this.value;
    if (position) {
        await loadCandidates(position);
    } else {
        document.getElementById('candidatesContainer').innerHTML = 
            '<div class="loading">Please select a position first</div>';
    }
});

async function loadCandidates(position) {
    const container = document.getElementById('candidatesContainer');
    container.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading candidates...</div>';

    try {
        const response = await fetch(`${API_BASE_URL}/candidates/position/${encodeURIComponent(position)}`);
        if (!response.ok) {
            throw new Error('Failed to load candidates');
        }
        
        candidates = await response.json();
        displayCandidates(candidates);
    } catch (error) {
        container.innerHTML = `<div class="message error show">Error loading candidates: ${error.message}</div>`;
    }
}

function displayCandidates(candidates) {
    const container = document.getElementById('candidatesContainer');
    
    if (candidates.length === 0) {
        container.innerHTML = '<div class="loading">No candidates found for this position</div>';
        return;
    }

    container.innerHTML = candidates.map(candidate => `
        <div class="candidate-card" data-id="${candidate.id}">
            <h3>${candidate.name}</h3>
            <div class="party">${candidate.party || 'Independent'}</div>
            <div class="description">${candidate.description || 'No description available'}</div>
            <button class="vote-btn" onclick="selectCandidate(${candidate.id})">
                <i class="fas fa-vote-yea"></i> Vote for ${candidate.name}
            </button>
        </div>
    `).join('');
}

function selectCandidate(candidateId) {
    selectedCandidate = candidateId;
    
    // Update UI
    document.querySelectorAll('.candidate-card').forEach(card => {
        card.classList.remove('selected');
    });
    
    const selectedCard = document.querySelector(`[data-id="${candidateId}"]`);
    if (selectedCard) {
        selectedCard.classList.add('selected');
    }

    // Enable vote button
    document.querySelectorAll('.vote-btn').forEach(btn => {
        btn.disabled = false;
    });

    // Show message to submit
    showMessage('Candidate selected! Click "Submit Vote" below to cast your vote.', 'success');
}

async function castVote() {
    const voterName = document.getElementById('voterName').value.trim();
    const email = document.getElementById('email').value.trim();
    const cnic = document.getElementById('cnic').value.trim();
    const position = document.getElementById('position').value;

    // Validation
    if (!voterName || !email || !cnic || !position) {
        showMessage('Please fill in all fields and select a position.', 'error');
        return;
    }

    if (!selectedCandidate) {
        showMessage('Please select a candidate before voting.', 'error');
        return;
    }

    // Disable form during submission
    const form = document.getElementById('voterForm');
    const inputs = form.querySelectorAll('input, select, button');
    inputs.forEach(input => input.disabled = true);

    try {
        const response = await fetch(`${API_BASE_URL}/voting/vote`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
            },
            body: JSON.stringify({
                voterName: voterName,
                email: email,
                cnic: cnic,
                candidateId: selectedCandidate,
                position: position
            })
        });

        const data = await response.json();

        if (data.success) {
            showMessage('✓ Vote cast successfully! Thank you for voting.', 'success');
            // Reset form after 3 seconds
            setTimeout(() => {
                form.reset();
                selectedCandidate = null;
                document.getElementById('candidatesContainer').innerHTML = 
                    '<div class="loading">Please select a position to see candidates</div>';
            }, 3000);
        } else {
            showMessage(`Error: ${data.message}`, 'error');
        }
    } catch (error) {
        showMessage(`Error casting vote: ${error.message}`, 'error');
    } finally {
        // Re-enable form
        inputs.forEach(input => input.disabled = false);
    }
}

function showMessage(message, type) {
    const messageDiv = document.getElementById('message');
    messageDiv.textContent = message;
    messageDiv.className = `message ${type} show`;
    
    setTimeout(() => {
        messageDiv.classList.remove('show');
    }, 5000);
}

// Add submit vote button dynamically
document.addEventListener('DOMContentLoaded', function() {
    const form = document.getElementById('voterForm');
    const submitBtn = document.createElement('button');
    submitBtn.type = 'button';
    submitBtn.className = 'vote-btn';
    submitBtn.style.marginTop = '20px';
    submitBtn.innerHTML = '<i class="fas fa-paper-plane"></i> Submit Vote';
    submitBtn.onclick = castVote;
    form.appendChild(submitBtn);
});
