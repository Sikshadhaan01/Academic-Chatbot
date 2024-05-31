package com.example.academicchatbot.Controller;

import com.example.academicchatbot.Data.Response;
import com.example.academicchatbot.Entities.SubjectEntity;
import com.example.academicchatbot.Services.SubjectService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@RestController
@CrossOrigin
@RequestMapping(value = "subjects")
public class SubjectController {
    @Autowired
    SubjectService subjectService;

    @PostMapping(value = "get-subjects/{department}/{semester}")
    public Response getSubject(@PathVariable String department, @PathVariable String semester) {
        List<SubjectEntity> message = subjectService.getSubjects(department, semester);
        Response response = new Response();
        if (message != null) {
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(message);
        } else {
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
        }
        return response;
    }

    @PostMapping(value = "upload-note")
    public Response uploadNote(@RequestParam("file") MultipartFile file, @RequestParam("department") String department,
                               @RequestParam("semester") String semester, @RequestParam("subject") String subject) throws IOException {
        String filePath = subjectService.uploadNote(file, department, semester, subject);
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

    @PostMapping(value = "fetch-all-notes/{department}/{semester}/{subject}")
    public Response fetchAllNotes(@PathVariable String department, @PathVariable String semester,@PathVariable String subject) {
        List<String> message = subjectService.fetchAllNotes(department, semester,subject);
        Response response = new Response();
        if (message != null) {
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(message);
        } else {
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
        }
        return response;
    }

    @PostMapping(value = "delete-note/{department}/{semester}/{subject}/{filename}")
    public Response deleteNote(@PathVariable String department, @PathVariable String semester,@PathVariable String subject, @PathVariable String filename) throws IOException {
        boolean message = subjectService.deleteNote(department, semester,subject, filename);
        Response response = new Response();
        if (message) {
            response.setMessage("Success");
            response.setStatusCode(200);
            response.setResult(List.of());
        } else {
            response.setMessage("Failed");
            response.setStatusCode(400);
            response.setResult(new ArrayList<>());
        }
        return response;
    }
}
