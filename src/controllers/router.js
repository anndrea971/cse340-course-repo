import express from 'express'; 
import { showHomePage } from './index.js';
import { showOrganizationsPage, showOrganizationDetailsPage } from './organizations.js'; 
import { showProjectsPage, showProjectDetailsPage } from './projects.js'; // Added showProjectDetailsPage here
import { showCategoriesPage, showCategoryDetailsPage } from './categories.js';
import { testErrorPage } from './errors.js';

const router = express.Router();

// Home & General Lists
router.get('/', showHomePage);
router.get('/organizations', showOrganizationsPage);
router.get('/projects', showProjectsPage);
router.get('/categories', showCategoriesPage);

// --- New/Updated Detail Routes ---

// Route for organization details page
router.get('/organization/:id', showOrganizationDetailsPage);

// Route for specific project details page
router.get('/project/:id', showProjectDetailsPage); 

router.get('/category/:id', showCategoryDetailsPage);
// Error-handling routes
router.get('/test-error', testErrorPage);

export default router;