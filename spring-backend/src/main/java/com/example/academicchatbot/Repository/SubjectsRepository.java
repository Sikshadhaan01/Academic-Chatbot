package com.example.academicchatbot.Repository;

import com.example.academicchatbot.Entities.SubjectEntity;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface SubjectsRepository extends JpaRepository<SubjectEntity, Long> {
    @Query(value = "select * from subjects where department=:department and semester=:semester",nativeQuery = true)
    List<SubjectEntity> getSubjectsByDepartmentAndSemester(String department, String semester);
}
