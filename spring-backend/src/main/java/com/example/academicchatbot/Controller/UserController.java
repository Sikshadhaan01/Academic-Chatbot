package com.example.academicchatbot.Controller;

import com.example.academicchatbot.Data.Response;
import com.example.academicchatbot.Entities.UserEntity;
import com.example.academicchatbot.Services.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value = "users")
public class UserController {
    @Autowired
    UserService userService;
    @PostMapping(value = "sign-up")
    public Response signUp(@RequestBody UserEntity insert) {
        String message = userService.signUp(insert);
        if (message.equals("sign up successfully")) {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(200);
            response.setResult(new ArrayList<>());
            return response;
        } else {
            Response response = new Response();
            response.setMessage(message);
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }
    @PostMapping(value = "login-user")
    public Response LogIn(@RequestBody UserEntity login) {
        UserEntity message = userService.LogIn(login);
        if (message != null) {
            Response response = new Response();
            response.setMessage("Login Success");
            response.setStatusCode(200);
            response.setResult(List.of(message));
            return response;
        } else {
            Response response = new Response();
            response.setMessage("Login Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
            return response;
        }
    }
}
