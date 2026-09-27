/* Skills linked to the registered student account. */
IF OBJECT_ID(N'dbo.student_skills', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.student_skills
    (
        SkillId INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_student_skills PRIMARY KEY,
        StudentId INT NOT NULL,
        SkillCategory NVARCHAR(50) NOT NULL,
        SkillName NVARCHAR(150) NOT NULL,
        CreatedDate DATETIME NOT NULL
            CONSTRAINT DF_student_skills_CreatedDate DEFAULT (GETDATE()),
        CONSTRAINT FK_student_skills_s_registration
            FOREIGN KEY (StudentId)
            REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END;
GO
