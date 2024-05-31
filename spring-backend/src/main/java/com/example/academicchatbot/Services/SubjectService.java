package com.example.academicchatbot.Services;

import com.example.academicchatbot.Entities.SubjectEntity;
import com.example.academicchatbot.Repository.SubjectsRepository;
import com.example.academicchatbot.utils.FileUploadUtil;
import com.example.academicchatbot.utils.FindFileUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class SubjectService {
    @Value("${custom.notesDir}")
    private String notesDir;
    @Value("${custom.notesUrl}")
    private String notesUrl;
    @Autowired
    SubjectsRepository subjectsRepository;
    public List<SubjectEntity> getSubjects(String department, String semester) {
        return subjectsRepository.getSubjectsByDepartmentAndSemester(department,semester);
    }
    public String uploadNote(MultipartFile pdf, String department,String semester,String subject) throws IOException {
        System.out.println("Content Type : "+pdf.getContentType());
        String	fileName = StringUtils.cleanPath(pdf.getOriginalFilename()+pdf.getContentType().replace("application/octet-stream", ""));
        String uploadDir = notesDir+'/'+department+'/'+semester+'/'+subject;
        FileUploadUtil.saveFile(uploadDir, fileName, pdf);
        String fullPath =notesUrl+'/'+department+'/'+semester+'/'+subject+'/'+fileName;
        return fullPath;
    }

    public List<String> fetchAllNotes(String department, String semester, String subject){
        try {
            String folderPath =  notesDir+'/'+department+'/'+semester+'/'+subject;
            Path path = Paths.get(folderPath);
            if (Files.exists(path) && Files.isDirectory(path)) {
                return Files.list(path)
                        .filter(Files::isRegularFile)
                        .map(Path::getFileName).map((i)->notesUrl+'/'+department+'/'+semester+'/'+subject+'/'+i)
                        .collect(Collectors.toList());
            } else {
                return List.of();
//                throw new RuntimeException("Folder path is invalid or not a directory");
            }
        } catch (Exception e) {
            throw new RuntimeException("Error fetching files", e);
        }

    }

    public Boolean deleteNote(String department, String semester, String subject, String filename) throws IOException {
        String filePath =  notesDir+'/'+department+'/'+semester+'/'+subject;
        Path path = Paths.get(filePath);
        Path foundFile =  FindFileUtil.getFilePath(filename, path);
        assert foundFile != null;
        return Files.deleteIfExists(foundFile);
    }
}
