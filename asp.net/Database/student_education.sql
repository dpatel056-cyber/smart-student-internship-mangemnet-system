/* Education records linked to the registered student account. */
IF OBJECT_ID(N'dbo.student_education', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.student_education
    (
        EducationId INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_student_education PRIMARY KEY,
        StudentId INT NOT NULL,
        EducationType NVARCHAR(100) NULL,
        CollegeName NVARCHAR(200) NULL,
        Course NVARCHAR(150) NULL,
        Department NVARCHAR(150) NULL,
        CurrentYear NVARCHAR(50) NULL,
        Semester NVARCHAR(50) NULL,
        CGPA DECIMAL(5,2) NULL,
        GraduationYear INT NULL,
        Location NVARCHAR(150) NULL,
        CONSTRAINT FK_student_education_s_registration
            FOREIGN KEY (StudentId)
            REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END;
GO
