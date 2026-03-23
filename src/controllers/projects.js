import { getUpcomingProjects, getProjectDetails } from '../models/projects.js';

const NUMBER_OF_UPCOMING_PROJECTS = 5;

// Updated function for the list page
const showProjectsPage = async (req, res) => {
    const projects = await getUpcomingProjects(NUMBER_OF_UPCOMING_PROJECTS);
    const title = 'Upcoming Service Projects';
    res.render('projects', { title, projects });
};

// New function for the single project details page
const showProjectDetailsPage = async (req, res) => {
    const id = req.params.id;
    const project = await getProjectDetails(id);
    res.render('project', { project });
};

export { showProjectsPage, showProjectDetailsPage };