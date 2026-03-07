import { fileURLToPath } from 'url';
import path from 'path';
import express from 'express';

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

// 1. Declaración de variables
const NODE_ENV = process.env.NODE_ENV?.toLowerCase() || 'production';
const PORT = process.env.PORT || 3000;

const app = express();

// 2. AQUÍ VA EL MIDDLEWARE (Antes de las rutas)
/**
 * Configure Express middleware
 */
// Serve static files from the public directory
app.use(express.static(path.join(__dirname, 'public')));

// 3. RUTAS
app.get('/', (req, res) => {
    res.send('Hello from Express!');
});

// 4. INICIO DEL SERVIDOR
app.listen(PORT, () => {
    console.log(`Server is running at http://127.0.0.1:${PORT}`);
    console.log(`Environment: ${NODE_ENV}`);
});
