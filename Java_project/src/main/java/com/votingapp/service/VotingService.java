package com.votingapp.service;

import com.votingapp.dto.VoteRequest;
import com.votingapp.dto.VoteResult;
import com.votingapp.model.Candidate;
import com.votingapp.model.Vote;
import com.votingapp.model.Voter;
import com.votingapp.repository.CandidateRepository;
import com.votingapp.repository.VoteRepository;
import com.votingapp.repository.VoterRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;

@Service
public class VotingService {

    @Autowired
    private CandidateRepository candidateRepository;

    @Autowired
    private VoterRepository voterRepository;

    @Autowired
    private VoteRepository voteRepository;

    public List<Candidate> getAllCandidates() {
        return candidateRepository.findAll();
    }

    public List<Candidate> getCandidatesByPosition(String position) {
        return candidateRepository.findByPosition(position);
    }

    public Candidate getCandidateById(Long id) {
        return candidateRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Candidate not found with id: " + id));
    }

    @Transactional
    public Vote castVote(VoteRequest voteRequest) {
        // Check if voter already voted for this position
        Optional<Voter> existingVoter = voterRepository.findByEmail(voteRequest.getEmail());
        Voter voter;

        if (existingVoter.isPresent()) {
            voter = existingVoter.get();
            
            // Check if already voted for this position
            Optional<Vote> existingVote = voteRepository.findByVoterIdAndPosition(voter.getId(), voteRequest.getPosition());
            if (existingVote.isPresent()) {
                throw new RuntimeException("You have already voted for " + voteRequest.getPosition());
            }
        } else {
            // Create new voter
            voter = new Voter();
            voter.setName(voteRequest.getVoterName());
            voter.setEmail(voteRequest.getEmail());
            voter.setCnic(voteRequest.getCnic());
            voter.setHasVoted(false);
            voter = voterRepository.save(voter);
        }

        // Get candidate
        Candidate candidate = getCandidateById(voteRequest.getCandidateId());

        // Create vote
        Vote vote = new Vote();
        vote.setVoter(voter);
        vote.setCandidate(candidate);
        vote.setPosition(voteRequest.getPosition());

        Vote savedVote = voteRepository.save(vote);

        // Update voter status
        if (!voter.getHasVoted()) {
            voter.setHasVoted(true);
            voterRepository.save(voter);
        }

        return savedVote;
    }

    public List<VoteResult> getVoteResults() {
        List<Candidate> allCandidates = candidateRepository.findAll();
        List<Vote> allVotes = voteRepository.findAll();

        // Calculate total votes per candidate
        return allCandidates.stream()
                .map(candidate -> {
                    Long voteCount = voteRepository.countVotesByCandidateId(candidate.getId());
                    long totalVotesForPosition = allVotes.stream()
                            .filter(v -> v.getPosition().equals(candidate.getPosition()))
                            .count();
                    
                    Double percentage = totalVotesForPosition > 0 
                            ? (voteCount.doubleValue() / totalVotesForPosition) * 100 
                            : 0.0;

                    return new VoteResult(
                            candidate.getId(),
                            candidate.getName(),
                            candidate.getParty(),
                            candidate.getPosition(),
                            voteCount,
                            percentage
                    );
                })
                .collect(Collectors.toList());
    }

    public List<VoteResult> getVoteResultsByPosition(String position) {
        List<Candidate> candidates = candidateRepository.findByPosition(position);
        List<Vote> votesForPosition = voteRepository.findByPosition(position);

        long totalVotes = votesForPosition.size();

        return candidates.stream()
                .map(candidate -> {
                    Long voteCount = voteRepository.countVotesByCandidateId(candidate.getId());
                    Double percentage = totalVotes > 0 
                            ? (voteCount.doubleValue() / totalVotes) * 100 
                            : 0.0;

                    return new VoteResult(
                            candidate.getId(),
                            candidate.getName(),
                            candidate.getParty(),
                            candidate.getPosition(),
                            voteCount,
                            percentage
                    );
                })
                .collect(Collectors.toList());
    }

    public long getTotalVotes() {
        return voteRepository.count();
    }

    public long getTotalVoters() {
        return voterRepository.count();
    }
}
