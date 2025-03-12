package com.example.demo.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.example.demo.Entity.Queries;

public interface queryrepositoy extends JpaRepository<Queries, Integer>{
    
    
    @Query("SELECT q FROM Queries q WHERE q.userid = :userid")
    List<Queries> findByUserIdCustom(@Param("userid") int userid);  // ✅ Custom JPQL query
    
    @Modifying
    @Query("DELETE FROM Queries q WHERE q.userid = :userId")
    void deleteByUserid(@Param("userId") int userId);
}

