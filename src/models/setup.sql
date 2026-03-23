-- 1. DROP existing tables to start fresh (Important for Render!)
DROP TABLE IF EXISTS project_category CASCADE;
DROP TABLE IF EXISTS projects CASCADE;
DROP TABLE IF EXISTS category CASCADE;
DROP TABLE IF EXISTS organization CASCADE;

-- 2. Create Organization Table
CREATE TABLE organization (
    organization_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL,
    description TEXT NOT NULL,
    contact_email VARCHAR(255) NOT NULL,
    logo_filename VARCHAR(255) NOT NULL
);

-- 3. Create Category Table
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL UNIQUE
);

-- 4. Create Projects Table (Using project_date)
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(255) NOT NULL,
    description TEXT,
    project_date DATE NOT NULL,
    start_time TIME,
    end_time TIME,
    location VARCHAR(255),
    volunteers_needed INTEGER
);

-- 5. Create Junction Table
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES projects(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

-- 6. Insert Organizations
INSERT INTO organization (name, description, contact_email, logo_filename)
VALUES 
('BrightFuture Builders', 'Nonprofit for infrastructure.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'Urban farming collective.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'Volunteer coordination group.', 'hello@unityserve.org', 'unityserve-logo.png');

-- 7. Insert Categories
INSERT INTO category (name) VALUES
('Environmental'), ('Education'), ('Community Building'), ('Health & Wellness'), ('Food Security');

-- 8. Insert Projects (Make sure organization_id matches your organization table)
INSERT INTO projects (organization_id, title, description, project_date, location)
VALUES
(1, 'Community Garden Build', 'Help build beds.', '2026-04-01', 'City Park'),
(2, 'Spring Seed Sowing', 'Planting peppers.', '2026-05-10', 'Community Garden'),
(3, 'Neighborhood Cleanup', 'Picking up litter.', '2026-05-25', 'Downtown');