const API_BASE_URL = 'http://localhost:8080/api';

let resultsChart = null;
let allResults = [];

// Load dashboard data on page load
document.addEventListener('DOMContentLoaded', function() {
    loadStats();
    loadResults('all');
    
    document.getElementById('positionFilter').addEventListener('change', function() {
        loadResults(this.value);
    });
    
    document.getElementById('refreshBtn').addEventListener('click', function() {
        loadStats();
        const filter = document.getElementById('positionFilter').value;
        loadResults(filter);
    });
    
    // Auto-refresh every 30 seconds
    setInterval(() => {
        loadStats();
        const filter = document.getElementById('positionFilter').value;
        loadResults(filter);
    }, 30000);
});

async function loadStats() {
    try {
        const response = await fetch(`${API_BASE_URL}/voting/stats`);
        const stats = await response.json();
        
        document.getElementById('totalVotes').textContent = stats.totalVotes || 0;
        document.getElementById('totalVoters').textContent = stats.totalVoters || 0;
        
        const turnout = stats.totalVoters > 0 
            ? ((stats.totalVotes / stats.totalVoters) * 100).toFixed(1) 
            : 0;
        document.getElementById('turnout').textContent = `${turnout}%`;
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

async function loadResults(filter) {
    const container = document.getElementById('resultsContainer');
    container.innerHTML = '<div class="loading"><i class="fas fa-spinner fa-spin"></i> Loading results...</div>';

    try {
        const response = filter === 'all' 
            ? await fetch(`${API_BASE_URL}/voting/results`)
            : await fetch(`${API_BASE_URL}/voting/results/position/${encodeURIComponent(filter)}`);
        
        if (!response.ok) {
            throw new Error('Failed to load results');
        }
        
        allResults = await response.json();
        displayResults(allResults, filter);
        updateChart(allResults, filter);
    } catch (error) {
        container.innerHTML = `<div class="message error show">Error loading results: ${error.message}</div>`;
    }
}

function displayResults(results, filter) {
    const container = document.getElementById('resultsContainer');
    
    if (results.length === 0) {
        container.innerHTML = '<div class="loading">No results available yet</div>';
        return;
    }

    // Group results by position
    const grouped = {};
    results.forEach(result => {
        if (!grouped[result.position]) {
            grouped[result.position] = [];
        }
        grouped[result.position].push(result);
    });

    // Filter by selected position if needed
    const positions = filter === 'all' 
        ? Object.keys(grouped)
        : [filter];

    let html = '';
    
    positions.forEach(position => {
        if (!grouped[position] || grouped[position].length === 0) return;
        
        const positionResults = grouped[position].sort((a, b) => b.voteCount - a.voteCount);
        const maxVotes = Math.max(...positionResults.map(r => r.voteCount));
        
        html += `
            <div class="position-group">
                <h3><i class="fas fa-briefcase"></i> ${position}</h3>
                ${positionResults.map(result => `
                    <div class="result-item">
                        <div class="result-info">
                            <h4>${result.candidateName}</h4>
                            <div class="party">${result.party || 'Independent'}</div>
                            <div class="votes">${result.voteCount} votes</div>
                            <div class="progress-bar">
                                <div class="progress-fill" style="width: ${result.percentage}%">
                                    ${result.percentage.toFixed(1)}%
                                </div>
                            </div>
                        </div>
                        <div class="result-stats">
                            <div class="percentage">${result.percentage.toFixed(1)}%</div>
                            <div class="vote-count">${result.voteCount} votes</div>
                        </div>
                    </div>
                `).join('')}
            </div>
        `;
    });

    container.innerHTML = html || '<div class="loading">No results available</div>';
}

function updateChart(results, filter) {
    const ctx = document.getElementById('resultsChart').getContext('2d');
    
    // Filter results if needed
    const filteredResults = filter === 'all' 
        ? results 
        : results.filter(r => r.position === filter);

    if (filteredResults.length === 0) {
        if (resultsChart) {
            resultsChart.destroy();
        }
        return;
    }

    // Group by position
    const grouped = {};
    filteredResults.forEach(result => {
        if (!grouped[result.position]) {
            grouped[result.position] = [];
        }
        grouped[result.position].push(result);
    });

    const datasets = Object.keys(grouped).map((position, index) => {
        const positionResults = grouped[position];
        const colors = [
            'rgba(74, 144, 226, 0.8)',
            'rgba(80, 200, 120, 0.8)',
            'rgba(243, 156, 18, 0.8)',
            'rgba(231, 76, 60, 0.8)',
            'rgba(155, 89, 182, 0.8)',
        ];
        
        return {
            label: position,
            data: positionResults.map(r => r.voteCount),
            backgroundColor: colors[index % colors.length],
            borderColor: colors[index % colors.length].replace('0.8', '1'),
            borderWidth: 2
        };
    });

    if (resultsChart) {
        resultsChart.destroy();
    }

    resultsChart = new Chart(ctx, {
        type: 'bar',
        data: {
            labels: filteredResults.map(r => r.candidateName),
            datasets: datasets
        },
        options: {
            responsive: true,
            maintainAspectRatio: false,
            plugins: {
                legend: {
                    display: true,
                    position: 'top',
                },
                title: {
                    display: true,
                    text: 'Election Results',
                    font: {
                        size: 18
                    }
                }
            },
            scales: {
                y: {
                    beginAtZero: true,
                    ticks: {
                        stepSize: 1
                    }
                }
            }
        }
    });
}
