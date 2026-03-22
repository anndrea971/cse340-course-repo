import express from 'express'; // Keep imports at the very top
import { showHomePage } from './index.js';
import { showOrganizationsPage, showOrganizationDetailsPage } from './organizations.js'; // Combined these
import { showProjectsPage } from './projects.js';
import { showCategoriesPage } from './categories.js';
import { testErrorPage } from './errors.js';

// 1. INITIALIZE FIRST (Move this up!)
const router = express.Router();

// 2. NOW USE IT (Routes follow initialization)
router.get('/', showHomePage);
router.get('/organizations', showOrganizationsPage);
router.get('/projects', showProjectsPage);
router.get('/categories', showCategoriesPage);

// Route for organization details page
router.get('/organization/:id', showOrganizationDetailsPage);

// Error-handling routes
router.get('/test-error', testErrorPage);

export default router;