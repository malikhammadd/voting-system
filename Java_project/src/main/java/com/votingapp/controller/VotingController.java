package com.votingapp.controller;

import com.votingapp.dto.VoteRequest;
import com.votingapp.dto.VoteResult;
import com.votingapp.model.Vote;
import com.votingapp.service.VotingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/api/voting")
@CrossOrigin(origins = "*")
public class VotingController {

    @Autowired
    private VotingService votingService;

    @PostMapping("/vote")
    public ResponseEntity<?> castVote(@RequestBody VoteRequest voteRequest) {
        try {
            Vote vote = votingService.castVote(voteRequest);
            Map<String, Object> response = new HashMap<>();
            response.put("success", true);
            response.put("message", "Vote cast successfully!");
            response.put("vote", vote);
            return ResponseEntity.ok(response);
        } catch (Exception e) {
            Map<String, Object> response = new HashMap<>();
            response.put("success", false);
            response.put("message", e.getMessage());
            return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(response);
        }
    }

    @GetMapping("/results")
    public ResponseEntity<List<VoteResult>> getResults() {
        return ResponseEntity.ok(votingService.getVoteResults());
    }

    @GetMapping("/results/position/{position}")
    public ResponseEntity<List<VoteResult>> getResultsByPosition(@PathVariable String position) {
        return ResponseEntity.ok(votingService.getVoteResultsByPosition(position));
    }

    @GetMapping("/stats")
    public ResponseEntity<Map<String, Long>> getStats() {
        Map<String, Long> stats = new HashMap<>();
        stats.put("totalVotes", votingService.getTotalVotes());
        stats.put("totalVoters", votingService.getTotalVoters());
        return ResponseEntity.ok(stats);
    }
}
