import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
import { testConnection } from './src/models/db.js';
import { getAllOrganizations } from './src/models/organizations.js';
import { getAllProjects } from './src/models/projects.js'; 

const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

const app = express();

app.use(express.static(path.join(__dirname, 'public')));
app.set('view engine', 'ejs');
app.set('views', path.join(__dirname, 'src/views'));

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
    const projectsData = await getAllProjects();
    res.render('projects', { 
      title: 'Service Projects', 
      projects: projectsData || [] 
    });
  } catch (error) {
    console.error("Route Error:", error);
    res.render('projects', { 
      title: 'Service Projects', 
      projects: [] 
    });
  }
});

app.get('/categories', async (_req, res) => {
  const title = 'Categories';
  res.render('categories', { title });
});

app.listen(PORT, () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    testConnection().catch(err => console.error("DB Connection failed:", err));
});