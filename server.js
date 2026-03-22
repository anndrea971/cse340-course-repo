import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
import { testConnection } from './src/models/db.js';
import { getAllOrganizations } from './src/models/organizations.js';
import { getAllProjects } from './src/models/projects.js'; 
import { getAllCategories } from './src/models/categories.js';

const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));
app.use((req, res, next) => {
    if (NODE_ENV === 'development') {
        console.log(`${req.method} ${req.url}`);
    }
    next(); // Pass control to the next middleware or route
});
// Middleware to make NODE_ENV available to all templates
app.use((req, res, next) => {
    res.locals.NODE_ENV = NODE_ENV;
    next();
});

/**
 * Routes
 */
app.get('/', async (_req, res) => {
    const title = 'Home';
    res.render('home', { title });
});

app.get('/organizations', async (_req, res) => {
  try {
    const organizations = await getAllOrganizations(); 
    res.render('organizations', { 
      title: 'Our Partners', 
      organizations: organizations 
    });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

app.get('/projects', async (_req, res) => {
  try {
    const projects = await getAllProjects(); 
    res.render('projects', { 
      title: 'Service Projects', 
      projects: projects 
    });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

app.get('/categories', async (_req, res) => {
  try {
    const categories = await getAllCategories();
    res.render('categories', { 
      title: 'Categories', 
      categories: categories 
    });
  } catch (error) {
    console.error(error);
    res.status(500).send("Internal Server Error");
  }
});

app.listen(PORT, () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    testConnection().catch(err => console.error("DB Connection failed:", err));
});