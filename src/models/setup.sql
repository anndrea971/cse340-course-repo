-- ========================================
-- 1. CLEANUP: DROP TABLES IF THEY EXIST
-- ========================================
DROP TABLE IF EXISTS project_category CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS organization CASCADE;

-- ========================================
-- 2. TABLE: ORGANIZATIONS
-- ========================================
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES 
('BrightFuture Builders', 'A nonprofit focused on community infrastructure through sustainable construction.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-- ========================================
-- 3. TABLE: CATEGORIES
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

INSERT INTO category (name) VALUES
('Environmental'), 
('Education'), 
('Community Building'), 
('Health & Wellness'), 
('Food Security');

-- ========================================
-- 4. TABLE: PROJECTS (Exactly 15 Projects)
-- ========================================
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    project_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    location VARCHAR(255),
    volunteers_needed INTEGER
);

INSERT INTO projects (organization_id, title, description, project_date, start_time, end_time, location, volunteers_needed)
VALUES
-- Environmental (Proyectos 1 al 3)
(1, 'Community Garden Build', 'Help us build raised beds for the local area.', '2026-04-01', '09:00', '12:00', 'City Park', 10),
(2, 'Irrigation Pipe Repair', 'Fixing leaks in the community garden irrigation system.', '2026-05-15', '08:00', '11:00', 'Community Garden', 6),
(1, 'River Restoration', 'Cleaning up the riverbank and planting native species.', '2026-06-12', '08:00', '14:00', 'Riverside Park', 15),

-- Education (Proyectos 4 al 6)
(3, 'After-School Tutoring', 'Helping middle school students with math and science homework.', '2026-04-15', '15:00', '17:00', 'Main Library', 5),
(2, 'Urban Farming Class', 'Teaching locals how to start their own balcony gardens.', '2026-05-20', '10:00', '12:00', 'GreenHarvest HQ', 8),
(1, 'STEM Workshop', 'Leading a building workshop for kids.', '2026-06-18', '13:00', '16:00', 'Community Center', 10),

-- Community Building (Proyectos 7 al 9)
(1, 'Shelter Painting', 'Refreshing the interior walls of the downtown shelter.', '2026-04-10', '10:00', '14:00', 'Main Shelter', 8),
(3, 'Neighborhood Cleanup', 'Picking up litter in the downtown business district.', '2026-05-25', '08:00', '11:00', 'Downtown', 20),
(3, 'Mural Painting', 'Creating a community mural at the youth center.', '2026-06-05', '10:00', '16:00', 'Community Center', 20),

-- Health & Wellness (Proyectos 10 al 12)
(1, 'Mental Health Walk', 'A community walk to raise awareness for mental health.', '2026-04-22', '09:00', '11:00', 'City Trail', 30),
(3, 'Yoga in the Park', 'Free outdoor yoga session for beginners.', '2026-06-01', '07:00', '09:00', 'City Park', 15),
(2, 'Senior Wellness Check', 'Delivering care packages to local seniors.', '2026-06-10', '10:00', '13:00', 'Senior Center', 10),

-- Food Security (Proyectos 13 al 15)
(2, 'Spring Seed Sowing', 'Planting heirloom tomato and pepper seeds.', '2026-05-10', '09:00', '12:00', 'Community Garden', 12),
(3, 'Food Bank Sorting', 'Sorting canned goods and preparing donation boxes.', '2026-04-28', '14:00', '18:00', 'Local Food Bank', 15),
(1, 'Soup Kitchen Volunteer', 'Serving hot meals to those in need.', '2026-05-05', '17:00', '20:00', 'Downtown Shelter', 8);

-- ========================================
-- 5. TABLE: UNION (Project Category)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES projects(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

-- Aquí conectamos exactamente 3 proyectos por cada una de las 5 categorías
INSERT INTO project_category (project_id, category_id) VALUES
(1, 1), (2, 1), (3, 1), -- Environmental (Cat 1)
(4, 2), (5, 2), (6, 2), -- Education (Cat 2)
(7, 3), (8, 3), (9, 3), -- Community Building (Cat 3)
(10, 4), (11, 4), (12, 4), -- Health & Wellness (Cat 4)
(13, 5), (14, 5), (15, 5); -- Food Security (Cat 5)