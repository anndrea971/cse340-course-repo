import db from './db.js';

// Obtener todas las categorías (para la lista principal)
export const getCategories = async () => {
    const sql = "SELECT * FROM category ORDER BY name ASC";
    const result = await db.query(sql);
    return result.rows;
};

// NUEVA: Obtener detalle de una categoría y sus proyectos asociados
export const getCategoryDetails = async (category_id) => {
    // Buscamos los proyectos que tienen esta categoría usando el JOIN con la tabla intermedia
    const sql = `
        SELECT p.project_id, p.title, p.project_date 
        FROM projects p
        JOIN project_category pc ON p.project_id = pc.project_id
        WHERE pc.category_id = $1`;
    
    const projects = await db.query(sql, [category_id]);
    
    // También buscamos el nombre de la categoría misma
    const catName = await db.query("SELECT name FROM category WHERE category_id = $1", [category_id]);
    
    return {
        name: catName.rows[0]?.name,
        projects: projects.rows
    };
};