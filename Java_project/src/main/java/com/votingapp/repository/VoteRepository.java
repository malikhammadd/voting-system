package com.votingapp.repository;

import com.votingapp.model.Vote;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Optional;

@Repository
public interface VoteRepository extends JpaRepository<Vote, Long> {
    Optional<Vote> findByVoterIdAndPosition(Long voterId, String position);
    
    @Query("SELECT COUNT(v) FROM Vote v WHERE v.candidate.id = :candidateId")
    Long countVotesByCandidateId(@Param("candidateId") Long candidateId);
    
    @Query("SELECT v FROM Vote v WHERE v.position = :position")
    List<Vote> findByPosition(@Param("position") String position);
}
