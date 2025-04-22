-- 1. countries
CREATE TABLE countries (
                           id INT PRIMARY KEY AUTO_INCREMENT,
                           name VARCHAR(100) UNIQUE NOT NULL
);

-- 2. universities
CREATE TABLE universities (
                              id INT PRIMARY KEY AUTO_INCREMENT,
                              name VARCHAR(255) UNIQUE NOT NULL
);

-- 3. education_levels
CREATE TABLE education_levels (
                                  id INT PRIMARY KEY AUTO_INCREMENT,
                                  name VARCHAR(50) UNIQUE NOT NULL
);

-- 4. keywords
CREATE TABLE keywords (
                          id INT PRIMARY KEY AUTO_INCREMENT,
                          word VARCHAR(100) UNIQUE NOT NULL
);

-- 5. work_levels
CREATE TABLE work_levels (
                             id INT PRIMARY KEY AUTO_INCREMENT,
                             name VARCHAR(100) UNIQUE NOT NULL
);

-- 6. authors
CREATE TABLE authors (
                         id INT PRIMARY KEY,
                         name VARCHAR(100),
                         university_id INT,
                         email VARCHAR(100),
                         orcid VARCHAR(20),
                         country_id INT,
                         education_id INT,
                         FOREIGN KEY (university_id) REFERENCES universities(id),
                         FOREIGN KEY (country_id) REFERENCES countries(id),
                         FOREIGN KEY (education_id) REFERENCES education_levels(id)
);

-- 7. reviewers
CREATE TABLE reviewers (
                           id INT PRIMARY KEY,
                           name VARCHAR(100),
                           affiliation VARCHAR(255),
                           email VARCHAR(100),
                           orcid VARCHAR(20),
                           country VARCHAR(100),
                           education VARCHAR(50)
);

-- 8. works
CREATE TABLE works (
                       id INT PRIMARY KEY,
                       title TEXT,
                       subject VARCHAR(100),
                       timeline_start DATE,
                       timeline_end DATE,
                       pages INT,
                       work_level_id INT,
                       file_url TEXT,
                       FOREIGN KEY (work_level_id) REFERENCES work_levels(id)
);

-- 9. authorship (many-to-many: works ↔ authors)
CREATE TABLE authorship (
                            work_id INT,
                            author_id INT,
                            PRIMARY KEY (work_id, author_id),
                            FOREIGN KEY (work_id) REFERENCES works(id),
                            FOREIGN KEY (author_id) REFERENCES authors(id)
);

-- 10. author_keywords (many-to-many: authors ↔ keywords)
CREATE TABLE author_keywords (
                                 author_id INT,
                                 keyword_id INT,
                                 PRIMARY KEY (author_id, keyword_id),
                                 FOREIGN KEY (author_id) REFERENCES authors(id),
                                 FOREIGN KEY (keyword_id) REFERENCES keywords(id)
);

-- 11. reviews (reviewers ↔ works)
CREATE TABLE reviews (
                         work_id INT,
                         reviewer_id INT,
                         review TEXT,
                         PRIMARY KEY (work_id, reviewer_id),
                         FOREIGN KEY (work_id) REFERENCES works(id),
                         FOREIGN KEY (reviewer_id) REFERENCES reviewers(id)
);

-- 12. citations (self-linking works)
CREATE TABLE citations (
                           citing_work_id INT,
                           cited_work_id INT,
                           PRIMARY KEY (citing_work_id, cited_work_id),
                           FOREIGN KEY (citing_work_id) REFERENCES works(id),
                           FOREIGN KEY (cited_work_id) REFERENCES works(id)
);

-- 13. areas
CREATE TABLE areas (
                       id INT PRIMARY KEY,
                       name VARCHAR(100)
);

-- 14. paper_area (many-to-many: works ↔ areas)
CREATE TABLE paper_area (
                            paper_id INT,
                            area_id INT,
                            PRIMARY KEY (paper_id, area_id),
                            FOREIGN KEY (paper_id) REFERENCES works(id),
                            FOREIGN KEY (area_id) REFERENCES areas(id)
);

-- 15. organizations
CREATE TABLE organizations (
                               id INT PRIMARY KEY,
                               name VARCHAR(255),
                               country VARCHAR(100),
                               email VARCHAR(100),
                               website TEXT
);

-- 16. grants (organizations ↔ works)
CREATE TABLE grants (
                        id INT PRIMARY KEY,
                        organization_id INT,
                        work_id INT,
                        amount DECIMAL(12, 2),
                        currency VARCHAR(10),
                        FOREIGN KEY (organization_id) REFERENCES organizations(id),
                        FOREIGN KEY (work_id) REFERENCES works(id)
);
