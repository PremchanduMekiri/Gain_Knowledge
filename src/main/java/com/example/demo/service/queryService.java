package com.example.demo.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.demo.Entity.Queries;
import com.example.demo.repository.queryrepositoy;

@Service
public class queryService {
    
    @Autowired
    private queryrepositoy rQueryrepositoy;
    
    
    @Transactional
    public void saveQuery(Queries query) {  // Fixed method name
        rQueryrepositoy.save(query);
    }

    public List<Queries> getUserQueries(int userId) {
        return rQueryrepositoy.findByUserIdCustom(userId);
    }

    public List<Queries> getAllQueries() {
        return rQueryrepositoy.findAll();
    }

    @Transactional
    public void updateQueryReply(int queryId, String reply) {
        Queries query = rQueryrepositoy.findById(queryId).orElse(null);
        if (query != null) {
            query.setReply(reply);
            rQueryrepositoy.save(query);
        }
    }
    @Transactional
    public void clearUserQueries(int userId) {
        rQueryrepositoy.deleteByUserid(userId);
    }
    
    @Transactional
    public void clearAllQueries() {
        rQueryrepositoy.deleteAll(); // Clears all chat for admin
    }

}
