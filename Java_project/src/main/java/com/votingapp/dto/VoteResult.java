package com.votingapp.dto;

public class VoteResult {
    private Long candidateId;
    private String candidateName;
    private String party;
    private String position;
    private Long voteCount;
    private Double percentage;

    public VoteResult() {}

    public VoteResult(Long candidateId, String candidateName, String party, String position, Long voteCount, Double percentage) {
        this.candidateId = candidateId;
        this.candidateName = candidateName;
        this.party = party;
        this.position = position;
        this.voteCount = voteCount;
        this.percentage = percentage;
    }

    // Getters and Setters
    public Long getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(Long candidateId) {
        this.candidateId = candidateId;
    }

    public String getCandidateName() {
        return candidateName;
    }

    public void setCandidateName(String candidateName) {
        this.candidateName = candidateName;
    }

    public String getParty() {
        return party;
    }

    public void setParty(String party) {
        this.party = party;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }

    public Long getVoteCount() {
        return voteCount;
    }

    public void setVoteCount(Long voteCount) {
        this.voteCount = voteCount;
    }

    public Double getPercentage() {
        return percentage;
    }

    public void setPercentage(Double percentage) {
        this.percentage = percentage;
    }
}
