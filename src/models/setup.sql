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
('Environmental'), ('Education'), ('Community Building'), ('Health & Wellness'), ('Food Security');

-- ========================================
-- 4. TABLE: PROJECTS
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
(1, 'Community Garden Build', 'Help us build raised beds for the local area.', '2026-04-01', '09:00', '12:00', 'City Park', 10),
(1, 'Shelter Painting', 'Refreshing the interior walls of the downtown shelter.', '2026-04-10', '10:00', '14:00', 'Main Shelter', 8),
(2, 'Spring Seed Sowing', 'Planting heirloom tomato and pepper seeds.', '2026-05-10', '09:00', '12:00', 'Community Garden', 12),
(3, 'Neighborhood Cleanup', 'Picking up litter in the downtown business district.', '2026-05-25', '08:00', '11:00', 'Downtown', 20),
(3, 'Mural Painting', 'Creating a community mural at the youth center.', '2026-06-05', '10:00', '16:00', 'Community Center', 20);

-- ========================================
-- 5. TABLE: UNION (Project Category)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES projects(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

INSERT INTO project_category (project_id, category_id) VALUES
(1, 3), (1, 1), -- Garden Build: Community & Environmental
(2, 3),         -- Painting: Community
(3, 1), (3, 5), -- Seed Sowing: Environmental & Food Security
(4, 3), (4, 1), -- Cleanup: Community & Environmental
(5, 3);         -- Mural: Community