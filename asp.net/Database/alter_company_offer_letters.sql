IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyOfferLetters') AND name = 'Duration')
BEGIN
    ALTER TABLE CompanyOfferLetters ADD Duration VARCHAR(50) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyOfferLetters') AND name = 'WorkLocation')
BEGIN
    ALTER TABLE CompanyOfferLetters ADD WorkLocation NVARCHAR(200) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyOfferLetters') AND name = 'ValidTill')
BEGIN
    ALTER TABLE CompanyOfferLetters ADD ValidTill VARCHAR(50) NULL;
END

IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('CompanyOfferLetters') AND name = 'AdditionalNotes')
BEGIN
    ALTER TABLE CompanyOfferLetters ADD AdditionalNotes NVARCHAR(MAX) NULL;
END
