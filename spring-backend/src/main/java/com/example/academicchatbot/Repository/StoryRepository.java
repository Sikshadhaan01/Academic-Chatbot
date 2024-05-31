package com.example.academicchatbot.Repository;

import com.example.academicchatbot.Entities.StoryEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public interface StoryRepository extends JpaRepository<StoryEntity, Long> {
    @Query(value = "SELECT * FROM announcement  WHERE created_on >:startTime", nativeQuery = true)
    List<StoryEntity> findAllCreatedWithinLast24Hours(LocalDateTime startTime);
}
