package com.example.demo.Entity;

import jakarta.persistence.Entity;
import jakarta.persistence.GeneratedValue;
import jakarta.persistence.GenerationType;
import jakarta.persistence.Id;
import jakarta.persistence.SequenceGenerator;
import lombok.Data;

@Entity
@Data
public class Queries {
    
    @SequenceGenerator(name = "seq_generator", sequenceName = "prem", allocationSize = 1,initialValue = 1021)
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "seq_generator")
    @Id
    private int id;
    private int userid;
    private String query;
    private String  reply;

}
