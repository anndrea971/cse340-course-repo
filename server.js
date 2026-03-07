import { fileURLToPath } from 'url';
import path from 'path';
import express from 'express';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 1. Declaración de variables
const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const app = express();

/**
 * Configure Express middleware
 */
// Serve static files from the public directory
app.use(express.static(path.join(__dirname, 'public')));

/**
 * Routes
 */
// Ruta para el Home (página de inicio)
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/home.html'));
});

// Ruta para Organizations
app.get('/organizations', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/organizations.html'));
});

// Ruta para Projects
app.get('/projects', (req, res) => {
    res.sendFile(path.join(__dirname, 'src/views/projects.html'));
});

// 4. Inicio del servidor
app.listen(PORT, () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    console.log(`Environment: ${NODE_ENV}`);
});
