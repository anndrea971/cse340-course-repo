// src/models/categories.js
import db from './db.js';

export const getCategories = async () => {
    const sql = "SELECT * FROM category ORDER BY name ASC";
    const result = await db.query(sql);
    return result.rows;
};

export const getCategoryDetails = async (category_id) => {
    const sql = `
        SELECT p.project_id, p.title, p.project_date 
        FROM projects p
        JOIN project_category pc ON p.project_id = pc.project_id
        WHERE pc.category_id = $1`;
    const projects = await db.query(sql, [category_id]);
    const catName = await db.query("SELECT name FROM category WHERE category_id = $1", [category_id]);
    
    return {
        name: catName.rows[0]?.name,
        projects: projects.rows
    };
};

// --- AÑADE ESTA FUNCIÓN AQUÍ ---
// Esta es la que necesita el controlador de proyectos para no fallar
export const getCategoriesByProject = async (project_id) => {
    const sql = `
        SELECT c.category_id, c.name 
        FROM category c
        JOIN project_category pc ON c.category_id = pc.category_id
        WHERE pc.project_id = $1`;
    const result = await db.query(sql, [project_id]);
    return result.rows;
};