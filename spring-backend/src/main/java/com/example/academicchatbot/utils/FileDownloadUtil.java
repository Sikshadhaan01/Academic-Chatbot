package com.example.academicchatbot.utils;

import org.springframework.core.io.Resource;
import org.springframework.core.io.UrlResource;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
 
public class FileDownloadUtil {
    private Path foundFile;

     
    public Resource getFileAsResource(String fileCode, Path dirPath) throws IOException {
         
        Files.list(dirPath).forEach(file -> {
            if (file.getFileName().toString().startsWith(fileCode)) {
                foundFile = file;
                System.out.println("foundFile: "+ foundFile);
                return;
            }
        });
 
        if (foundFile != null) {
            return new UrlResource(foundFile.toUri());
        }
         
        return null;
    }
    
  
}
