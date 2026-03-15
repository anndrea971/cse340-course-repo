import express from 'express';
import { fileURLToPath } from 'url';
import path from 'path';
import { testConnection } from './src/models/db.js';
import { getAllOrganizations } from './src/models/organizations.js';
// 1. Import the new project model function
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

// 2. Updated Projects Route
app.get("/projects", async (req, res) => {
  try {
    // Query your Postgres database
    const result = await pool.query(`
      SELECT 
        date AS project_date, 
        name AS title, 
        location AS organization_name
      FROM organization
      ORDER BY date
    `);

    console.log(result.rows);
    // Pass the rows into the template
    res.render("projects", { 
      title: "Service Projects", 
      projects: result.rows 
    });
  } catch (err) {
    console.error(err);
    res.status(500).send("Server error");
  }
});


app.get('/categories', async (_req, res) => {
  const title = 'Categories';
  res.render('categories', { title });
});

app.listen(PORT, () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    // Check connection separately if needed, but don't let it block the listen process
    testConnection().catch(err => console.error("DB Connection failed:", err));
});