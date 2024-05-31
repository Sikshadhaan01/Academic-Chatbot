package com.example.academicchatbot.Services;

import com.example.academicchatbot.Entities.UserEntity;
import com.example.academicchatbot.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserService {
    @Autowired
    UserRepository userRepository;
    public String signUp(UserEntity insert) {
        List<UserEntity> existingUser = userRepository.findUserByName(insert.getUserName());
        if (existingUser.isEmpty()) {
            insert.setUserRole("student");
            userRepository.save(insert);
            return ("sign up successfully");
        } else {
            return ("User already exist");
        }
    }
    public UserEntity LogIn(UserEntity login) {
        UserEntity foundUser =userRepository.login(login.getEmail(), login.getPassword());
        if (foundUser != null) {
            return foundUser;
        } else {
            return null;
        }
    }
}
