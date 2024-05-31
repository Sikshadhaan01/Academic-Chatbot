package com.example.academicchatbot.Controller;

import com.example.academicchatbot.Data.Response;
import com.example.academicchatbot.Entities.StoryEntity;
import com.example.academicchatbot.Services.StoryService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value = "announcement")
public class StoryController {
    @Autowired
    StoryService storyService;
    @PostMapping(value = "upload-announcement")
    public Response uploadNote(@RequestParam("file") MultipartFile file, @RequestParam("userName") String userName, @RequestParam("userId") Long userId) throws IOException {
        StoryEntity filePath = storyService.uploadAnnouncement(file,userName, userId);
        Response response = new Response();
        if (filePath != null) {
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(List.of(filePath));
        } else {
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
        }
        return response;
    }

    @PostMapping(value = "delete-announcement/{id}")
    public Response deleteAnnouncement(@PathVariable String id) throws IOException {
        Response response = new Response();
        try {
            storyService.deleteAnnouncement(id);
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(List.of());
            return response;
        }catch (Exception e){
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(List.of());
            return response;
        }
    }

    @PostMapping(value = "get-all-announcement")
    public Response getAllAnnouncements() throws IOException, ParseException {
        List<StoryEntity> announcements = storyService.getAll();
        Response response = new Response();
        if (announcements != null) {
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(announcements);
        } else {
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
        }
        return response;
    }
}
