-- Uyeler Tablosu
CREATE TABLE Members (
    member_id SERIAL PRIMARY KEY,                           -- Birincil Anahtar 
    username VARCHAR(50) UNIQUE NOT NULL,                 -- Kullanici adi, Benzersiz olmali
    email VARCHAR(100) UNIQUE NOT NULL,                  -- E-posta adresi, Benzersiz olmali
    password VARCHAR(255) NOT NULL,                      -- Sifre 
    registration_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Kayit tarihi
    first_name VARCHAR(50),                              -- Ad
    last_name VARCHAR(50)                                -- Soyad
);

-- Kategoriler Tablosu
CREATE TABLE Categories (
    category_id SERIAL PRIMARY KEY,         -- Birincil Anahtar 
    category_name VARCHAR(100) NOT NULL      -- Kategori adi (örneğin, yapay zeka, blokzincir) 
);

-- Egitimler Tablosu
CREATE TABLE Courses (
    course_id SERIAL PRIMARY KEY,           -- Birincil Anahtar 
    name VARCHAR(200) NOT NULL,           -- Egitim adi 
    description TEXT,                       -- Egitim aciklamasi 
    start_date DATE,                        -- Baslangic tarihi
    end_date DATE,                          -- Bitis tarihi 
    instructor VARCHAR(100),                -- Egitmen bilgisi 
    category_id INT,                        -- Kategoriler tablosuna Yabanci Anahtar 
    FOREIGN KEY (category_id) REFERENCES Categories(category_id) -- Kategori iliskisi 
);

-- Katilimlar Tablosu (Uyeler ve Egitimler arasinda Iliski)
CREATE TABLE Enrollments (
    enrollment_id SERIAL PRIMARY KEY,         -- Birincil Anahtar 
    member_id INT NOT NULL,                   -- Uyeler tablosuna Yabanci Anahtar 
    course_id INT NOT NULL,                   -- Egitimler tablosuna Yabanci Anahtar 
    enrollment_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Katilim tarihi (istege bagli) 
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id),
    UNIQUE (member_id, course_id)             -- Bir üyenin ayni egitime tekrar kaydolmasini onler
);

-- Sertifikalar Tablosu
CREATE TABLE Certificates (
    certificate_id SERIAL PRIMARY KEY,           -- Birincil Anahtar 
    certificate_code VARCHAR(100) UNIQUE NOT NULL, -- Sertifika kodu, Benzersiz olmali
    issue_date DATE NOT NULL                    -- Verilis tarihi 
);

-- Sertifika Atamalari Tablosu (Üyeler ve Sertifikalar arasinda Iliski)
CREATE TABLE CertificateAssignments (
    assignment_id SERIAL PRIMARY KEY,      -- Birincil Anahtar 
    member_id INT NOT NULL,                -- Üyeler tablosuna Yabanci Anahtar 
    certificate_id INT NOT NULL,           -- Sertifikalar tablosuna Yabanci Anahtar 
    assignment_date DATE DEFAULT CURRENT_DATE, -- Sertifikanin alindigi tarih 
    FOREIGN KEY (member_id) REFERENCES Members(member_id),
    FOREIGN KEY (certificate_id) REFERENCES Certificates(certificate_id),
    UNIQUE (member_id, certificate_id)     -- Bir üyenin ayni sertifikayi birden fazla almasini onler
);

-- Blog Gonderileri Tablosu
CREATE TABLE BlogPosts (
    post_id SERIAL PRIMARY KEY,               -- Birincil Anahtar (Otomatik Artan Tamsayi) 
    title VARCHAR(255) NOT NULL,            -- Gonderi başligi 
    content TEXT,                           -- Gonderi icerigi 
    publication_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP, -- Yayin tarihi 
    author_id INT NOT NULL,                 -- Uyeler tablosuna Yabanci Anahtar (yazar bilgisi)
    FOREIGN KEY (author_id) REFERENCES Members(member_id)
);
