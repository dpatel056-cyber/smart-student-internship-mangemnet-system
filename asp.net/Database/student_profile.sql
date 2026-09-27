/* Student profile details linked to the registered student account. */
IF OBJECT_ID(N'dbo.student_profile', N'U') IS NULL
BEGIN
    CREATE TABLE dbo.student_profile
    (
        ProfileId INT IDENTITY(1,1) NOT NULL
            CONSTRAINT PK_student_profile PRIMARY KEY,
        StudentId INT NOT NULL,
        Gender NVARCHAR(20) NULL,
        Address NVARCHAR(500) NULL,
        City NVARCHAR(100) NULL,
        State NVARCHAR(100) NULL,
        Pincode NVARCHAR(20) NULL,
        AboutMe NVARCHAR(MAX) NULL,
        PreferredDomain NVARCHAR(150) NULL,
        PreferredRole NVARCHAR(150) NULL,
        PreferredLocation NVARCHAR(150) NULL,
        WorkMode NVARCHAR(50) NULL,
        Availability NVARCHAR(50) NULL,
        ProfilePhoto NVARCHAR(500) NULL,
        CONSTRAINT UQ_student_profile_StudentId UNIQUE (StudentId),
        CONSTRAINT FK_student_profile_s_registration
            FOREIGN KEY (StudentId)
            REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE
            ON DELETE CASCADE
    );
END;
GO
