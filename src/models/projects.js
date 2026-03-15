import pool from './db.js';

/* ***************************
 * Get all projects joined with organization names
 * ************************** */
export async function getAllProjects() {
  try {
    const sql = `SELECT p.*, o.name AS organization_name 
                 FROM public.projects p 
                 JOIN public.organizations o 
                 ON p.organization_id = o.organization_id 
                 ORDER BY p.project_date ASC`;
    const data = await pool.query(sql);
    return data.rows;
  } catch (error) {
    console.error("getAllProjects error: " + error);
    throw error;
  }
}
