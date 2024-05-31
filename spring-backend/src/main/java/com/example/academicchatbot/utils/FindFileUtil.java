package com.example.academicchatbot.utils;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;

public class FindFileUtil {
    private static Path filePath;
	  public static Path getFilePath(String fileCode, Path dirPath) throws IOException {
	        
	         
	        Files.list(dirPath).forEach(file -> {
	            if (file.getFileName().toString().startsWith(fileCode)) {
	                filePath = file.toAbsolutePath();
	                System.out.println("filePath: "+ filePath);
	                return;
	            }
	        });
	 
	        if (filePath != null) {
	            return filePath;
	        }
	         
	        return null;
	    }
	}


