-----------------------------------------------
-- Drop tables in dependency order (children first)
-----------------------------------------------

DROP TABLE IF EXISTS public.project_category CASCADE;
DROP TABLE IF EXISTS public.project CASCADE;
DROP TABLE IF EXISTS public.organization CASCADE;
DROP TABLE IF EXISTS public.category CASCADE;

DROP SEQUENCE IF EXISTS organization_id_seq CASCADE;
DROP SEQUENCE IF EXISTS project_id_seq CASCADE;
DROP SEQUENCE IF EXISTS category_id_seq CASCADE;

-----------------------------------------------
-- Organization
-----------------------------------------------

CREATE SEQUENCE organization_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.organization
(
    organization_id integer                                         NOT NULL DEFAULT nextval('organization_id_seq'::regclass),
    name            character varying(150) COLLATE pg_catalog."default" NOT NULL,
    description     text COLLATE pg_catalog."default"                   NOT NULL,
    contact_email   character varying(255) COLLATE pg_catalog."default" NOT NULL,
    logo_filename   character varying(255) COLLATE pg_catalog."default" NOT NULL,
    PRIMARY KEY (organization_id)
);

-----------------------------------------------
-- Category
-----------------------------------------------

CREATE SEQUENCE category_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.category
(
    category_id integer                NOT NULL DEFAULT nextval('category_id_seq'::regclass),
    name        character varying(150) NOT NULL,
    description character varying(255),
    PRIMARY KEY (category_id)
);

-----------------------------------------------
-- Project
-----------------------------------------------

CREATE SEQUENCE project_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;

CREATE TABLE public.project
(
    project_id      integer                NOT NULL DEFAULT nextval('project_id_seq'::regclass),
    organization_id integer                NOT NULL REFERENCES public.organization (organization_id),
    title           character varying(255) NOT NULL,
    description     character varying(255),
    location        character varying(255),
    start_date      date,
    PRIMARY KEY (project_id)
);

-----------------------------------------------
-- Project_Category (join table for many-to-many)
-----------------------------------------------

CREATE TABLE public.project_category
(
    project_id  integer NOT NULL,
    category_id integer NOT NULL,
    PRIMARY KEY (project_id, category_id)
);

-----------------------------------------------
-- Foreign Keys
-----------------------------------------------

