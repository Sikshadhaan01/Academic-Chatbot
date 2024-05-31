package com.example.academicchatbot.Services;

import com.example.academicchatbot.Entities.StoryEntity;
import com.example.academicchatbot.Repository.StoryRepository;
import com.example.academicchatbot.utils.FileUploadUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.ZonedDateTime;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.io.IOException;
import java.time.temporal.ChronoUnit;
import java.util.Date;
import  java.util.List;
import java.util.stream.Collectors;

@Service
public class StoryService {
    @Autowired
    StoryRepository storyRepository;
    @Value("${custom.announcementDir}")
    private String announcementDir;
    @Value("${custom.announcementUrl}")
    private String announcementUrl;
    public StoryEntity uploadAnnouncement(MultipartFile file, String userName, Long userId) throws IOException {
        String	fileName = StringUtils.cleanPath(file.getOriginalFilename()+file.getContentType().replace("application/octet-stream",".jpg"));
        System.out.println("File Name : "+fileName);
        System.out.println("Tyoe : "+file.getContentType());
        String uploadDir = announcementDir;
        FileUploadUtil.saveFile(uploadDir, fileName, file);
        String fullPath =announcementUrl+'/'+fileName;
        System.out.println("Full Path : "+fullPath);
        StoryEntity entity = StoryEntity.builder()
                .storyImagePath(fullPath)
                .userName(userName)
                .userId(userId)
                .build();
        storyRepository.save(entity);
        return entity;
    }

    public List<StoryEntity> getAllAnnouncements() throws ParseException {
        LocalDateTime startTime = LocalDateTime.now().minusHours(24);
//        Date startTime = new Date(new Date().getTime() - 24 * 60 * 60 * 1000);

        return storyRepository.findAllCreatedWithinLast24Hours(startTime);
    }

    public List<StoryEntity> getAll() throws ParseException {
        List<StoryEntity> entities = storyRepository.findAll();
        LocalDateTime now = LocalDateTime.now();

        // Filter entities created within the last 24 hours
        List<StoryEntity> filteredEntities = entities.stream()
                .filter(entity -> {
                    LocalDateTime createdOn = convertToLocalDateTimeViaInstant(entity.getCreatedOn());
                    System.out.println(ChronoUnit.HOURS.between(createdOn, now) <= 24L);
                    return ChronoUnit.HOURS.between(createdOn, now) <= 24;
                })
                .collect(Collectors.toList());
        return filteredEntities;
    }
    public static LocalDateTime convertToLocalDateTimeViaInstant(Date dateToConvert) {
        return dateToConvert.toInstant()
                .atZone(ZoneId.systemDefault())
                .toLocalDateTime();
    }
    public static String convertDateTime(String inputDateTime) {
        // Define the input and output date-time formats
        DateTimeFormatter inputFormatter = DateTimeFormatter.ofPattern("EEE MMM dd HH:mm:ss z yyyy");
        DateTimeFormatter outputFormatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");

        try {
            // Parse the input date-time string to a ZonedDateTime
            ZonedDateTime zonedDateTime = ZonedDateTime.parse(inputDateTime, inputFormatter);

            // Convert ZonedDateTime to LocalDateTime
            LocalDateTime localDateTime = zonedDateTime.toLocalDateTime();

            // Format LocalDateTime to the desired output format
            return localDateTime.format(outputFormatter);
        } catch (DateTimeParseException e) {
            e.printStackTrace();
            return null; // or handle the error as needed
        }
    }

    public void deleteAnnouncement(String id) {
       storyRepository.deleteById(Long.parseLong(id));
    }
}
