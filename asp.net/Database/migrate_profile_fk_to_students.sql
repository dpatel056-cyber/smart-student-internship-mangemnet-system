/* Run this only if the child tables were created with the old s_registration FK. */
IF OBJECT_ID(N'dbo.student_profile', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_profile_s_registration')
        ALTER TABLE dbo.student_profile DROP CONSTRAINT FK_student_profile_s_registration;

    IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_profile_Students')
        ALTER TABLE dbo.student_profile ADD CONSTRAINT FK_student_profile_Students
            FOREIGN KEY (StudentId) REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE ON DELETE CASCADE;
END;
GO

IF OBJECT_ID(N'dbo.student_education', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_education_s_registration')
        ALTER TABLE dbo.student_education DROP CONSTRAINT FK_student_education_s_registration;

    IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_education_Students')
        ALTER TABLE dbo.student_education ADD CONSTRAINT FK_student_education_Students
            FOREIGN KEY (StudentId) REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE ON DELETE CASCADE;
END;
GO

IF OBJECT_ID(N'dbo.student_skills', N'U') IS NOT NULL
BEGIN
    IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_skills_s_registration')
        ALTER TABLE dbo.student_skills DROP CONSTRAINT FK_student_skills_s_registration;

    IF NOT EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = N'FK_student_skills_Students')
        ALTER TABLE dbo.student_skills ADD CONSTRAINT FK_student_skills_Students
            FOREIGN KEY (StudentId) REFERENCES dbo.Students (StudentId)
            ON UPDATE CASCADE ON DELETE CASCADE;
END;
GO