ALTER TABLE public.project_category
    ADD FOREIGN KEY (project_id)
        REFERENCES public.project (project_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

ALTER TABLE public.project_category
    ADD FOREIGN KEY (category_id)
        REFERENCES public.category (category_id) MATCH SIMPLE
        ON UPDATE NO ACTION
        ON DELETE NO ACTION;

-----------------------------------------------
-- Data: Organizations
-----------------------------------------------

INSERT INTO public.organization (name, description, contact_email, logo_filename) VALUES 
('BrightFuture Builders', 'A nonprofit focused on improving community infrastructure through sustainable construction projects.', 'info@brightfuturebuilders.org', 'brightfuture-logo.png'),
('GreenHarvest Growers', 'An urban farming collective promoting food sustainability and education in local neighborhoods.', 'contact@greenharvest.org', 'greenharvest-logo.png'),
('UnityServe Volunteers', 'A volunteer coordination group supporting local charities and service initiatives.', 'hello@unityserve.org', 'unityserve-logo.png');

-----------------------------------------------
-- Data: Categories
-----------------------------------------------

INSERT INTO public.category (category_id, name, description) VALUES 
(DEFAULT, 'Environmental', 'Park cleanups, tree planting, trail maintenance, recycling drives'),
(DEFAULT, 'Hunger & Food Security', 'Food bank sorting, meal preparation, community garden work'),
(DEFAULT, 'Housing & Shelter', 'Habitat for Humanity builds, homeless shelter volunteering, home repair for elderly residents'),
(DEFAULT, 'Education & Literacy', 'Tutoring, school supply drives, library volunteering, reading programs'),
(DEFAULT, 'Health & Wellness', 'Blood drives, hospital volunteering, mental health awareness campaigns, free clinic support'),
(DEFAULT, 'Animal Welfare', 'Shelter volunteering, fostering, pet supply drives, wildlife habitat restoration'),
(DEFAULT, 'Elder Care', 'Nursing home visits, errand assistance, technology tutoring for seniors, companionship programs'),
(DEFAULT, 'Youth & Mentoring', 'After-school programs, Big Brothers/Big Sisters, coaching, career mentoring'),
(DEFAULT, 'Disaster Relief', 'Emergency supply collection, rebuilding efforts, first aid training, preparedness kits'),
(DEFAULT, 'Community Development', 'Neighborhood beautification, civic engagement drives, clothing drives, free legal or tax prep clinics');

-----------------------------------------------
-- Data: Projects (De-duplicated)
-----------------------------------------------

INSERT INTO public.project (project_id, organization_id, title, description, location, start_date) VALUES 
(DEFAULT, 1, 'Park Cleanup Day', 'Join us for a day of cleaning and beautifying our local park.', 'Central Park', '2024-07-15'),
(DEFAULT, 2, 'Food Bank Sorting', 'Help us sort and organize donations at the local food bank.', 'City Food Bank', '2024-07-20'),
(DEFAULT, 3, 'Habitat for Humanity Build', 'Working with local volunteers to create a sustainable community space.', 'Habitat for Humanity', '2024-07-25'),
(DEFAULT, 1, 'Community Garden Build', 'Help us build raised beds for the local community garden.', 'City Park', '2026-04-01'),
(DEFAULT, 1, 'Shelter Painting', 'Refreshing the interior walls of the downtown shelter.', 'Main Shelter', '2026-04-10'),
(DEFAULT, 1, 'Park Bench Restoration', 'Sanding and staining benches to revitalize the park.', 'Riverside Park', '2026-04-15'),
(DEFAULT, 1, 'Tutoring Setup', 'Organizing supplies and desks for the after-school program.', 'Library', '2026-04-20'),
(DEFAULT, 1, 'Playground Safety Check', 'Replacing woodchips and checking equipment safety.', 'Elm Street Park', '2026-04-22'),
(DEFAULT, 1, 'First Aid Training', 'Basic first aid certification for community volunteers.', 'Community Center', '2026-05-01'),
(DEFAULT, 1, 'Wellness Walk', 'Group walk to promote physical and mental health.', 'City Trail', '2026-05-05'),
(DEFAULT, 2, 'Reading Buddies', 'Pair with young readers to improve literacy skills.', 'Public Library', '2026-05-08'),
(DEFAULT, 2, 'Spring Seed Sowing', 'Planting heirloom tomato and pepper seeds.', 'Community Garden', '2026-05-10'),
(DEFAULT, 2, 'Orchard Pruning Workshop', 'Learning to prune fruit trees for better yield.', 'Urban Orchard', '2026-05-12'),
(DEFAULT, 2, 'Irrigation Pipe Repair', 'Fixing leaks in the community garden water system.', 'Community Garden', '2026-05-15'),
(DEFAULT, 2, 'Homework Help Club', 'After school tutoring for middle school students.', 'Library', '2026-05-18'),
(DEFAULT, 2, 'Mental Health Awareness', 'Community discussion event and resource sharing.', 'Community Center', '2026-05-20'),
(DEFAULT, 3, 'Senior Tech Support Day', 'Helping local seniors set up video calls and devices.', 'Senior Center', '2026-05-22'),
(DEFAULT, 3, 'Neighborhood Cleanup', 'Picking up litter in the downtown area.', 'Downtown', '2026-05-25'),
(DEFAULT, 3, 'Trail Maintenance', 'Clearing and maintaining hiking trails.', 'Nature Reserve', '2026-05-28'),
(DEFAULT, 3, 'Yoga in the Park', 'Free outdoor yoga session for all skill levels.', 'City Park', '2026-06-01'),
(DEFAULT, 3, 'Mural Painting', 'Creating a community mural to beautify the center.', 'Community Center', '2026-06-05');

-----------------------------------------------
-- Data: Project_Category Mapping
-----------------------------------------------

INSERT INTO public.project_category (project_id, category_id) VALUES 
(1, 1),   -- Park Cleanup -> Environmental
(1, 10),  -- Park Cleanup -> Community Development
(2, 2),   -- Food Bank Sorting -> Hunger & Food Security
(3, 3),   -- Habitat Build -> Housing & Shelter
(4, 10),  -- Community Garden Build -> Community Development
(5, 3),   -- Shelter Painting -> Housing & Shelter
(6, 1),   -- Park Bench Restoration -> Environmental
(7, 4),   -- Tutoring Setup -> Education & Literacy
(8, 10),  -- Playground Safety Check -> Community Development
(9, 5),   -- First Aid Training -> Health & Wellness
(10, 5),  -- Wellness Walk -> Health & Wellness
(11, 4),  -- Reading Buddies -> Education & Literacy
(12, 1),  -- Spring Seed Sowing -> Environmental
(13, 1),  -- Orchard Pruning Workshop -> Environmental
(14, 1),  -- Irrigation Pipe Repair -> Environmental
(15, 4),  -- Homework Help Club -> Education & Literacy
(16, 5),  -- Mental Health Awareness -> Health & Wellness
(17, 7),  -- Senior Tech Support Day -> Elder Care
(18, 10), -- Neighborhood Cleanup -> Community Development
(19, 1),  -- Trail Maintenance -> Environmental
(20, 5),  -- Yoga in the Park -> Health & Wellness
(21, 10); -- Mural Painting -> Community Development