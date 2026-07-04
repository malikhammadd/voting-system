package com.votingapp.controller;

import com.votingapp.model.Candidate;
import com.votingapp.service.VotingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/candidates")
@CrossOrigin(origins = "*")
public class CandidateController {

    @Autowired
    private VotingService votingService;

    @GetMapping
    public ResponseEntity<List<Candidate>> getAllCandidates() {
        return ResponseEntity.ok(votingService.getAllCandidates());
    }

    @GetMapping("/position/{position}")
    public ResponseEntity<List<Candidate>> getCandidatesByPosition(@PathVariable String position) {
        return ResponseEntity.ok(votingService.getCandidatesByPosition(position));
    }

    @GetMapping("/{id}")
    public ResponseEntity<Candidate> getCandidateById(@PathVariable Long id) {
        return ResponseEntity.ok(votingService.getCandidateById(id));
    }
}
