package com.votingapp.dto;

public class VoteRequest {
    private String voterName;
    private String email;
    private String cnic;
    private Long candidateId;
    private String position;

    // Constructors
    public VoteRequest() {}

    public VoteRequest(String voterName, String email, String cnic, Long candidateId, String position) {
        this.voterName = voterName;
        this.email = email;
        this.cnic = cnic;
        this.candidateId = candidateId;
        this.position = position;
    }

    // Getters and Setters
    public String getVoterName() {
        return voterName;
    }

    public void setVoterName(String voterName) {
        this.voterName = voterName;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getCnic() {
        return cnic;
    }

    public void setCnic(String cnic) {
        this.cnic = cnic;
    }

    public Long getCandidateId() {
        return candidateId;
    }

    public void setCandidateId(Long candidateId) {
        this.candidateId = candidateId;
    }

    public String getPosition() {
        return position;
    }

    public void setPosition(String position) {
        this.position = position;
    }
}
