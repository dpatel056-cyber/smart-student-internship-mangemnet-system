IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'CandidateName')
BEGIN
    ALTER TABLE CompanyCertificates ADD CandidateName NVARCHAR(150) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'CandidateCollege')
BEGIN
    ALTER TABLE CompanyCertificates ADD CandidateCollege NVARCHAR(250) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'InternshipRole')
BEGIN
    ALTER TABLE CompanyCertificates ADD InternshipRole NVARCHAR(150) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'Duration')
BEGIN
    ALTER TABLE CompanyCertificates ADD Duration VARCHAR(100) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'Performance')
BEGIN
    ALTER TABLE CompanyCertificates ADD Performance NVARCHAR(100) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyCertificates') AND name = 'SignatoryName')
BEGIN
    ALTER TABLE CompanyCertificates ADD SignatoryName NVARCHAR(150) NULL;
END
