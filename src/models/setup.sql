========================================
-- Organization Table
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
(
    'BrightFuture Builders', 
    'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 
    'info@brightfuturebuilders.org', 
    'brightfuture-logo.png'
),
(
    'GreenHarvest Growers', 
    'An urban farming collective promoting food sustainability and education in local neighborhoods.', 
    'contact@greenharvest.org', 
    'greenharvest-logo.png'
),
(
    'UnityServe Volunteers', 
    'A volunteer coordination group supporting local charities and service initiatives.', 
    'hello@unityserve.org', 
    'unityserve-logo.png'
);

-- ========================================
-- Projects Table
-- ========================================
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    organization_id INTEGER NOT NULL REFERENCES organization(organization_id),
    title VARCHAR(100) NOT NULL,
    description TEXT,
    project_date DATE,
    start_time TIME,
    end_time TIME,
    location VARCHAR(255),
    volunteers_needed INTEGER
);

INSERT INTO projects (organization_id, title, description, project_date, start_time, end_time, location, volunteers_needed)
VALUES
(1, 'Community Garden Build', 'Help us build raised beds...', '2026-04-01', '09:00', '12:00', 'City Park', 10),
(1, 'Community Garden Build', 'Help us build raised beds...', '2026-04-05', '09:00', '12:00', 'City Park', 10),
(1, 'Shelter Painting', 'Refreshing the interior walls...', '2026-04-10', '10:00', '14:00', 'Main Shelter', 8),
(1, 'Park Bench Restoration', 'Sanding and staining benches...', '2026-04-15', '08:00', '11:00', 'Riverside Park', 6),
(1, 'Tutoring Setup', 'Organizing supplies and desks...', '2026-04-20', '13:00', '16:00', 'Library', 5),
(1, 'Playground Safety Check', 'Replacing woodchips...', '2026-04-22', '09:00', '11:00', 'Elm Street Park', 4),
(1, 'Community Garden Build', 'Help us build raised beds for the local...', '2026-04-25', '09:00', '12:00', 'City Park', 10),
(1, 'Shelter Painting', 'Refreshing the interior walls of the do...', '2026-04-28', '10:00', '14:00', 'Main Shelter', 8),
(1, 'First Aid Training', 'Basic first aid certification...', '2026-05-01', '09:00', '12:00', 'Community Center', 20),
(1, 'Wellness Walk', 'Group walk for mental health...', '2026-05-05', '08:00', '10:00', 'City Trail', 30),
(2, 'Reading Buddies', 'Pair with young readers...', '2026-05-08', '14:00', '16:00', 'Public Library', 15),
(2, 'Spring Seed Sowing', 'Planting heirloom tomato and pepper s...', '2026-05-10', '09:00', '12:00', 'Community Garden', 12),
(2, 'Orchard Pruning Workshop', 'Learning to prune fruit trees...', '2026-05-12', '10:00', '13:00', 'Urban Orchard', 8),
(2, 'Irrigation Pipe Repair', 'Fixing leaks in the community garden...', '2026-05-15', '08:00', '11:00', 'Community Garden', 6),
(2, 'Homework Help Club', 'After school tutoring...', '2026-05-18', '15:00', '17:00', 'Library', 10),
(2, 'Mental Health Awareness', 'Community discussion event...', '2026-05-20', '11:00', '13:00', 'Community Center', 25),
(3, 'Senior Tech Support Day', 'Helping local seniors set up video calls...', '2026-05-22', '10:00', '14:00', 'Senior Center', 10),
(3, 'Neighborhood Cleanup', 'Picking up litter...', '2026-05-25', '08:00', '11:00', 'Downtown', 20),
(3, 'Trail Maintenance', 'Clearing and maintaining hiking trails...', '2026-05-28', '09:00', '12:00', 'Nature Reserve', 15),
(3, 'Yoga in the Park', 'Free outdoor yoga session...', '2026-06-01', '07:00', '09:00', 'City Park', 30),
(3, 'Mural Painting', 'Creating a community mural...', '2026-06-05', '10:00', '16:00', 'Community Center', 20);

-- ========================================
-- Category Table
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
-- Project Category Table (junction)
-- ========================================
CREATE TABLE project_category (
    project_id INTEGER NOT NULL REFERENCES projects(project_id),
    category_id INTEGER NOT NULL REFERENCES category(category_id),
    PRIMARY KEY (project_id, category_id)
);

INSERT INTO project_category (project_id, category_id) VALUES
    (16, 3),
    (17, 3),
    (18, 3),
    (19, 1),
    (20, 2),
    (21, 3),
    (22, 3),
    (23, 3),
    (24, 4),
    (25, 4),
    (26, 2),
    (27, 1),
    (28, 1),
    (29, 1),
    (30, 2),
    (31, 4),
    (32, 2),
    (33, 3),
    (34, 1),
    (35, 4),
    (36, 3);

-- ========================================
-- Category Table
-- ========================================
CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(150) NOT NULL
);

INSERT INTO category (name)
VALUES 
    ('Educational'),
    ('Environmental'),
    ('Community Building');

-- ========================================
-- Projects Table
-- ========================================
CREATE TABLE projects (
    project_id SERIAL PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    project_date DATE NOT NULL,
    organization_id INT NOT NULL,
    FOREIGN KEY (organization_id) REFERENCES organization(organization_id)
);

INSERT INTO projects (title, project_date, organization_id)
VALUES 
    ('Park Cleanup', '2026-04-15', 2),
    ('Building Homes', '2026-05-20', 1),
    ('Food Drive', '2026-06-10', 3);