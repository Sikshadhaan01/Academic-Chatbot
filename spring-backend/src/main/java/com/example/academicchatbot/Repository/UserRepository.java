package com.example.academicchatbot.Repository;

import com.example.academicchatbot.Entities.UserEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;

public interface UserRepository extends JpaRepository<UserEntity, Long> {
    @Query(value = "select * from user where username=:userName", nativeQuery = true)
    List<UserEntity> findUserByName(String userName);
    @Query(value = "select * from user where email=:email and password=:pass", nativeQuery = true)
    UserEntity login(String email, String pass);
}
