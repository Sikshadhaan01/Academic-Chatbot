package com.example.academicchatbot.Entities;

import lombok.*;
import org.hibernate.annotations.CreationTimestamp;

import javax.persistence.*;
import java.util.Date;

@Getter
@Setter
@Builder
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "announcement")
public class StoryEntity {
    @Id
    @Column(name = "id")
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;
    @Column(name = "story_image_path")
    private String storyImagePath;
    @Column(name = "user_name")
    private String userName;
    @Column(name = "user_id")
    private Long userId;
    @Column(name = "created_on", insertable = false, updatable = false)
    @CreationTimestamp
    @Temporal(TemporalType.TIMESTAMP)
    private Date createdOn;
}
